import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('ZipCodeValidator -', () {
    test('should return null if the ZIP code is valid (5 digits)', () {
      // Arrange
      final ZipCodeValidator validator = ZipCodeValidator(
        errorText: customErrorMessage,
      );
      const String validZipCode = '12345';

      // Act
      final String? result = validator.validate(validZipCode);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return null if the ZIP code is valid (9 digits with hyphen)',
      () {
        // Arrange
        final ZipCodeValidator validator = ZipCodeValidator(
          errorText: customErrorMessage,
        );
        const String validZipCode = '12345-6789';

        // Act
        final String? result = validator.validate(validZipCode);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return null if the ZIP code is valid (9 digits with space)',
      () {
        // Arrange
        final ZipCodeValidator validator = ZipCodeValidator(
          errorText: customErrorMessage,
        );
        const String validZipCode = '12345 6789';

        // Act
        final String? result = validator.validate(validZipCode);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return error if the ZIP code is invalid (letters included)',
      () {
        // Arrange
        final ZipCodeValidator validator = ZipCodeValidator(
          errorText: customErrorMessage,
        );
        const String invalidZipCode = '123ab';

        // Act
        final String? result = validator.validate(invalidZipCode);

        // Assert
        expect(result, customErrorMessage);
      },
    );

    test('should return error if the ZIP code is too short', () {
      // Arrange
      final ZipCodeValidator validator = ZipCodeValidator(
        errorText: customErrorMessage,
      );
      const String shortZipCode = '1234';

      // Act
      final String? result = validator.validate(shortZipCode);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the ZIP code is too long', () {
      // Arrange
      final ZipCodeValidator validator = ZipCodeValidator(
        errorText: customErrorMessage,
      );
      const String longZipCode = '12345678901';

      // Act
      final String? result = validator.validate(longZipCode);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the ZIP code has invalid format', () {
      // Arrange
      final ZipCodeValidator validator = ZipCodeValidator(
        errorText: customErrorMessage,
      );
      const String invalidFormatZipCode = '1234-56789';

      // Act
      final String? result = validator.validate(invalidFormatZipCode);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the value is null', () {
      // Arrange
      final ZipCodeValidator validator = ZipCodeValidator(
        errorText: customErrorMessage,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the value is empty', () {
      // Arrange
      final ZipCodeValidator validator = ZipCodeValidator(
        errorText: customErrorMessage,
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return default error if the value is empty', () {
      // Arrange
      final ZipCodeValidator validator = ZipCodeValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, validator.errorText);
    });
  });
}
