import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('FloatValidator -', () {
    group('String', () {
      test('should return null if the value is a valid float string', () {
        // Arrange
        const FloatValidator<String> validator = FloatValidator<String>();
        const String value = '0.99';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return error if the value is not a valid float string', () {
        // Arrange
        const FloatValidator<String> validator = FloatValidator<String>();
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.floatErrorText,
          ),
        );
      });

      test(
          'should return custom error message if the value is not a valid float string',
          () {
        // Arrange
        final FloatValidator<String> validator =
            FloatValidator<String>(errorText: customErrorMessage);
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    group('num', () {
      test('should return null if the value is a valid float', () {
        // Arrange
        const FloatValidator<num> validator = FloatValidator<num>();
        const num value = 0.99;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return null if the value is a valid int', () {
        // Arrange
        const FloatValidator<num> validator = FloatValidator<num>();
        const int value = 5;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return error if the value is not a valid float', () {
        // Arrange
        const FloatValidator<String> validator = FloatValidator<String>();
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.floatErrorText,
          ),
        );
      });

      test(
          'should return custom error message if the value is not a valid float',
          () {
        // Arrange
        final FloatValidator<String> validator =
            FloatValidator<String>(errorText: customErrorMessage);
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const FloatValidator<String> validator =
          FloatValidator<String>(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const FloatValidator<String> validator = FloatValidator<String>();
      const String? value = null;

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
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const FloatValidator<String> validator =
          FloatValidator<String>(checkNullOrEmpty: false);
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
      const FloatValidator<String> validator = FloatValidator<String>();
      const String value = '';

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

    test('should return the default error message for invalid value types', () {
      // Arrange
      const FloatValidator<bool> validator = FloatValidator<bool>();

      // Act & Assert
      expect(
        validator.validate(false),
        equals(validator.errorText),
      );
    });
  });
}
