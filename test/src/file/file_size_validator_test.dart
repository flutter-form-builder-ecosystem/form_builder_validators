import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('FileSizeValidator -', () {
    test('should return null when the file size is equal to the maximum size',
        () {
      // Arrange
      const int maxSize = 1024;
      const FileSizeValidator validator = FileSizeValidator(maxSize);
      const String value = '1024';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the file size is less than the maximum size',
        () {
      // Arrange
      const int maxSize = 1024;
      const FileSizeValidator validator = FileSizeValidator(maxSize);
      const String value = '512';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the file size is greater than the maximum size',
        () {
      // Arrange
      const int maxSize = 1024;
      const FileSizeValidator validator = FileSizeValidator(maxSize);
      const String value = '2048';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.fileSizeErrorText('0 B', '1 KiB'),
        ),
      );
    });

    test(
        'should return the custom error message when the file size is greater than the maximum size',
        () {
      // Arrange
      const int maxSize = 1024;
      final FileSizeValidator validator =
          FileSizeValidator(maxSize, errorText: customErrorMessage);
      const String value = '2048';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const int maxSize = 1024;
      const FileSizeValidator validator =
          FileSizeValidator(maxSize, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const int maxSize = 1024;
      const FileSizeValidator validator = FileSizeValidator(maxSize);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.fileSizeErrorText('0 B', '1 KiB'),
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const int maxSize = 1024;
      const FileSizeValidator validator =
          FileSizeValidator(maxSize, checkNullOrEmpty: false);
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
      const int maxSize = 1024;
      const FileSizeValidator validator = FileSizeValidator(maxSize);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.fileSizeErrorText('0 B', '1 KiB'),
        ),
      );
    });

    test('should return null for a valid file size within the allowed range',
        () {
      // Arrange
      const int maxSize = 1024;
      const FileSizeValidator validator = FileSizeValidator(maxSize);
      const String value = '512';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message for invalid file size format',
        () {
      // Arrange
      const int maxSize = 1024;
      const FileSizeValidator validator = FileSizeValidator(maxSize);
      const String value = 'invalid-size';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.fileSizeErrorText('0 B', '1 KiB'),
        ),
      );
    });

    test('should return the custom error message for invalid file size format',
        () {
      // Arrange
      const int maxSize = 1024;
      final FileSizeValidator validator =
          FileSizeValidator(maxSize, errorText: customErrorMessage);
      const String value = 'invalid-size';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    group('FileSizeValidator with base1024Conversion set to false -', () {
      test('should return null when the file size is equal to the maximum size',
          () {
        // Arrange
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
        );
        const String value = '1000';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test(
          'should return null when the file size is less than the maximum size',
          () {
        // Arrange
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
        );
        const String value = '512';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test(
          'should return the default error message when the file size is greater than the maximum size',
          () {
        // Arrange
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
        );
        const String value = '2000';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.fileSizeErrorText('0 B', '1 kB'),
          ),
        );
      });

      test(
          'should return the custom error message when the file size is greater than the maximum size',
          () {
        // Arrange
        const int maxSize = 1000;
        final FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
          errorText: customErrorMessage,
        );
        const String value = '2000';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });

      test(
          'should return null when the value is null and null check is disabled',
          () {
        // Arrange
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
          checkNullOrEmpty: false,
        );
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return the default error message when the value is null',
          () {
        // Arrange
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
        );
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.fileSizeErrorText('0 B', '1 kB'),
          ),
        );
      });

      test(
          'should return null when the value is an empty string and null check is disabled',
          () {
        // Arrange
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
          checkNullOrEmpty: false,
        );
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
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
        );
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.fileSizeErrorText('0 B', '1 kB'),
          ),
        );
      });

      test('should return null for a valid file size within the allowed range',
          () {
        // Arrange
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
        );
        const String value = '500';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test(
          'should return the default error message for invalid file size format',
          () {
        // Arrange
        const int maxSize = 1000;
        const FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
        );
        const String value = 'invalid-size';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.fileSizeErrorText('0 B', '1 kB'),
          ),
        );
      });

      test(
          'should return the custom error message for invalid file size format',
          () {
        // Arrange
        const int maxSize = 1000;
        final FileSizeValidator validator = FileSizeValidator(
          maxSize,
          base1024Conversion: false,
          errorText: customErrorMessage,
        );
        const String value = 'invalid-size';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });
  });
}
