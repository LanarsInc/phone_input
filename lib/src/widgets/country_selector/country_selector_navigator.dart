import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phone_input/phone_input_package.dart';
import 'package:phone_input/src/widgets/country_selector/country_selector_page.dart';

abstract class CountrySelectorNavigator {
  final List<IsoCode>? countries;
  final List<IsoCode>? favorites;
  final bool addFavoriteSeparator;
  final bool showCountryCode;
  final String? noResultMessage;
  final TextStyle? countryCodeStyle;
  final TextStyle? countryNameStyle;
  final InputDecoration? searchInputDecoration;
  final TextStyle? searchInputTextStyle;
  final Color? defaultSearchInputIconColor;
  final ScrollPhysics? scrollPhysics;
  final double flagSize;
  final BoxShape flagShape;
  final bool useRootNavigator;
  final bool showCountryName;
  final bool showCountryFlag;
  final bool showSearchInput;
  final Color? bottomSheetDragHandlerColor;
  final double? searchInputHeight;
  final double? searchInputWidth;

  const CountrySelectorNavigator({
    this.countries,
    this.favorites,
    this.addFavoriteSeparator = true,
    this.showCountryCode = true,
    this.noResultMessage,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.searchInputTextStyle,
    this.defaultSearchInputIconColor,
    this.searchInputDecoration,
    this.scrollPhysics,
    this.flagShape = BoxShape.circle,
    this.flagSize = 48,
    this.useRootNavigator = true,
    this.showCountryName = true,
    this.showCountryFlag = true,
    this.showSearchInput = true,
    this.bottomSheetDragHandlerColor,
    this.searchInputWidth,
    this.searchInputHeight,
  });

  Future<Country?> requestCountrySelector(BuildContext context);

  CountrySelector _getCountrySelector({
    required ValueChanged<Country> onCountrySelected,
    required bool isBottomSheet,
    ScrollController? scrollController,
  }) {
    return CountrySelector(
      countries: countries,
      onCountrySelected: onCountrySelected,
      favoriteCountries: favorites ?? [],
      addFavouriteSeparator: addFavoriteSeparator,
      showCountryCode: showCountryCode,
      noResultMessage: noResultMessage,
      scrollController: scrollController,
      countryCodeStyle: countryCodeStyle,
      countryNameStyle: countryNameStyle,
      searchInputDecoration: searchInputDecoration,
      searchInputTextStyle: searchInputTextStyle,
      defaultSearchInputIconColor: defaultSearchInputIconColor,
      scrollPhysics: scrollPhysics,
      flagShape: flagShape,
      flagSize: flagSize,
      isBottomSheet: isBottomSheet,
      showCountryName: showCountryName,
      showCountryFlag: showCountryFlag,
      showSearchInput: showSearchInput,
      bottomSheetDragHandlerColor: bottomSheetDragHandlerColor,
      searchInputHeight: searchInputHeight,
      searchInputWidth: searchInputWidth,
    );
  }

  const factory CountrySelectorNavigator.dialog({
    double? height,
    double? width,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    String? noResultMessage,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    BoxShape flagShape,
    bool showCountryName,
    bool showCountryFlag,
    double? searchInputHeight,
    double? searchInputWidth,
  }) = DialogNavigator._;

  const factory CountrySelectorNavigator.searchDelegate({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    String? noResultMessage,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    BoxShape flagShape,
    bool showCountryName,
    bool showCountryFlag,
  }) = SearchDelegateNavigator._;

  const factory CountrySelectorNavigator.bottomSheet({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    String? noResultMessage,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    BoxShape flagShape,
    bool showCountryName,
    bool showCountryFlag,
    double? searchInputHeight,
    double? searchInputWidth,
  }) = BottomSheetNavigator._;

  const factory CountrySelectorNavigator.modalBottomSheet({
    double? height,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    String? noResultMessage,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    BoxShape flagShape,
    bool showCountryName,
    bool showCountryFlag,
    double? searchInputHeight,
    double? searchInputWidth,
  }) = ModalBottomSheetNavigator._;

  const factory CountrySelectorNavigator.draggableBottomSheet({
    double initialChildSize,
    double minChildSize,
    double maxChildSize,
    BorderRadiusGeometry? borderRadius,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    double flagSize,
    String? noResultMessage,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    BoxShape flagShape,
    bool showCountryName,
    bool showCountryFlag,
    double? searchInputHeight,
    double? searchInputWidth,
  }) = DraggableModalBottomSheetNavigator._;

  const factory CountrySelectorNavigator.dropdown({
    required LayerLink layerLink,
    BorderRadiusGeometry? borderRadius,
    double listHeight,
    Color? backgroundColor,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    BoxShape flagShape,
    double? offsetHeight,
    bool showCountryName,
    bool showCountryFlag,
    String? noResultMessage,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    bool useRootNavigator,
    double? searchInputHeight,
    double? searchInputWidth,
  }) = DropdownNavigator._;
}

class DialogNavigator extends CountrySelectorNavigator {
  final double? height;
  final double? width;

  const DialogNavigator._({
    this.width,
    this.height,
    super.showSearchInput = true,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.noResultMessage,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.flagSize = 48,
    super.flagShape = BoxShape.circle,
    super.showCountryName = true,
    super.showCountryFlag = true,
    super.searchInputHeight,
    super.searchInputWidth,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: width,
          height: height,
          child: _getCountrySelector(
            isBottomSheet: false,
            onCountrySelected: (country) =>
                Navigator.of(context, rootNavigator: true).pop(country),
          ),
        ),
      ),
    );
  }
}

class SearchDelegateNavigator extends CountrySelectorNavigator {
  const SearchDelegateNavigator._({
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.noResultMessage,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.scrollPhysics,
    super.flagSize = 48,
    super.flagShape = BoxShape.circle,
    super.showCountryName = true,
    super.showCountryFlag = true,
  });

  CountrySelectorSearchDelegate _getCountrySelectorSearchDelegate({
    required ValueChanged<Country> onCountrySelected,
    ScrollController? scrollController,
  }) {
    return CountrySelectorSearchDelegate(
      scrollPhysics: scrollPhysics,
      onCountrySelected: onCountrySelected,
      scrollController: scrollController,
      addFavoritesSeparator: addFavoriteSeparator,
      countries: countries,
      favoriteCountries: favorites ?? [],
      noResultMessage: noResultMessage,
      showCountryCode: showCountryCode,
      countryNameStyle: countryNameStyle,
      countryCodeStyle: countryCodeStyle,
      flagSize: flagSize,
      flagShape: flagShape,
      showCountryFlag: showCountryFlag,
      showCountryName: showCountryName,
    );
  }

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    return showSearch(
      context: context,
      delegate: _getCountrySelectorSearchDelegate(
        onCountrySelected: (country) => Navigator.pop(context, country),
      ),
    );
  }
}

class BottomSheetNavigator extends CountrySelectorNavigator {
  const BottomSheetNavigator._({
    super.showSearchInput = true,
    super.bottomSheetDragHandlerColor,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.noResultMessage,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.flagSize = 48,
    super.flagShape = BoxShape.circle,
    super.showCountryName = true,
    super.showCountryFlag = true,
    super.searchInputHeight,
    super.searchInputWidth,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    Country? selected;
    final ctrl = showBottomSheet(
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (_) => SafeArea(
        child: _getCountrySelector(
          isBottomSheet: true,
          onCountrySelected: (country) {
            selected = country;
            Navigator.pop(context, country);
          },
        ),
      ),
    );
    return ctrl.closed.then((_) => selected);
  }
}

class ModalBottomSheetNavigator extends CountrySelectorNavigator {
  final double? height;

  const ModalBottomSheetNavigator._({
    this.height,
    super.showSearchInput = true,
    super.bottomSheetDragHandlerColor,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.noResultMessage,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.flagSize = 48,
    super.flagShape = BoxShape.circle,
    super.showCountryName = true,
    super.showCountryFlag = true,
    super.searchInputHeight,
    super.searchInputWidth,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    return showModalBottomSheet<Country>(
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (_) => SizedBox(
        height: height ?? MediaQuery.of(context).size.height - 90,
        child: _getCountrySelector(
          isBottomSheet: true,
          onCountrySelected: (country) => Navigator.pop(context, country),
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class DraggableModalBottomSheetNavigator extends CountrySelectorNavigator {
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final BorderRadiusGeometry? borderRadius;

  const DraggableModalBottomSheetNavigator._({
    super.showSearchInput = true,
    super.bottomSheetDragHandlerColor,
    this.initialChildSize = 0.7,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.85,
    this.borderRadius,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.flagShape = BoxShape.circle,
    super.flagSize = 40,
    super.noResultMessage,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.useRootNavigator = true,
    super.showCountryName = true,
    super.showCountryFlag = true,
    super.searchInputHeight,
    super.searchInputWidth,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    final effectiveBorderRadius = borderRadius ??
        const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );
    return showModalBottomSheet<Country>(
      clipBehavior: Clip.hardEdge,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: ShapeDecoration(
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: effectiveBorderRadius,
              ),
            ),
            child: _getCountrySelector(
              isBottomSheet: true,
              onCountrySelected: (country) => Navigator.pop(context, country),
              scrollController: scrollController,
            ),
          );
        },
      ),
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
    );
  }
}

class DropdownNavigator extends CountrySelectorNavigator {
  final double listHeight;
  final double? offsetHeight;
  final LayerLink layerLink;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  const DropdownNavigator._({
    required this.layerLink,
    this.listHeight = 300,
    this.offsetHeight,
    this.backgroundColor,
    this.borderRadius,
    super.showSearchInput = false,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.scrollPhysics,
    super.flagSize = 48,
    super.flagShape = BoxShape.circle,
    super.noResultMessage,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.useRootNavigator = true,
    super.showCountryName = true,
    super.showCountryFlag = true,
    super.searchInputHeight,
    super.searchInputWidth,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) async {
    OverlayEntry? dropdownOverlayEntry;
    final completer = Completer<Country?>();

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    dropdownOverlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            dropdownOverlayEntry?.remove();
            completer.complete(null);
          },
          behavior: HitTestBehavior.translucent,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              CompositedTransformFollower(
                offset: offsetHeight != null
                    ? Offset(0, size.height).translate(0, offsetHeight!)
                    : Offset(0, size.height),
                link: layerLink,
                showWhenUnlinked: false,
                child: Material(
                  borderRadius: borderRadius,
                  color: backgroundColor,
                  child: SizedBox(
                    height: listHeight,
                    width: size.width,
                    child: _getCountrySelector(
                      isBottomSheet: false,
                      onCountrySelected: (country) {
                        completer.complete(country);
                        dropdownOverlayEntry?.remove();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    Overlay.of(context).insert(dropdownOverlayEntry);

    return completer.future;
  }
}
