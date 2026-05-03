import 'package:flutter/material.dart';
import 'package:phone_input/l10n/generated/phone_field_localization.dart';
import 'package:phone_input/l10n/generated/phone_field_localization_en.dart';
import 'package:phone_input/src/number_parser/models/iso_code.dart';
import 'package:phone_input/src/widgets/country_selector/localized_country_registry.dart';

import 'country_finder.dart';
import 'country.dart';
import 'country_list.dart';
import 'search_input.dart';

class CountrySelector extends StatefulWidget {
  /// List of countries to display in the selector
  /// Value optional in constructor.
  /// when omitted, the full country list is displayed
  final List<IsoCode>? countries;

  /// Callback triggered when user select a country
  final ValueChanged<Country> onCountrySelected;

  /// ListView.builder scroll controller (ie: [ScrollView.controller])
  final ScrollController? scrollController;

  /// The [ScrollPhysics] of the Country List
  final ScrollPhysics? scrollPhysics;

  /// Determine the countries to be displayed on top of the list
  /// Check [addFavouriteSeparator] property to enable/disable adding a
  /// list divider between favorites and others defaults countries
  final List<IsoCode> favoriteCountries;

  /// Whether to add a list divider between favorites & defaults
  /// countries.
  final bool addFavouriteSeparator;

  /// Whether to show the country country code (ie: +1 / +33 /...)
  /// as a listTile subtitle
  final bool showCountryCode;

  /// The message displayed instead of the list when the search has no results
  final String? noResultMessage;

  /// Whether to show the search input
  final bool showSearchInput;

  /// The [TextStyle] of the country subtitle
  final TextStyle? countryCodeStyle;

  /// The [TextStyle] of the country title
  final TextStyle? countryNameStyle;

  /// The [InputDecoration] of the Search Box
  final InputDecoration? searchInputDecoration;

  /// The [TextStyle] of the Search Box
  final TextStyle? searchInputTextStyle;

  /// The [Color] of the Search Icon in the Search Box
  final Color? defaultSearchInputIconColor;

  /// The [Color] of the divider at the top on the bottom sheet
  final Color? bottomSheetDragHandlerColor;

  /// The size factor for displaying flags within the UI.
  final double flagSize;

  /// Determines if the displayed flags should be circular.
  final BoxShape flagShape;

  /// Determines if the component is being used within a bottom sheet.
  /// For display bottomSheetDragHandler and some paddings
  final bool isBottomSheet;

  /// Determines if the country name should be shown.
  final bool showCountryName;

  /// Determines if the country flag should be shown
  final bool showCountryFlag;

  /// The height of the search input field, if specified.
  final double? searchInputHeight;

  /// The width of the search input field, if specified.
  final double? searchInputWidth;

  const CountrySelector({
    required this.onCountrySelected,
    required this.isBottomSheet,
    this.scrollController,
    this.scrollPhysics,
    this.addFavouriteSeparator = true,
    this.showCountryCode = false,
    this.noResultMessage,
    this.favoriteCountries = const [],
    this.countries,
    this.showSearchInput = true,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.searchInputDecoration,
    this.searchInputTextStyle,
    this.defaultSearchInputIconColor,
    this.bottomSheetDragHandlerColor,
    this.flagSize = 48,
    this.flagShape = BoxShape.circle,
    this.showCountryName = true,
    this.showCountryFlag = true,
    this.searchInputHeight,
    this.searchInputWidth,
    super.key,
  });

  @override
  CountrySelectorState createState() => CountrySelectorState();
}

class CountrySelectorState extends State<CountrySelector> {
  late CountryFinder _countryFinder;
  late CountryFinder _favoriteCountryFinder;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    final localization =
        PhoneFieldLocalization.of(context) ?? PhoneFieldLocalizationEn();
    final isoCodes = widget.countries ?? IsoCode.values;
    final countryRegistry = LocalizedCountryRegistry.cached(localization);
    final notFavoriteCountries =
        countryRegistry.whereIsoIn(isoCodes, omit: widget.favoriteCountries);
    final favoriteCountries =
        countryRegistry.whereIsoIn(widget.favoriteCountries);
    _countryFinder = CountryFinder(notFavoriteCountries);
    _favoriteCountryFinder = CountryFinder(favoriteCountries, sort: false);
  }

  _onSearch(String searchedText) {
    _countryFinder.filter(searchedText);
    _favoriteCountryFinder.filter(searchedText);
    setState(() {});
  }

  onSubmitted() {
    if (_favoriteCountryFinder.filteredCountries.isNotEmpty) {
      widget.onCountrySelected(_favoriteCountryFinder.filteredCountries.first);
    } else if (_countryFinder.filteredCountries.isNotEmpty) {
      widget.onCountrySelected(_countryFinder.filteredCountries.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isBottomSheet
            ? const SizedBox(height: 16)
            : const SizedBox.shrink(),
        widget.isBottomSheet
            ? Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: widget.bottomSheetDragHandlerColor ??
                      Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
              )
            : const SizedBox.shrink(),
        widget.showSearchInput
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: widget.searchInputHeight,
                  width: widget.searchInputWidth ?? double.infinity,
                  child: SearchInput(
                    onChanged: _onSearch,
                    onSubmitted: onSubmitted,
                    decoration: widget.searchInputDecoration,
                    style: widget.searchInputTextStyle,
                    defaultSearchInputIconColor:
                        widget.defaultSearchInputIconColor,
                  ),
                ),
              )
            : const SizedBox(height: 8),
        widget.showSearchInput
            ? const Divider(height: 0, thickness: 1.2)
            : const SizedBox.shrink(),
        Flexible(
          child: CountryList(
            addFavouriteSeparator: widget.addFavouriteSeparator,
            showCountryFlag: widget.showCountryFlag,
            showCountryName: widget.showCountryName,
            favorites: _favoriteCountryFinder.filteredCountries,
            countries: _countryFinder.filteredCountries,
            showDialCode: widget.showCountryCode,
            onTap: widget.onCountrySelected,
            flagSize: widget.flagSize,
            flagShape: widget.flagShape,
            scrollController: widget.scrollController,
            scrollPhysics: widget.scrollPhysics,
            noResultMessage: widget.noResultMessage,
            countryNameStyle: widget.countryNameStyle,
            countryCodeStyle: widget.countryCodeStyle,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
