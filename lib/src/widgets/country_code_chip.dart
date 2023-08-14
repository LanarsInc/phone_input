import 'package:phone_input/src/flags/flags.dart';
import 'package:flutter/material.dart';
import 'package:phone_input/src/number_parser/models/iso_code.dart';

import 'country_selector/country.dart';

// The widget that displays a suffix in PhoneFormField
class CountryCodeChip extends StatelessWidget {
  /// The country associated with the component.
  final Country country;

  /// Determines if the country flag should be displayed.
  final bool showFlag;

  /// Determines if an arrow indicator should be displayed.
  final bool showArrow;

  /// Determines if the list is visible.
  /// Changing this variable reproduces the arrow animation
  final bool isListVisible;

  /// TextStyle for customizing the appearance of the country code.
  final TextStyle countryCodeTextStyle;

  /// The size factor for displaying flags within the UI.
  final double flagSize;

  /// Determines if the displayed flags should be circular.
  final BoxShape flagShape;

  /// The direction of the text within the component.
  final TextDirection? textDirection;

  CountryCodeChip({
    super.key,
    required IsoCode isoCode,
    this.countryCodeTextStyle = const TextStyle(),
    this.showFlag = true,
    this.flagSize = 20,
    this.flagShape = BoxShape.circle,
    this.textDirection,
    this.showArrow = true,
    this.isListVisible = false,
  }) : country = Country(isoCode, '');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showFlag) ...[
          Flag(
            country.isoCode.name,
            size: flagSize,
            shape: flagShape,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          country.displayCountryCode,
          style: countryCodeTextStyle,
          textDirection: textDirection,
        ),
        if (showArrow) ...[
          AnimatedRotation(
            turns: isListVisible ? 0 : 0.5,
            duration: const Duration(milliseconds: 300),
            child: const Icon(Icons.arrow_drop_up, size: 20),
          ),
        ],
      ],
    );
  }
}
