import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('DateValidator -', () {
    test('should return null when the value is a valid date string', () {
      // Arrange
      const DateValidator validator = DateValidator();
      final DateTime now = DateTime.now();
      final String value = now.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is an invalid date string',
        () {
      // Arrange
      const DateValidator validator = DateValidator();
      const String value = 'invalid-date';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.dateStringErrorText),
      );
    });

    test(
        'should return the custom error message when the value is an invalid date string',
        () {
      // Arrange
      final DateValidator validator =
          DateValidator(errorText: customErrorMessage);
      const String value = 'invalid-date';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const DateValidator validator = DateValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const DateValidator validator = DateValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.dateStringErrorText),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const DateValidator validator = DateValidator(checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is an empty string',
        () {
      // Arrange
      const DateValidator validator = DateValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.dateStringErrorText),
      );
    });

    test('should return null when the value is a valid date string with time',
        () {
      // Arrange
      const DateValidator validator = DateValidator();
      final DateTime now = DateTime.now();
      final String value = now.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the value is a valid date string without time',
        () {
      // Arrange
      const DateValidator validator = DateValidator();
      const String value = '2024-01-01';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
