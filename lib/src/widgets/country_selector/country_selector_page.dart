import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/l10n/generated/phone_field_localization.dart';
import 'package:phone_form_field/l10n/generated/phone_field_localization_en.dart';
import 'package:phone_form_field/src/number_parser/models/iso_code.dart';
import 'package:phone_form_field/src/widgets/country_selector/localized_country_registry.dart';

import 'country_finder.dart';
import 'country.dart';
import 'country_list.dart';

class CountrySelectorSearchDelegate extends SearchDelegate<Country> {
  late CountryFinder _countryFinder;
  late CountryFinder _favoriteCountryFinder;

  /// List of countries to display in the selector
  /// Value optional in constructor.
  /// when omitted, the full country list is displayed
  final List<IsoCode> countriesIso;

  /// Callback triggered when user select a country
  final ValueChanged<Country> onCountrySelected;

  /// ListView.builder scroll controller (ie: [ScrollView.controller])
  final ScrollController? scrollController;

  /// The [ScrollPhysics] of the Country List
  final ScrollPhysics? scrollPhysics;

  /// Determine the countries to be displayed on top of the list
  /// Check [addFavoritesSeparator] property to enable/disable adding a
  /// list divider between favorites and others defaults countries
  final List<IsoCode> favoriteCountriesIso;

  /// Whether to add a list divider between favorites & defaults
  /// countries.
  final bool addFavoritesSeparator;

  /// Whether to show the country country code (ie: +1 / +33 /...)
  /// as a listTile subtitle
  final bool showCountryCode;

  /// The message displayed instead of the list when the search has no results
  final String? noResultMessage;

  /// Whether the search input is auto focussed
  final bool searchAutofocus;

  /// The size factor for displaying flags within the UI.
  final double flagSize;

  /// Determines if the displayed flags should be circular.
  final bool isFlagCircle;

  /// Determines if the country name should be shown.
  final bool showCountryName;

  /// Determines if the country flag should be shown
  final bool showCountryFlag;

  /// Override default title TextStyle
  final TextStyle? countryNameStyle;

  /// Override default subtitle TextStyle
  final TextStyle? countryCodeStyle;

  LocalizedCountryRegistry? _localizedCountryRegistry;

  CountrySelectorSearchDelegate({
    Key? key,
    required this.onCountrySelected,
    this.scrollController,
    this.scrollPhysics,
    this.addFavoritesSeparator = true,
    this.showCountryCode = false,
    this.noResultMessage,
    List<IsoCode> favoriteCountries = const [],
    List<IsoCode>? countries,
    this.searchAutofocus = kIsWeb,
    this.flagSize = 48,
    this.isFlagCircle = true,
    this.countryNameStyle,
    this.countryCodeStyle,
    this.showCountryName = true,
    this.showCountryFlag = true,
  })  : countriesIso = countries ?? IsoCode.values,
        favoriteCountriesIso = favoriteCountries;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  void _initIfRequired(BuildContext context) {
    final localization =
        PhoneFieldLocalization.of(context) ?? PhoneFieldLocalizationEn();
    final countryRegistry = LocalizedCountryRegistry.cached(localization);
    // if localization has not changed no need to do anything
    if (countryRegistry == _localizedCountryRegistry) {
      return;
    }
    _localizedCountryRegistry = countryRegistry;
    final notFavoriteCountries = countryRegistry.whereIsoIn(
      countriesIso,
      omit: favoriteCountriesIso,
    );
    final favoriteCountries = countryRegistry.whereIsoIn(favoriteCountriesIso);
    _countryFinder = CountryFinder(notFavoriteCountries);
    _favoriteCountryFinder = CountryFinder(favoriteCountries, sort: false);
  }

  void _updateList() {
    _countryFinder.filter(query);
    _favoriteCountryFinder.filter(query);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _initIfRequired(context);
    _updateList();

    return CountryList(
      addFavouriteSeparator: addFavoritesSeparator,
      favorites: _favoriteCountryFinder.filteredCountries,
      countries: _countryFinder.filteredCountries,
      showDialCode: showCountryCode,
      onTap: onCountrySelected,
      flagSize: flagSize,
      isFlagCircle: isFlagCircle,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      noResultMessage: noResultMessage,
      countryNameStyle: countryNameStyle,
      countryCodeStyle: countryCodeStyle,
      showCountryName: showCountryName,
      showCountryFlag: showCountryFlag,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
}
