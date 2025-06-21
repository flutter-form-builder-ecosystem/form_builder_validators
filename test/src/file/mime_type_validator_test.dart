import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MimeTypeValidator -', () {
    test('should return null for a valid MIME type', () {
      // Arrange
      final MimeTypeValidator validator = MimeTypeValidator();
      const String value = 'application/json';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null for another valid MIME type', () {
      // Arrange
      final MimeTypeValidator validator = MimeTypeValidator();
      const String value = 'image/png';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message for an invalid MIME type',
      () {
        // Arrange
        final MimeTypeValidator validator = MimeTypeValidator();
        const String value = 'invalid*235/mimetype';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.invalidMimeTypeErrorText),
        );
      },
    );

    test('should return the custom error message for an invalid MIME type', () {
      // Arrange
      final MimeTypeValidator validator = MimeTypeValidator(
        errorText: customErrorMessage,
      );
      const String value = 'invalid/test/mimetype';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
      'should return null when the value is null and null check is disabled',
      () {
        // Arrange
        final MimeTypeValidator validator = MimeTypeValidator(
          checkNullOrEmpty: false,
        );
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test('should return the default error message when the value is null', () {
      // Arrange
      final MimeTypeValidator validator = MimeTypeValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.invalidMimeTypeErrorText),
      );
    });

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        final MimeTypeValidator validator = MimeTypeValidator(
          checkNullOrEmpty: false,
        );
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the value is an empty string',
      () {
        // Arrange
        final MimeTypeValidator validator = MimeTypeValidator();
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.invalidMimeTypeErrorText),
        );
      },
    );

    test(
      'should return null for a valid MIME type within the allowed range',
      () {
        // Arrange
        final MimeTypeValidator validator = MimeTypeValidator();
        const String value = 'text/html';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message for invalid MIME type format',
      () {
        // Arrange
        final MimeTypeValidator validator = MimeTypeValidator();
        const String value = 'invalid-mime-type';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.invalidMimeTypeErrorText),
        );
      },
    );

    test(
      'should return the custom error message for invalid MIME type format',
      () {
        // Arrange
        final MimeTypeValidator validator = MimeTypeValidator(
          errorText: customErrorMessage,
        );
        const String value = 'invalid-mime-type';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );
  });
}
