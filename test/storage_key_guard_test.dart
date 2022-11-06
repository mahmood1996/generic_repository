import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Storage Key Guard", () {
    test("Throw InvalidKeyException when key contains special characters", () {
      expect(() => StorageKeyGuard.validate(' '), throwsA(isA<InvalidKeyException> ()));
      expect(() => StorageKeyGuard.validate('A \$ **** Hello`||||+\\'), throwsA(isA<InvalidKeyException> ()));
    });
    test("Accept any key doesn't contains special characters", () {
      expect(() => StorageKeyGuard.validate('A'), isNot(throwsA(isA<InvalidKeyException> ())));
      expect(() => StorageKeyGuard.validate('B'), isNot(throwsA(isA<InvalidKeyException> ())));
      expect(() => StorageKeyGuard.validate('Products_1'), isNot(throwsA(isA<InvalidKeyException> ())));
    });
  });
}

class InvalidKeyException implements Exception {}

class StorageKeyGuard {
  static final RegExp _validKeyRegex = RegExp(r'^[\w&.\-]+$');
  static void validate(String value) {
    if (_validKeyRegex.hasMatch(value)) return;
    throw InvalidKeyException();
  }
}