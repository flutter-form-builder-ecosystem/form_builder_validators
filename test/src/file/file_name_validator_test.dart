import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('FileNameValidator -', () {
    test('should return null for valid file names', () {
      // Arrange
      final FileNameValidator validator = FileNameValidator();
      const List<String> validFileNames = <String>[
        'file.txt',
        'file-name.txt',
        'file_name.txt',
        'file.name.txt',
        'file123.txt',
        '123file.txt',
      ];

      // Act & Assert
      for (final String value in validFileNames) {
        expect(validator.validate(value), isNull);
      }
    });

    test('should return the default error message for invalid file names', () {
      // Arrange
      final FileNameValidator validator = FileNameValidator();
      const List<String> invalidFileNames = <String>[
        'file@.txt',
        'file/name.txt',
        r'file\name.txt',
        'file:name.txt',
        'file*name.txt',
        'file?name.txt',
        'file"name.txt',
        'file<name>.txt',
        'file|name.txt',
      ];

      // Act & Assert
      for (final String value in invalidFileNames) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.fileNameErrorText),
        );
      }
    });

    test('should return the custom error message for invalid file names', () {
      // Arrange
      final FileNameValidator validator =
          FileNameValidator(errorText: customErrorMessage);
      const List<String> invalidFileNames = <String>[
        'file@.txt',
        'file/name.txt',
        r'file\name.txt',
        'file:name.txt',
        'file*name.txt',
        'file?name.txt',
        'file"name.txt',
        'file<name>.txt',
        'file|name.txt',
      ];

      // Act & Assert
      for (final String value in invalidFileNames) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      final FileNameValidator validator =
          FileNameValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      final FileNameValidator validator = FileNameValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.fileNameErrorText),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final FileNameValidator validator =
          FileNameValidator(checkNullOrEmpty: false);
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
      final FileNameValidator validator = FileNameValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.fileNameErrorText),
      );
    });

    test('should use custom regex and return null for valid custom file names',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[a-zA-Z0-9_\-]+$');
      final FileNameValidator validator = FileNameValidator(regex: customRegex);
      const List<String> validFileNames = <String>[
        'file',
        'file-name',
        'file_name',
        'filename123',
        '123filename',
      ];

      // Act & Assert
      for (final String value in validFileNames) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
        'should use custom regex and return the default error message for invalid custom file names',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[a-zA-Z0-9_\-]+$');
      final FileNameValidator validator = FileNameValidator(regex: customRegex);
      const List<String> invalidFileNames = <String>[
        'file@',
        'file/name',
        r'file\name',
        'file:name',
        'file*name',
        'file?name',
        'file"name',
        'file<name>',
        'file|name',
      ];

      // Act & Assert
      for (final String value in invalidFileNames) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.fileNameErrorText),
        );
      }
    });

    test(
        'should use custom regex and return the custom error message for invalid custom file names',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[a-zA-Z0-9_\-]+$');
      final FileNameValidator validator = FileNameValidator(
        regex: customRegex,
        errorText: customErrorMessage,
      );
      const List<String> invalidFileNames = <String>[
        'file@',
        'file/name',
        r'file\name',
        'file:name',
        'file*name',
        'file?name',
        'file"name',
        'file<name>',
        'file|name',
      ];

      // Act & Assert
      for (final String value in invalidFileNames) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });
  });
}
