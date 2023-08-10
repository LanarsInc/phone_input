import 'dart:async';

import 'package:phone_form_field/src/flags/flags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field_package.dart';
import 'package:phone_form_field/src/widgets/country_selector/country_selector_page.dart';

abstract class CountrySelectorNavigator {
  final List<IsoCode>? countries;
  final List<IsoCode>? favorites;
  final bool addFavoriteSeparator;
  final bool showCountryCode;
  final String? noResultMessage;
  final bool searchAutofocus; //TODO doesn't work for dropdown and second time for bottomSheet
  final TextStyle? countryCodeStyle;
  final TextStyle? countryNameStyle;
  final InputDecoration? searchInputDecoration;
  final TextStyle? searchInputTextStyle;
  final Color? defaultSearchInputIconColor;
  final ScrollPhysics? scrollPhysics;
  final double flagSize;
  final bool isFlagCircle;
  final bool useRootNavigator;
  final bool showCountryName;
  final bool showCountryFlag;
  final bool showSearchInput;
  final Color? bottomSheetDragHandlerColor;
  late final FlagCache _flagCache;

  CountrySelectorNavigator({
    this.countries,
    this.favorites,
    this.addFavoriteSeparator = true,
    this.showCountryCode = true,
    this.noResultMessage,
    required this.searchAutofocus,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.searchInputTextStyle,
    this.defaultSearchInputIconColor,
    this.searchInputDecoration,
    this.scrollPhysics,
    this.isFlagCircle = true,
    this.flagSize = 48,
    this.useRootNavigator = true,
    this.showCountryName = true,
    this.showCountryFlag = true,
    this.showSearchInput = true,
    this.bottomSheetDragHandlerColor,
  }) {
    _flagCache = FlagCache();
    _flagCache.preload(IsoCode.values.map((isoCode) => isoCode.name));
  }

  Future<Country?> requestCountrySelector(BuildContext context);

  CountrySelector _getCountrySelector({
    required ValueChanged<Country> onCountrySelected,
    required FlagCache flagCache,
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
      searchAutofocus: searchAutofocus,
      countryCodeStyle: countryCodeStyle,
      countryNameStyle: countryNameStyle,
      searchInputDecoration: searchInputDecoration,
      searchInputTextStyle: searchInputTextStyle,
      defaultSearchInputIconColor: defaultSearchInputIconColor,
      scrollPhysics: scrollPhysics,
      isFlagCircle: isFlagCircle,
      flagSize: flagSize,
      flagCache: flagCache,
      isBottomSheet: isBottomSheet,
      showCountryName: showCountryName,
      showCountryFlag: showCountryFlag,
      showSearchInput: showSearchInput,
      bottomSheetDragHandlerColor: bottomSheetDragHandlerColor,
    );
  }

  factory CountrySelectorNavigator.dialog({
    double? height,
    double? width,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    String? noResultMessage,
    bool searchAutofocus,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
    bool showCountryName,
    bool showCountryFlag,
  }) = DialogNavigator._;

  factory CountrySelectorNavigator.searchDelegate({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    String? noResultMessage,
    bool searchAutofocus,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
    bool showCountryName,
    bool showCountryFlag,
  }) = SearchDelegateNavigator._;

  factory CountrySelectorNavigator.bottomSheet({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    String? noResultMessage,
    bool searchAutofocus,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
    bool showCountryName,
    bool showCountryFlag,
  }) = BottomSheetNavigator._;

  factory CountrySelectorNavigator.modalBottomSheet({
    double? height,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    String? noResultMessage,
    bool searchAutofocus,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
    bool showCountryName,
    bool showCountryFlag,
  }) = ModalBottomSheetNavigator._;

  factory CountrySelectorNavigator.draggableBottomSheet({
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
    bool searchAutofocus,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    bool isFlagCircle,
    bool showCountryName,
    bool showCountryFlag,
  }) = DraggableModalBottomSheetNavigator._;

  factory CountrySelectorNavigator.dropdown({
    double listHeight,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addFavoriteSeparator,
    bool showCountryCode,
    bool showSearchInput,
    TextStyle? countryCodeStyle,
    TextStyle? countryNameStyle,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
    double? offsetHeight,
    bool showCountryName,
    bool showCountryFlag,
    String? noResultMessage,
    bool searchAutofocus,
    InputDecoration? searchInputDecoration,
    TextStyle? searchInputTextStyle,
    Color? defaultSearchInputIconColor,
    bool useRootNavigator,
    Color? backgroundColor,
    required LayerLink layerLink,
  }) = DropdownNavigator._;
}

class DialogNavigator extends CountrySelectorNavigator {
  final double? height;
  final double? width;

  DialogNavigator._({
    this.width,
    this.height,
    super.showSearchInput = true,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.flagSize = 48,
    super.isFlagCircle = true,
    super.showCountryName = true,
    super.showCountryFlag = true,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          width: width,
          height: height,
          child: _getCountrySelector(
            isBottomSheet: false,
            onCountrySelected: (country) => Navigator.of(context, rootNavigator: true).pop(country),
            flagCache: _flagCache,
          ),
        ),
      ),
    );
  }
}

class SearchDelegateNavigator extends CountrySelectorNavigator {
  SearchDelegateNavigator._({
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.flagSize = 48,
    super.isFlagCircle = true,
    super.showCountryName = true,
    super.showCountryFlag = true,
  });

  CountrySelectorSearchDelegate _getCountrySelectorSearchDelegate({
    required ValueChanged<Country> onCountrySelected,
    required FlagCache flagCache,
    ScrollController? scrollController,
  }) {
    return CountrySelectorSearchDelegate(
      onCountrySelected: onCountrySelected,
      scrollController: scrollController,
      addFavoritesSeparator: addFavoriteSeparator,
      countries: countries,
      favoriteCountries: favorites ?? [],
      noResultMessage: noResultMessage,
      searchAutofocus: searchAutofocus,
      showCountryCode: showCountryCode,
      countryNameStyle: countryNameStyle,
      countryCodeStyle: countryCodeStyle,
      flagCache: flagCache,
      flagSize: flagSize,
      isFlagCircle: isFlagCircle,
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
        flagCache: _flagCache,
      ),
    );
  }
}

class BottomSheetNavigator extends CountrySelectorNavigator {

  BottomSheetNavigator._({
    super.showSearchInput = true,
    super.bottomSheetDragHandlerColor,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.flagSize = 48,
    super.isFlagCircle = true,
    super.showCountryName = true,
    super.showCountryFlag = true,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    Country? selected;
    final ctrl = showBottomSheet(
      context: context,
      builder: (_) => MediaQuery(
        data: MediaQueryData.fromView(View.of(context)),
        child: SafeArea(
          child: _getCountrySelector(
            isBottomSheet: true,
            onCountrySelected: (country) {
              selected = country;
              Navigator.pop(context, country);
            },
            flagCache: _flagCache,
          ),
        ),
      ),
    );
    return ctrl.closed.then((_) => selected);
  }
}

class ModalBottomSheetNavigator extends CountrySelectorNavigator {
  final double? height;

  ModalBottomSheetNavigator._({
    this.height,
    super.showSearchInput = true,
    super.bottomSheetDragHandlerColor,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.flagSize = 48,
    super.isFlagCircle = true,
    super.showCountryName = true,
    super.showCountryFlag = true,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    return showModalBottomSheet<Country>(
      context: context,
      builder: (_) => SizedBox(
        height: height ?? MediaQuery.of(context).size.height - 90,
        child: _getCountrySelector(
          isBottomSheet: true,
          onCountrySelected: (country) => Navigator.pop(context, country),
          flagCache: _flagCache,
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

  DraggableModalBottomSheetNavigator._({
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
    super.isFlagCircle = true,
    super.flagSize = 40,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.scrollPhysics,
    super.useRootNavigator = true,
    super.showCountryName = true,
    super.showCountryFlag = true,
  });

  @override
  Future<Country?> requestCountrySelector(BuildContext context) {
    final effectiveBorderRadius = borderRadius ??
        const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );
    return showModalBottomSheet<Country>(
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
              flagCache: _flagCache,
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

  DropdownNavigator._({
    required this.layerLink,
    this.listHeight = 300,
    this.offsetHeight,
    this.backgroundColor,
    super.showSearchInput = false,
    super.countries,
    super.favorites,
    super.addFavoriteSeparator = true,
    super.showCountryCode = true,
    super.searchAutofocus = kIsWeb,
    super.countryCodeStyle,
    super.countryNameStyle,
    super.scrollPhysics,
    super.flagSize = 48,
    super.isFlagCircle = true,
    super.noResultMessage,
    super.searchInputDecoration,
    super.searchInputTextStyle,
    super.defaultSearchInputIconColor,
    super.useRootNavigator = true,
    super.showCountryName = true,
    super.showCountryFlag = true,
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
            children: [
              CompositedTransformFollower(
                offset: offsetHeight != null
                    ? Offset(0, size.height).translate(0, offsetHeight!)
                    : Offset(0, size.height),
                link: layerLink,
                showWhenUnlinked: false,
                child: Material(
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
                      flagCache: _flagCache,
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
