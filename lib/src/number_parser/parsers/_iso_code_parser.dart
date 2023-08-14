import 'package:phone_input/src/number_parser/models/phone_number_exceptions.dart';

abstract class IsoCodeParser {
  /// normalize an iso code to be what the lib expects, mainly uppercases it
  static String normalizeIsoCode(String isoCode) {
    isoCode = isoCode.toUpperCase().trim();
    if (isoCode.length != 2) {
      throw PhoneNumberException(
          code: Code.invalidIsoCode,
          description: "incorrect length, found '$isoCode'");
    }
    return isoCode;
  }
}
