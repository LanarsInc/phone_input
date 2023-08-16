import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phone_input/phone_input_package.dart';

class PhoneController extends ValueNotifier<PhoneNumber?> {
  // when we want to select the national number
  final StreamController<void> _selectionRequestController =
      StreamController.broadcast();
  Stream<void> get selectionRequestStream => _selectionRequestController.stream;

  PhoneController(super.initialValue);

  selectNationalNumber() {
    _selectionRequestController.add(null);
  }

  reset() {
    value = null;
  }

  @override
  void dispose() {
    _selectionRequestController.close();
    super.dispose();
  }
}
