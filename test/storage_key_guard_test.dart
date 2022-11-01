import 'package:flutter_test/flutter_test.dart';

// Todo: Throws `InvalidKeyException` when key contains special characters

void main() {
  group('Storage Key Guard', () {
    test("Throws `InvalidKeyException` when key contains special characters", () {
      expect(() => StorageKeyGuard.validate(' '), throwsA(isA<InvalidKeyException> ()));
      expect(() => StorageKeyGuard.validate('A \$ **** Hello`||||+'), throwsA(isA<InvalidKeyException> ()));
    });
    test("Accepts any key doesn't contains special characters", () {
      expect(() => StorageKeyGuard.validate('A'), isNot(throwsA(isA<InvalidKeyException> ())));
      expect(() => StorageKeyGuard.validate('B'), isNot(throwsA(isA<InvalidKeyException> ())));
      expect(() => StorageKeyGuard.validate('Products_1'), isNot(throwsA(isA<InvalidKeyException> ())));
    });
  });
}

class InvalidKeyException implements Exception {

}

class StorageKeyGuard {
  static void validate(String value) {
    if (RegExp(r'^[\w&.\-]+$').hasMatch(value)) return;
    throw InvalidKeyException();
  }
}