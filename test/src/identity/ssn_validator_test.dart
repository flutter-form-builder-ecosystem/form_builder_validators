import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('SsnValidator -', () {
    test('should return null if the SSN is valid', () {
      // Arrange
      final SsnValidator validator = SsnValidator();
      const String validSsn = '123-45-6789';

      // Act
      final String? result = validator.validate(validSsn);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the SSN is too short', () {
      // Arrange
      final SsnValidator validator =
          SsnValidator(errorText: customErrorMessage);
      const String shortSsn = '123-45-678';

      // Act
      final String? result = validator.validate(shortSsn);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the SSN is too long', () {
      // Arrange
      final SsnValidator validator =
          SsnValidator(errorText: customErrorMessage);
      const String longSsn = '123-45-67890';

      // Act
      final String? result = validator.validate(longSsn);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the SSN has letters', () {
      // Arrange
      final SsnValidator validator =
          SsnValidator(errorText: customErrorMessage);
      const String invalidSsn = '123-AB-6789';

      // Act
      final String? result = validator.validate(invalidSsn);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the SSN has special characters', () {
      // Arrange
      final SsnValidator validator =
          SsnValidator(errorText: customErrorMessage);
      const String invalidSsn = '123-45-67!9';

      // Act
      final String? result = validator.validate(invalidSsn);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the SSN is valid and without hyphens', () {
      // Arrange
      final SsnValidator validator = SsnValidator();
      const String validSsn = '123456789';

      // Act
      final String? result = validator.validate(validSsn);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the SSN is valid and has spaces', () {
      // Arrange
      final SsnValidator validator = SsnValidator();
      const String validSsn = '123 45 6789';

      // Act
      final String? result = validator.validate(validSsn.replaceAll(' ', ''));

      // Assert
      expect(result, isNull);
    });

    test('should return error if the SSN has only hyphens', () {
      // Arrange
      final SsnValidator validator =
          SsnValidator(errorText: customErrorMessage);
      const String invalidSsn = '---';

      // Act
      final String? result = validator.validate(invalidSsn);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the SSN is null', () {
      // Arrange
      final SsnValidator validator =
          SsnValidator(errorText: customErrorMessage);
      const String? nullSsn = null;

      // Act
      final String? result = validator.validate(nullSsn);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the SSN is empty', () {
      // Arrange
      final SsnValidator validator =
          SsnValidator(errorText: customErrorMessage);
      const String emptySsn = '';

      // Act
      final String? result = validator.validate(emptySsn);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return default error if the SSN is empty', () {
      // Arrange
      final SsnValidator validator = SsnValidator();
      const String emptySsn = '';

      // Act
      final String? result = validator.validate(emptySsn);

      // Assert
      expect(result, validator.errorText);
    });
  });
}
