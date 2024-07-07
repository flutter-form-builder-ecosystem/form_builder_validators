import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final DateTime minDate = DateTime.now().subtract(const Duration(days: 10));
  final DateTime maxDate = DateTime.now().add(const Duration(days: 10));

  group('Date range -', () {
    test('should return null when the date is within the range', () {
      // Arrange
      final DateRangeValidator validator = DateRangeValidator(minDate, maxDate);
      final DateTime withinRangeDate = DateTime.now();
      final String value = withinRangeDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the date is before the range',
        () {
      // Arrange
      final DateRangeValidator validator = DateRangeValidator(minDate, maxDate);
      final DateTime beforeRangeDate =
          DateTime.now().subtract(const Duration(days: 20));
      final String value = beforeRangeDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.dateRangeErrorText(minDate, maxDate),
        ),
      );
    });

    test(
        'should return the default error message when the date is after the range',
        () {
      // Arrange
      final DateRangeValidator validator = DateRangeValidator(minDate, maxDate);
      final DateTime afterRangeDate =
          DateTime.now().add(const Duration(days: 20));
      final String value = afterRangeDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.dateRangeErrorText(minDate, maxDate),
        ),
      );
    });

    test(
        'should return the custom error message when the date is before the range',
        () {
      // Arrange
      final DateRangeValidator validator =
          DateRangeValidator(minDate, maxDate, errorText: customErrorMessage);
      final DateTime beforeRangeDate =
          DateTime.now().subtract(const Duration(days: 20));
      final String value = beforeRangeDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the custom error message when the date is after the range',
        () {
      // Arrange
      final DateRangeValidator validator =
          DateRangeValidator(minDate, maxDate, errorText: customErrorMessage);
      final DateTime afterRangeDate =
          DateTime.now().add(const Duration(days: 20));
      final String value = afterRangeDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      final DateRangeValidator validator =
          DateRangeValidator(minDate, maxDate, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      final DateRangeValidator validator = DateRangeValidator(minDate, maxDate);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.dateRangeErrorText(minDate, maxDate),
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final DateRangeValidator validator =
          DateRangeValidator(minDate, maxDate, checkNullOrEmpty: false);
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
      final DateRangeValidator validator = DateRangeValidator(minDate, maxDate);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.dateRangeErrorText(minDate, maxDate),
        ),
      );
    });
  });
}
