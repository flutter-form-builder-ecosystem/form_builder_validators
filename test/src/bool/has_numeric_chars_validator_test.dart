import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Has numeric chars -', () {
    final HasNumericCharsValidator validator = HasNumericCharsValidator();

    test('should return null when the value has at least 1 numeric character',
        () {
      // Arrange
      const String value = 'abc123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value has at least 3 numeric characters',
        () {
      // Arrange
      final HasNumericCharsValidator validator =
          HasNumericCharsValidator(atLeast: 3);
      const String value = 'a1b2c3';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error message when the value has no numeric characters',
        () {
      // Arrange
      final HasNumericCharsValidator validator =
          HasNumericCharsValidator(errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the custom error message when the value has less than 3 numeric characters',
        () {
      // Arrange
      final HasNumericCharsValidator validator =
          HasNumericCharsValidator(atLeast: 3, errorText: customErrorMessage);
      const String value = 'a1b';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return the error message when the value is empty', () {
      // Arrange
      final HasNumericCharsValidator validator =
          HasNumericCharsValidator(errorText: customErrorMessage);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is empty', () {
      // Arrange
      final HasNumericCharsValidator validator =
          HasNumericCharsValidator(checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the error message when the value is null', () {
      // Arrange
      final HasNumericCharsValidator validator =
          HasNumericCharsValidator(errorText: customErrorMessage);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null', () {
      // Arrange
      final HasNumericCharsValidator validator =
          HasNumericCharsValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error message when using a custom regex and the value does not match',
        () {
      // Arrange
      final HasNumericCharsValidator validator = HasNumericCharsValidator(
          regex: RegExp('[0-9]'), errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when using a custom regex and the value matches',
        () {
      // Arrange
      final HasNumericCharsValidator validator =
          HasNumericCharsValidator(regex: RegExp('[0-9]'));
      const String value = 'abc123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
