import '../metadata/models/phone_metadata.dart';

abstract class InternationalPrefixParser {
  ///  Removes the exit code from a phone number if present.
  ///
  ///  It expects a normalized [phoneNumber].
  ///  if phone starts with + it is removed
  static String removeExitCode(
    String phoneNumber, {
    PhoneMetadata? callerCountryMetadata,
    PhoneMetadata? destinationCountryMetadata,
  }) {
    if (phoneNumber.startsWith('+')) {
      return phoneNumber.substring(1);
    }

    // if the caller country was provided it's easy, just remove the exit code
    // from the phone number
    if (callerCountryMetadata != null) {
      return _removeExitCodeWithMetadata(phoneNumber, callerCountryMetadata);
    }

    return phoneNumber;
  }

  static String _removeExitCodeWithMetadata(
    String phoneNumber,
    PhoneMetadata metadata,
  ) {
    final match =
        RegExp(metadata.internationalPrefix).matchAsPrefix(phoneNumber);
    if (match != null) {
      return phoneNumber.substring(match.end);
    }
    // if it does not start with the international prefix from the
    // country we assume the prefix is not present
    return phoneNumber;
  }
}
