import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Has special chars -', () {
    final HasSpecialCharsValidator validator = HasSpecialCharsValidator();

    test(
      'should return null when the value has at least 1 special character',
      () {
        // Arrange
        const String value = 'abc!@#';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return null when the value has at least 3 special characters',
      () {
        // Arrange
        final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
          atLeast: 3,
        );
        const String value = 'a!b@c#';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the custom error message when the value has no special characters',
      () {
        // Arrange
        final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
          errorText: customErrorMessage,
        );
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return the custom error message when the value has less than 3 special characters',
      () {
        // Arrange
        final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
          atLeast: 3,
          errorText: customErrorMessage,
        );
        const String value = 'a!b';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return null when the value has exactly 1 special character',
      () {
        // Arrange
        const String value = 'abc!';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the custom error message when the value does not have enough special characters',
      () {
        // Arrange
        final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
          atLeast: 2,
          errorText: customErrorMessage,
        );
        const String value = 'a!b';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return the default error message when the value is an empty string',
      () {
        // Arrange
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          FormBuilderLocalizations.current.containsSpecialCharErrorText(1),
        );
      },
    );

    test('should return null when the value is an empty string', () {
      // Arrange
      final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
        checkNullOrEmpty: false,
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value is null', () {
      // Arrange
      final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
        errorText: customErrorMessage,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
      'should return the custom error message when using a custom regex and the value does not match',
      () {
        // Arrange
        final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
          regex: RegExp('[^A-Za-z0-9]'),
          errorText: customErrorMessage,
        );
        const String value = 'abc123';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return null when using a custom regex and the value matches',
      () {
        // Arrange
        final HasSpecialCharsValidator validator = HasSpecialCharsValidator(
          regex: RegExp('[^A-Za-z0-9]'),
        );
        const String value = 'abc!@#';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );
  });
}
