import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Date past -', () {
    test('should return null when the date is in the past', () {
      // Arrange
      const DatePastValidator validator = DatePastValidator();
      final DateTime pastDate =
          DateTime.now().subtract(const Duration(days: 1));
      final String value = pastDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the date is in the future',
        () {
      // Arrange
      const DatePastValidator validator = DatePastValidator();
      final DateTime futureDate = DateTime.now().add(const Duration(days: 1));
      final String value = futureDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.dateMustBeInThePastErrorText,
        ),
      );
    });

    test(
        'should return the custom error message when the date is in the future',
        () {
      // Arrange
      final DatePastValidator validator =
          DatePastValidator(errorText: customErrorMessage);
      final DateTime futureDate = DateTime.now().add(const Duration(days: 1));
      final String value = futureDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the date is today', () {
      // Arrange
      const DatePastValidator validator = DatePastValidator();
      final DateTime today = DateTime.now();
      final String value = today.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const DatePastValidator validator =
          DatePastValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const DatePastValidator validator = DatePastValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.dateMustBeInThePastErrorText,
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const DatePastValidator validator =
          DatePastValidator(checkNullOrEmpty: false);
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
      const DatePastValidator validator = DatePastValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.dateMustBeInThePastErrorText,
        ),
      );
    });
  });
}
