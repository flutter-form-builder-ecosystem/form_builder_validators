import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('NumericValidator -', () {
    group('String', () {
      test('should return null if the value is a valid number string', () {
        // Arrange
        const NumericValidator<String> validator = NumericValidator<String>();
        const String value = '123.45';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return error if the value is not a valid number string', () {
        // Arrange
        const NumericValidator<String> validator = NumericValidator<String>();
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.numericErrorText,
          ),
        );
      });

      test(
          'should return custom error message if the value is not a valid number string',
          () {
        // Arrange
        final NumericValidator<String> validator =
            NumericValidator<String>(errorText: customErrorMessage);
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    group('num', () {
      test('should return null if the value is a valid number', () {
        // Arrange
        const NumericValidator<num> validator = NumericValidator<num>();
        const num value = 123.45;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return error if the value is not a valid number', () {
        // Arrange
        const NumericValidator<String> validator = NumericValidator<String>();
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.numericErrorText,
          ),
        );
      });

      test(
          'should return custom error message if the value is not a valid number',
          () {
        // Arrange
        final NumericValidator<String> validator =
            NumericValidator<String>(errorText: customErrorMessage);
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
      const NumericValidator<String> validator =
          NumericValidator<String>(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const NumericValidator<String> validator = NumericValidator<String>();
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
      const NumericValidator<String> validator =
          NumericValidator<String>(checkNullOrEmpty: false);
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
      const NumericValidator<String> validator = NumericValidator<String>();
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
      const NumericValidator<bool> validator = NumericValidator<bool>();

      // Act & Assert
      expect(
        validator.validate(false),
        equals(validator.errorText),
      );
    });
  });
}
