import 'package:phone_form_field/l10n/generated/phone_field_localization.dart';
import 'package:phone_form_field/src/flags/flags.dart';
import 'package:flutter/material.dart';

import 'country.dart';

class CountryList extends StatelessWidget {
  /// Callback function triggered when user select a country
  final Function(Country) onTap;

  /// List of countries to display
  final List<Country> countries;
  final double flagSize;
  final bool isFlagCircle;

  /// list of favorite countries to display at the top
  final List<Country> favorites;

  /// proxy to the ListView.builder controller (ie: [ScrollView.controller])
  final ScrollController? scrollController;

  /// The [ScrollPhysics] of the Country List
  final ScrollPhysics? scrollPhysics;

  /// whether the country dialcode should be displayed as the [ListTile.subtitle]
  final bool showDialCode;

  final String? noResultMessage;

  final bool addFavouriteSeparator;

  late final List<Country?> _allListElement;

  final TextStyle? countryCodeStyle;
  final TextStyle? countryNameStyle;
  final bool showCountryName;
  final bool showCountryFlag;

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
    this.isFlagCircle = true,
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
          if(addFavouriteSeparator) {
            return const Divider(key: ValueKey('countryListSeparator'));
          } else {
            return const SizedBox.shrink();
          }
        }

        return ListTile(
          key: ValueKey(country.isoCode.name),
          leading: showCountryFlag
              ? Flag(
                  country.isoCode.name,
                  key: ValueKey('circle-flag-${country.isoCode.name}'),
                  size: flagSize,
                  isFlagCircle: isFlagCircle,
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
        );
      },
    );
  }
}
