import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('PositiveNumberValidator -', () {
    test('should return null if the value is a valid positive number string',
        () {
      // Arrange
      const PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>();
      const String value = '5';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is zero', () {
      // Arrange
      const PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>();
      const String value = '0';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.positiveNumberErrorText,
        ),
      );
      expect(
        result,
        equals(validator.errorText),
      );
    });

    test('should return the custom error message if the value is zero', () {
      // Arrange
      final PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>(errorText: customErrorMessage);
      const String value = '0';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message if the value is a negative number string',
        () {
      // Arrange
      const PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>();
      const String value = '-5';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.positiveNumberErrorText,
        ),
      );
    });

    test(
        'should return the custom error message if the value is a negative number string',
        () {
      // Arrange
      final PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>(errorText: customErrorMessage);
      const String value = '-5';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message if the value is not a number string',
        () {
      // Arrange
      const PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>();
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.positiveNumberErrorText,
        ),
      );
    });

    test(
        'should return the custom error message if the value is not a number string',
        () {
      // Arrange
      final PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>(errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.positiveNumberErrorText,
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>(checkNullOrEmpty: false);
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
      const PositiveNumberValidator<String> validator =
          PositiveNumberValidator<String>();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.positiveNumberErrorText,
        ),
      );
    });

    // Tests for num type
    test('should return null if the value is a valid positive num', () {
      // Arrange
      const PositiveNumberValidator<num> validator =
          PositiveNumberValidator<num>();
      const num value = 5;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is zero for num type',
        () {
      // Arrange
      const PositiveNumberValidator<num> validator =
          PositiveNumberValidator<num>();
      const num value = 0;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.positiveNumberErrorText,
        ),
      );
    });

    test(
        'should return the custom error message if the value is zero for num type',
        () {
      // Arrange
      final PositiveNumberValidator<num> validator =
          PositiveNumberValidator<num>(errorText: customErrorMessage);
      const num value = 0;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message if the value is a negative num',
        () {
      // Arrange
      const PositiveNumberValidator<num> validator =
          PositiveNumberValidator<num>();
      const num value = -5;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          validator.errorText,
        ),
      );
    });

    test(
        'should return the custom error message if the value is a negative num',
        () {
      // Arrange
      final PositiveNumberValidator<num> validator =
          PositiveNumberValidator<num>(errorText: customErrorMessage);
      const num value = -5;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return the default error message for invalid value types', () {
      // Arrange
      const PositiveNumberValidator<bool> validator =
          PositiveNumberValidator<bool>();

      // Act & Assert
      expect(
        validator.validate(false),
        equals(validator.errorText),
      );
    });
  });
}
