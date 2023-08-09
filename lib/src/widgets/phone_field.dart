import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:phone_form_field/phone_form_field_package.dart';
import 'package:phone_form_field/src/flags/flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_form_field/src/constants/custom_max_length_formatter.dart';
import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:phone_form_field/src/constants/patterns.dart';
import 'package:phone_form_field/src/controllers/phone_field_controller.dart';

/// Phone field
///
/// This deals with mostly UI and has no dependency on any phone parser library
class PhoneField extends StatefulWidget {
  final PhoneFieldController controller;
  final bool showFlagInInput;
  final String? errorText;
  final double flagSize;
  final bool isFlagCircle;
  final InputDecoration decoration;
  final bool isCountrySelectionEnabled;
  final bool isCountryChipPersistent; //TODO doesn't work correctly first time

  /// configures the way the country picker selector is shown
  final CountrySelectorNavigator selectorNavigator;

  // textfield inputs
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextStyle? countryCodeStyle;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final bool? showCursor;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  bool get selectionEnabled => enableInteractiveSelection;
  final MouseCursor? mouseCursor;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final List<TextInputFormatter>? inputFormatters;

  const PhoneField({
    // form field params
    Key? key,
    required this.controller,
    required this.showFlagInInput,
    required this.selectorNavigator,
    required this.flagSize,
    required this.isFlagCircle,
    required this.errorText,
    required this.decoration,
    required this.isCountrySelectionEnabled,
    required this.isCountryChipPersistent,
    // textfield  inputs
    required this.keyboardType,
    required this.textInputAction,
    required this.style,
    required this.countryCodeStyle,
    required this.strutStyle,
    required this.textAlign,
    required this.textAlignVertical,
    required this.autofocus,
    required this.obscuringCharacter,
    required this.obscureText,
    required this.autocorrect,
    required this.smartDashesType,
    required this.smartQuotesType,
    required this.enableSuggestions,
    required this.contextMenuBuilder,
    required this.showCursor,
    required this.onEditingComplete,
    required this.onSubmitted,
    required this.onAppPrivateCommand,
    required this.enabled,
    required this.cursorWidth,
    required this.cursorHeight,
    required this.cursorRadius,
    required this.cursorColor,
    required this.selectionHeightStyle,
    required this.selectionWidthStyle,
    required this.keyboardAppearance,
    required this.scrollPadding,
    required this.enableInteractiveSelection,
    required this.selectionControls,
    required this.mouseCursor,
    required this.scrollPhysics,
    required this.scrollController,
    required this.autofillHints,
    required this.restorationId,
    required this.enableIMEPersonalizedLearning,
    required this.inputFormatters,
  }) : super(key: key);

  @override
  PhoneFieldState createState() => PhoneFieldState();
}

class PhoneFieldState extends State<PhoneField> {
  PhoneFieldController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.focusNode.addListener(onFocusChange);
  }

  void onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.focusNode.removeListener(onFocusChange);
    super.dispose();
  }

  void selectCountry() async {
    if (!widget.isCountrySelectionEnabled) {
      return;
    }
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    final selected = await widget.selectorNavigator.requestCountrySelector(context);
    if (selected != null) {
      controller.isoCode = selected.isoCode;
    }
    controller.focusNode.requestFocus();
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  @override
  Widget build(BuildContext context) {
    // the idea here is to have a mouse region that surround the input which
    // contains a flag button and a text field. The text field is surrounded
    // by padding so we want to request focus even when clicking outside of the
    // inner field.
    // When the country chip is not shown it request focus to the inner text
    // field which doesn't span the whole input
    // When the country chip is shown, clicking on it request country selection
    final maxTextFieldLength =
        MetadataFinder.getMetadataLengthForIsoCode(controller.isoCode).fixedLine.last;
    final item = MouseRegion(
      cursor: SystemMouseCursors.text,
      child: GestureDetector(
        onTap: controller.focusNode.requestFocus,
        // absorb pointer when the country chip is not shown, else flutter
        // still allows the country chip to be clicked even though it is not shown
        child: InputDecorator(
          decoration: _getOutterInputDecoration(),
          isFocused: controller.focusNode.hasFocus,
          isEmpty: _isEffectivelyEmpty(),
          child: TextField(
            focusNode: controller.focusNode,
            controller: controller.nationalNumberController,
            enabled: widget.enabled,
            decoration: _getInnerInputDecoration(),
            inputFormatters: widget.inputFormatters ??
                [
                  CustomMaxLengthFormatter(maxTextFieldLength),
                  FilteringTextInputFormatter.allow(
                      RegExp('[${Patterns.plus}${Patterns.digits}${Patterns.punctuation}]')),
                ],
            autofillHints: widget.autofillHints,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            style: widget.style,
            strutStyle: widget.strutStyle,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            autofocus: widget.autofocus,
            obscuringCharacter: widget.obscuringCharacter,
            obscureText: widget.obscureText,
            autocorrect: widget.autocorrect,
            smartDashesType: widget.smartDashesType,
            smartQuotesType: widget.smartQuotesType,
            enableSuggestions: widget.enableSuggestions,
            contextMenuBuilder: widget.contextMenuBuilder,
            showCursor: widget.showCursor,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            onAppPrivateCommand: widget.onAppPrivateCommand,
            cursorWidth: widget.cursorWidth,
            cursorHeight: widget.cursorHeight,
            cursorRadius: widget.cursorRadius,
            cursorColor: widget.cursorColor,
            selectionHeightStyle: widget.selectionHeightStyle,
            selectionWidthStyle: widget.selectionWidthStyle,
            keyboardAppearance: widget.keyboardAppearance,
            scrollPadding: widget.scrollPadding,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            selectionControls: widget.selectionControls,
            mouseCursor: widget.mouseCursor,
            scrollController: widget.scrollController,
            scrollPhysics: widget.scrollPhysics,
            restorationId: widget.restorationId,
            enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          ),
        ),
      ),
    );
    final navigator = widget.selectorNavigator;
    if (navigator is DropdownNavigator) {
      return CompositedTransformTarget(link: navigator.layerLink, child: item);
    }

    return item;
  }

  Widget _getCountryCodeChip() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: selectCountry,
          // material here else the click pass through empty spaces
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: !widget.showFlagInInput
                  ? EdgeInsets.zero
                  : const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: CountryCodeChip(
                key: const ValueKey('country-code-chip'),
                isoCode: controller.isoCode,
                showFlag: widget.showFlagInInput,
                textStyle: widget.countryCodeStyle ??
                    widget.decoration.labelStyle ??
                    TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                flagSize: widget.flagSize,
                isFlagCircle: widget.isFlagCircle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _getInnerInputDecoration() {
    return InputDecoration.collapsed(
      hintText: widget.decoration.hintText,
      hintStyle: widget.decoration.hintStyle,
    ).copyWith(
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }

  InputDecoration _getOutterInputDecoration() {
    final directionality = Directionality.of(context);

    return widget.decoration.copyWith(
      hintText: null,
      errorText: widget.errorText,
      prefix: directionality == TextDirection.ltr ? _getCountryCodeChip() : null,
      suffix: directionality == TextDirection.rtl ? _getCountryCodeChip() : null,
    );
  }

  bool _isEffectivelyEmpty() {
    if (widget.isCountryChipPersistent) return false;
    final outterDecoration = _getOutterInputDecoration();
    // when there is not label and an hint text we need to have
    // isEmpty false so the country code is displayed along the
    // hint text to not have the hint text in the middle
    if (outterDecoration.label == null && outterDecoration.hintText != null) {
      return false;
    }
    return controller.nationalNumberController.text.isEmpty;
  }
}
