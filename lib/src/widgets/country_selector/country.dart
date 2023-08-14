import 'package:phone_form_field/src/number_parser/metadata/generated/metadata_by_iso_code.dart';
import 'package:phone_form_field/src/number_parser/models/iso_code.dart';

/// Country regroup informations for displaying a list of countries
class Country {
  /// Country alpha-2 iso code
  final IsoCode isoCode;

  /// localized name of the country
  final String name;

  /// country dialing code to call them internationally
  final String countryCode;

  /// returns "+ [countryCode]"
  String get displayCountryCode => '+ $countryCode';

  Country(this.isoCode, this.name)
      : countryCode = metadataByIsoCode[isoCode]?.countryCode ?? '';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          isoCode == other.isoCode;

  @override
  int get hashCode => isoCode.hashCode;

  @override
  String toString() {
    return 'Country{isoCode: $isoCode}';
  }
}
