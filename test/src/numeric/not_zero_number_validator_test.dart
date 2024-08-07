import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('NotZeroNumberValidator -', () {
    group('String', () {
      test('should return null if the value is a non-zero number', () {
        // Arrange
        const NotZeroNumberValidator<String> validator =
            NotZeroNumberValidator<String>();
        const String value = '5';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return error if the value is zero', () {
        // Arrange
        const NotZeroNumberValidator<String> validator =
            NotZeroNumberValidator<String>();
        const String value = '0';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.notZeroNumberErrorText,
          ),
        );
      });

      test('should return custom error message if the value is zero', () {
        // Arrange
        final NotZeroNumberValidator<String> validator =
            NotZeroNumberValidator<String>(errorText: customErrorMessage);
        const String value = '0';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    group('num', () {
      test('should return null if the value is a non-zero number', () {
        // Arrange
        const NotZeroNumberValidator<num> validator =
            NotZeroNumberValidator<num>();
        const num value = 5;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return error if the value is zero', () {
        // Arrange
        const NotZeroNumberValidator<num> validator =
            NotZeroNumberValidator<num>();
        const num value = 0;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.notZeroNumberErrorText,
          ),
        );
      });

      test('should return custom error message if the value is zero', () {
        // Arrange
        final NotZeroNumberValidator<num> validator =
            NotZeroNumberValidator<num>(errorText: customErrorMessage);
        const num value = 0;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const NotZeroNumberValidator<String> validator =
          NotZeroNumberValidator<String>(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const NotZeroNumberValidator<String> validator =
          NotZeroNumberValidator<String>();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.notZeroNumberErrorText,
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const NotZeroNumberValidator<String> validator =
          NotZeroNumberValidator<String>(checkNullOrEmpty: false);
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
      const NotZeroNumberValidator<String> validator =
          NotZeroNumberValidator<String>();
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
      const NotZeroNumberValidator<bool> validator =
          NotZeroNumberValidator<bool>();

      // Act & Assert
      expect(
        validator.validate(false),
        equals(validator.errorText),
      );
    });

    test(
        'should return the default error message for non-numeric string values',
        () {
      // Arrange
      const NotZeroNumberValidator<String> validator =
          NotZeroNumberValidator<String>();

      // Act & Assert
      expect(
        validator.validate('abc'),
        equals(FormBuilderLocalizations.current.notZeroNumberErrorText),
      );
    });

    test('should return the custom error message for non-numeric string values',
        () {
      // Arrange
      final NotZeroNumberValidator<String> validator =
          NotZeroNumberValidator<String>(
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('abc'), equals(customErrorMessage));
    });

    test('should return the default error message for unsupported value types',
        () {
      // Arrange
      const NotZeroNumberValidator<bool> validator =
          NotZeroNumberValidator<bool>();

      // Act & Assert
      expect(
        validator.validate(true),
        equals(FormBuilderLocalizations.current.notZeroNumberErrorText),
      );
    });
  });
}
