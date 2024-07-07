import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('DateTimeValidator -', () {
    test('should return null when the value is a valid DateTime', () {
      // Arrange
      const DateTimeValidator validator = DateTimeValidator();
      final DateTime now = DateTime.now();

      // Act
      final String? result = validator.validate(now);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const DateTimeValidator validator = DateTimeValidator();
      const DateTime? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.dateStringErrorText),
      );
      expect(result, validator.errorText);
    });

    test('should return the custom error message when the value is null', () {
      // Arrange
      final DateTimeValidator validator =
          DateTimeValidator(errorText: customErrorMessage);
      const DateTime? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const DateTimeValidator validator =
          DateTimeValidator(checkNullOrEmpty: false);
      const DateTime? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const DateTimeValidator validator =
          DateTimeValidator(checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(DateTime.tryParse(value));

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is an empty string',
        () {
      // Arrange
      const DateTimeValidator validator = DateTimeValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(DateTime.tryParse(value));

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.dateStringErrorText),
      );
      expect(result, validator.errorText);
    });

    test(
        'should return the default error message when the value is an invalid DateTime string',
        () {
      // Arrange
      const DateTimeValidator validator = DateTimeValidator();
      const String value = 'invalid-date';

      // Act
      final String? result = validator.validate(DateTime.tryParse(value));

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.dateStringErrorText),
      );
    });

    test(
        'should return the custom error message when the value is an invalid DateTime string',
        () {
      // Arrange
      final DateTimeValidator validator =
          DateTimeValidator(errorText: customErrorMessage);
      const String value = 'invalid-date';

      // Act
      final String? result = validator.validate(DateTime.tryParse(value));

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
