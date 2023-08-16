class Constants {
  /// The minimum and maximum length of the country calling code.
  static const int minLengthCountryCallingCode = 1;
  static const int maxLengthCountryCallingCode = 3;

  /// The minimum and maximum length of the national significant number.
  /// lib phone number uses 2 but ITU says it's 3
  static const int minLengthNsn = 3;

  /// The ITU says the maximum length should be 15, but we have found longer numbers in Germany.
  static const int maxLengthNsn = 17;

  /// New Zealand can have 5 digits
  static const int minLengthCountryPlusNsn = 5;
}
