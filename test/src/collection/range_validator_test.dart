import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('RangeValidator - String', () {
    test('should return null if the value is within the range (inclusive)', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator = RangeValidator<String>(min, max);
      const String value = '7';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the value is equal to the min (inclusive)', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator = RangeValidator<String>(min, max);
      const String value = '5';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the value is equal to the max (inclusive)', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator = RangeValidator<String>(min, max);
      const String value = '10';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is less than min',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator = RangeValidator<String>(min, max);
      const String value = '4';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.betweenErrorText(min, max)),
      );
    });

    test(
        'should return the default error message if the value is greater than max',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator = RangeValidator<String>(min, max);
      const String value = '11';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.betweenErrorText(min, max)),
      );
    });

    test('should return the custom error message if the value is out of range',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator =
          RangeValidator<String>(min, max, errorText: customErrorMessage);
      const String value = '11';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator =
          RangeValidator<String>(min, max, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator = RangeValidator<String>(min, max);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.betweenErrorText(min, max)),
      );
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator =
          RangeValidator<String>(min, max, checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is an empty string',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<String> validator = RangeValidator<String>(min, max);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.betweenErrorText(min, max)),
      );
    });
  });

  group('RangeValidator - num', () {
    test('should return null if the value is within the range (inclusive)', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator = RangeValidator<num>(min, max);
      const num value = 7;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the value is equal to the min (inclusive)', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator = RangeValidator<num>(min, max);
      const num value = 5;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the value is equal to the max (inclusive)', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator = RangeValidator<num>(min, max);
      const num value = 10;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is less than min',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator = RangeValidator<num>(min, max);
      const num value = 4;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.betweenErrorText(min, max)),
      );
    });

    test(
        'should return the default error message if the value is greater than max',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator = RangeValidator<num>(min, max);
      const num value = 11;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.betweenErrorText(min, max)),
      );
    });

    test('should return the custom error message if the value is out of range',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator =
          RangeValidator<num>(min, max, errorText: customErrorMessage);
      const num value = 11;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator =
          RangeValidator<num>(min, max, checkNullOrEmpty: false);
      const num? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator = RangeValidator<num>(min, max);
      const num? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.betweenErrorText(min, max)),
      );
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final RangeValidator<num> validator =
          RangeValidator<num>(min, max, checkNullOrEmpty: false);
      const num? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
