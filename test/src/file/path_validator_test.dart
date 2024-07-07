import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('PathValidator -', () {
    test('should return null for valid file paths', () {
      // Arrange
      final PathValidator validator = PathValidator();
      const List<String> validPaths = <String>[
        '/path/to/file',
        'C:/Users/Name/Documents',
        'folder/subfolder/file.txt',
        'folder/subfolder/file-name.txt',
        'folder123/subfolder456/file789.txt',
        '/folder/sub-folder/file_name.txt',
      ];

      // Act & Assert
      for (final String value in validPaths) {
        expect(validator.validate(value), isNull);
      }
    });

    test('should return the default error message for invalid file paths', () {
      // Arrange
      final PathValidator validator = PathValidator();
      const List<String> invalidPaths = <String>[
        '/path/to/file*',
        'C:/Users/Name/Documents|file',
        'folder/subfolder/file<name>.txt',
        'folder?name/subfolder/file.txt',
        'folder/subfolder/file:name.txt',
      ];

      // Act & Assert
      for (final String value in invalidPaths) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.pathErrorText));
      }
    });

    test('should return the custom error message for invalid file paths', () {
      // Arrange
      final PathValidator validator =
          PathValidator(errorText: customErrorMessage);
      const List<String> invalidPaths = <String>[
        '/path/to/file*',
        'C:/Users/Name/Documents|file',
        'folder/subfolder/file<name>.txt',
        'folder?name/subfolder/file.txt',
        'folder/subfolder/file:name.txt',
      ];

      // Act & Assert
      for (final String value in invalidPaths) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      final PathValidator validator = PathValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      final PathValidator validator = PathValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(result, equals(FormBuilderLocalizations.current.pathErrorText));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final PathValidator validator = PathValidator(checkNullOrEmpty: false);
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
      final PathValidator validator = PathValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(result, equals(FormBuilderLocalizations.current.pathErrorText));
    });

    test(
        'should use custom regex and return the default error message for invalid custom file paths',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[a-zA-Z0-9_\-\.\\]+$');
      final PathValidator validator = PathValidator(regex: customRegex);
      const List<String> invalidPaths = <String>[
        '/path/to/file',
        'folder/subfolder/file*',
        'folder/subfolder/file<name>.txt',
        'folder?name/subfolder/file.txt',
        'folder/subfolder/file:name.txt',
      ];

      // Act & Assert
      for (final String value in invalidPaths) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.pathErrorText));
      }
    });

    test(
        'should use custom regex and return the custom error message for invalid custom file paths',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[a-zA-Z0-9_\-\.\\]+$');
      final PathValidator validator = PathValidator(
        regex: customRegex,
        errorText: customErrorMessage,
      );
      const List<String> invalidPaths = <String>[
        '/path/to/file',
        'folder/subfolder/file*',
        'folder/subfolder/file<name>.txt',
        'folder?name/subfolder/file.txt',
        'folder/subfolder/file:name.txt',
      ];

      // Act & Assert
      for (final String value in invalidPaths) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });
  });
}
