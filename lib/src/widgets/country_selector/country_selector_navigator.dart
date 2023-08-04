import 'package:phone_form_field/src/flags/flags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:phone_form_field/src/widgets/country_selector/country_selector_page.dart';

abstract class CountrySelectorNavigator {
  final List<IsoCode>? countries;
  final List<IsoCode>? favorites;
  final bool addSeparator;
  final bool showCountryCode;
  final bool sortCountries;
  final String? noResultMessage;
  final bool searchAutofocus;
  final bool showSearchInput;
  final TextStyle? subtitleStyle;
  final TextStyle? titleStyle;
  final InputDecoration? searchBoxDecoration;
  final TextStyle? searchBoxTextStyle;
  final Color? searchBoxIconColor;
  final Color? bottomSheetDragHandlerColor;
  final ScrollPhysics? scrollPhysics;
  final double flagSize;
  final bool isFlagCircle;
  final bool useRootNavigator;

  const CountrySelectorNavigator({
    this.countries,
    this.favorites,
    this.addSeparator = true,
    this.showCountryCode = true,
    this.sortCountries = false,
    this.noResultMessage,
    required this.searchAutofocus,
    this.showSearchInput = true,
    this.subtitleStyle,
    this.titleStyle,
    this.searchBoxTextStyle,
    this.bottomSheetDragHandlerColor,
    this.searchBoxIconColor,
    this.searchBoxDecoration,
    this.scrollPhysics,
    this.isFlagCircle = true,
    this.flagSize = 48,
    this.useRootNavigator = true,
  });

  Future<Country?> navigate(BuildContext context, FlagCache flagCache);

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
      addFavoritesSeparator: addSeparator,
      showCountryCode: showCountryCode,
      noResultMessage: noResultMessage,
      scrollController: scrollController,
      searchAutofocus: searchAutofocus,
      showSearchInput: showSearchInput,
      subtitleStyle: subtitleStyle,
      titleStyle: titleStyle,
      searchBoxDecoration: searchBoxDecoration,
      searchBoxTextStyle: searchBoxTextStyle,
      searchBoxIconColor: searchBoxIconColor,
      bottomSheetDragHandlerColor: bottomSheetDragHandlerColor,
      scrollPhysics: scrollPhysics,
      isFlagCircle: isFlagCircle,
      flagSize: flagSize,
      flagCache: flagCache,
      isBottomSheet: isBottomSheet,
    );
  }

  const factory CountrySelectorNavigator.dialog({
    double? height,
    double? width,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator,
    bool showCountryCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    bool showSearchInput,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
  }) = DialogNavigator._;

  const factory CountrySelectorNavigator.searchDelegate({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator,
    bool showCountryCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
  }) = SearchDelegateNavigator._;

  const factory CountrySelectorNavigator.bottomSheet({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator,
    bool showCountryCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    bool showSearchInput,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
  }) = BottomSheetNavigator._;

  const factory CountrySelectorNavigator.modalBottomSheet({
    double? height,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator,
    bool showCountryCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    bool showSearchInput,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    double flagSize,
    bool isFlagCircle,
  }) = ModalBottomSheetNavigator._;

  const factory CountrySelectorNavigator.draggableBottomSheet({
    double initialChildSize,
    double minChildSize,
    double maxChildSize,
    BorderRadiusGeometry? borderRadius,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator,
    bool showCountryCode,
    double flagSize,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    bool showSearchInput,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    bool isFlagCircle,
  }) = DraggableModalBottomSheetNavigator._;
}

class DialogNavigator extends CountrySelectorNavigator {
  final double? height;
  final double? width;

  const DialogNavigator._({
    this.width,
    this.height,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
    bool showSearchInput = true,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
    double flagSize = 48,
    bool isFlagCircle = true,
  }) : super(
          countries: countries,
          favorites: favorites,
          addSeparator: addSeparator,
          showCountryCode: showCountryCode,
          sortCountries: sortCountries,
          noResultMessage: noResultMessage,
          searchAutofocus: searchAutofocus,
          showSearchInput: showSearchInput,
          subtitleStyle: subtitleStyle,
          titleStyle: titleStyle,
          searchBoxDecoration: searchBoxDecoration,
          searchBoxTextStyle: searchBoxTextStyle,
          searchBoxIconColor: searchBoxIconColor,
          scrollPhysics: scrollPhysics,
          flagSize: flagSize,
          isFlagCircle: isFlagCircle,
        );

  @override
  Future<Country?> navigate(BuildContext context, FlagCache flagCache) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          width: width,
          height: height,
          child: _getCountrySelector(
            isBottomSheet: false,
            onCountrySelected: (country) => Navigator.of(context, rootNavigator: true).pop(country),
            flagCache: flagCache,
          ),
        ),
      ),
    );
  }
}

class SearchDelegateNavigator extends CountrySelectorNavigator {
  const SearchDelegateNavigator._({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
    double flagSize = 48,
    bool isFlagCircle = true,
  }) : super(
          countries: countries,
          favorites: favorites,
          addSeparator: addSeparator,
          showCountryCode: showCountryCode,
          sortCountries: sortCountries,
          noResultMessage: noResultMessage,
          searchAutofocus: searchAutofocus,
          subtitleStyle: subtitleStyle,
          titleStyle: titleStyle,
          searchBoxDecoration: searchBoxDecoration,
          searchBoxTextStyle: searchBoxTextStyle,
          searchBoxIconColor: searchBoxIconColor,
          scrollPhysics: scrollPhysics,
          flagSize: flagSize,
          isFlagCircle: isFlagCircle,
        );

  CountrySelectorSearchDelegate _getCountrySelectorSearchDelegate({
    required ValueChanged<Country> onCountrySelected,
    required FlagCache flagCache,
    ScrollController? scrollController,
  }) {
    return CountrySelectorSearchDelegate(
      onCountrySelected: onCountrySelected,
      scrollController: scrollController,
      addFavoritesSeparator: addSeparator,
      countries: countries,
      favoriteCountries: favorites ?? [],
      noResultMessage: noResultMessage,
      searchAutofocus: searchAutofocus,
      showCountryCode: showCountryCode,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      flagCache: flagCache,
    );
  }

  @override
  Future<Country?> navigate(BuildContext context, FlagCache flagCache) {
    return showSearch(
      context: context,
      delegate: _getCountrySelectorSearchDelegate(
        onCountrySelected: (country) => Navigator.pop(context, country),
        flagCache: flagCache,
      ),
    );
  }
}

class BottomSheetNavigator extends CountrySelectorNavigator {
  const BottomSheetNavigator._({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
    bool showSearchInput = true,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    double flagSize = 48,
    bool isFlagCircle = true,
  }) : super(
          countries: countries,
          favorites: favorites,
          addSeparator: addSeparator,
          showCountryCode: showCountryCode,
          sortCountries: sortCountries,
          noResultMessage: noResultMessage,
          searchAutofocus: searchAutofocus,
          showSearchInput: showSearchInput,
          subtitleStyle: subtitleStyle,
          titleStyle: titleStyle,
          searchBoxDecoration: searchBoxDecoration,
          searchBoxTextStyle: searchBoxTextStyle,
          searchBoxIconColor: searchBoxIconColor,
          bottomSheetDragHandlerColor: bottomSheetDragHandlerColor,
          scrollPhysics: scrollPhysics,
          flagSize: flagSize,
          isFlagCircle: isFlagCircle,
        );

  @override
  Future<Country?> navigate(BuildContext context, FlagCache flagCache) {
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
            flagCache: flagCache,
          ),
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
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
    bool showSearchInput = true,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    double flagSize = 48,
    bool isFlagCircle = true,
  }) : super(
          countries: countries,
          favorites: favorites,
          addSeparator: addSeparator,
          showCountryCode: showCountryCode,
          sortCountries: sortCountries,
          noResultMessage: noResultMessage,
          searchAutofocus: searchAutofocus,
          showSearchInput: showSearchInput,
          subtitleStyle: subtitleStyle,
          titleStyle: titleStyle,
          searchBoxDecoration: searchBoxDecoration,
          searchBoxTextStyle: searchBoxTextStyle,
          searchBoxIconColor: searchBoxIconColor,
          bottomSheetDragHandlerColor: bottomSheetDragHandlerColor,
          scrollPhysics: scrollPhysics,
          flagSize: flagSize,
          isFlagCircle: isFlagCircle,
        );

  @override
  Future<Country?> navigate(
    BuildContext context,
    FlagCache flagCache,
  ) {
    return showModalBottomSheet<Country>(
      context: context,
      builder: (_) => SizedBox(
        height: height ?? MediaQuery.of(context).size.height - 90,
        child: _getCountrySelector(
          isBottomSheet: true,
          onCountrySelected: (country) => Navigator.pop(context, country),
          flagCache: flagCache,
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
    this.initialChildSize = 0.7,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.85,
    this.borderRadius,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    bool isFlagCircle = true,
    double flagSize = 40,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
    bool showSearchInput = true,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    Color? bottomSheetDragHandlerColor,
    ScrollPhysics? scrollPhysics,
    bool useRootNavigator = true,
  }) : super(
          countries: countries,
          favorites: favorites,
          addSeparator: addSeparator,
          showCountryCode: showCountryCode,
          sortCountries: sortCountries,
          noResultMessage: noResultMessage,
          searchAutofocus: searchAutofocus,
          showSearchInput: showSearchInput,
          subtitleStyle: subtitleStyle,
          titleStyle: titleStyle,
          searchBoxDecoration: searchBoxDecoration,
          searchBoxTextStyle: searchBoxTextStyle,
          searchBoxIconColor: searchBoxIconColor,
          bottomSheetDragHandlerColor: bottomSheetDragHandlerColor,
          scrollPhysics: scrollPhysics,
          flagSize: flagSize,
          isFlagCircle: isFlagCircle,
        );

  @override
  Future<Country?> navigate(BuildContext context, FlagCache flagCache) {
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
              flagCache: flagCache,
            ),
          );
        },
      ),
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
    );
  }
}
