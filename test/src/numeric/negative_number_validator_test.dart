import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('NegativeNumberValidator -', () {
    group('String', () {
      test('should return null if the value is a negative number', () {
        // Arrange
        const NegativeNumberValidator<String> validator =
            NegativeNumberValidator<String>();
        const String value = '-5';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return error if the value is zero', () {
        // Arrange
        const NegativeNumberValidator<String> validator =
            NegativeNumberValidator<String>();
        const String value = '0';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.negativeNumberErrorText,
          ),
        );
      });

      test('should return error if the value is a positive number', () {
        // Arrange
        const NegativeNumberValidator<String> validator =
            NegativeNumberValidator<String>();
        const String value = '5';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.negativeNumberErrorText,
          ),
        );
      });

      test('should return custom error message if the value is zero', () {
        // Arrange
        final NegativeNumberValidator<String> validator =
            NegativeNumberValidator<String>(errorText: customErrorMessage);
        const String value = '0';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });

      test(
          'should return custom error message if the value is a positive number',
          () {
        // Arrange
        final NegativeNumberValidator<String> validator =
            NegativeNumberValidator<String>(errorText: customErrorMessage);
        const String value = '5';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    group('num', () {
      test('should return null if the value is a negative number', () {
        // Arrange
        const NegativeNumberValidator<num> validator =
            NegativeNumberValidator<num>();
        const num value = -5;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return error if the value is zero', () {
        // Arrange
        const NegativeNumberValidator<num> validator =
            NegativeNumberValidator<num>();
        const num value = 0;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.negativeNumberErrorText,
          ),
        );
      });

      test('should return error if the value is a positive number', () {
        // Arrange
        const NegativeNumberValidator<num> validator =
            NegativeNumberValidator<num>();
        const num value = 5;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.negativeNumberErrorText,
          ),
        );
      });

      test('should return custom error message if the value is zero', () {
        // Arrange
        final NegativeNumberValidator<num> validator =
            NegativeNumberValidator<num>(errorText: customErrorMessage);
        const num value = 0;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });

      test(
          'should return custom error message if the value is a positive number',
          () {
        // Arrange
        final NegativeNumberValidator<num> validator =
            NegativeNumberValidator<num>(errorText: customErrorMessage);
        const num value = 5;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const NegativeNumberValidator<String> validator =
          NegativeNumberValidator<String>(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const NegativeNumberValidator<String> validator =
          NegativeNumberValidator<String>();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.negativeNumberErrorText,
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const NegativeNumberValidator<String> validator =
          NegativeNumberValidator<String>(checkNullOrEmpty: false);
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
      const NegativeNumberValidator<String> validator =
          NegativeNumberValidator<String>();
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
  });
}
