import 'package:phone_input/l10n/generated/phone_field_localization.dart';
import 'package:phone_input/src/flags/flags.dart';
import 'package:flutter/material.dart';

import 'country.dart';

class CountryList extends StatelessWidget {
  /// Callback function triggered when user select a country
  final Function(Country) onTap;

  /// List of countries to display
  final List<Country> countries;

  /// The size factor for displaying flags within the UI.
  final double flagSize;

  /// Determines if the displayed flags should be circular.
  final BoxShape flagShape;

  /// list of favorite countries to display at the top
  final List<Country> favorites;

  /// proxy to the ListView.builder controller (ie: [ScrollView.controller])
  final ScrollController? scrollController;

  /// The [ScrollPhysics] of the Country List
  final ScrollPhysics? scrollPhysics;

  /// whether the country dialcode should be displayed as the [ListTile.subtitle]
  final bool showDialCode;

  /// Message to display when there are no search results.
  final String? noResultMessage;

  /// Determines if separators should be added between favorite and other countries.
  final bool addFavouriteSeparator;

  /// TextStyle for displaying the country code.
  final TextStyle? countryCodeStyle;

  /// TextStyle for displaying the country name.
  final TextStyle? countryNameStyle;

  /// Determines if the country name should be shown.
  final bool showCountryName;

  /// Determines if the country flag should be shown
  final bool showCountryFlag;

  late final List<Country?> _allListElement;

  CountryList({
    Key? key,
    required this.countries,
    required this.favorites,
    required this.onTap,
    required this.noResultMessage,
    this.scrollController,
    this.scrollPhysics,
    this.showDialCode = true,
    this.flagSize = 48,
    this.flagShape = BoxShape.circle,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.showCountryName = true,
    this.showCountryFlag = true,
    this.addFavouriteSeparator = true,
  }) : super(key: key) {
    _allListElement = [
      ...favorites,
      if (favorites.isNotEmpty) null, // delimiter
      ...countries,
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_allListElement.isEmpty) {
      return Center(
        child: Text(
          noResultMessage ??
              PhoneFieldLocalization.of(context)?.noResultMessage ??
              'No result found',
          key: const ValueKey('no-result'),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: scrollPhysics,
      controller: scrollController,
      itemCount: _allListElement.length,
      itemBuilder: (BuildContext context, int index) {
        final country = _allListElement[index];
        if (country == null) {
          if (addFavouriteSeparator) {
            return const Divider(key: ValueKey('countryListSeparator'));
          } else {
            return const SizedBox.shrink();
          }
        }

        return Material(
          color: Colors.transparent,
          child: ListTile(
            key: ValueKey(country.isoCode.name),
            leading: showCountryFlag
                ? Flag(
                    country.isoCode.name,
                    key: ValueKey('circle-flag-${country.isoCode.name}'),
                    size: flagSize,
                    shape: flagShape,
                  )
                : null,
            title: showCountryName || showDialCode
                ? Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: showDialCode && showCountryFlag && showCountryName
                        ? Text(
                            country.name,
                            textAlign: TextAlign.start,
                            style: countryNameStyle,
                          )
                        : Row(
                            children: [
                              showCountryName
                                  ? Expanded(
                                      child: Text(
                                        country.name,
                                        textAlign: TextAlign.start,
                                        style: countryNameStyle,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(width: 4),
                              showDialCode
                                  ? Text(
                                      country.displayCountryCode,
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.start,
                                      style: countryCodeStyle,
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                  )
                : null,
            subtitle: showDialCode && showCountryFlag && showCountryName
                ? Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      country.displayCountryCode,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style: countryCodeStyle,
                    ),
                  )
                : null,
            onTap: () => onTap(country),
          ),
        );
      },
    );
  }
}
