import 'package:flutter/services.dart';
import 'package:phone_form_field/src/constants/patterns.dart';

class CustomMaxLengthFormatter extends TextInputFormatter {
  final int maxLength;

  CustomMaxLengthFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(Patterns.numberDividers), '');
    return newText.length > maxLength ? oldValue : newValue;
  }
}
