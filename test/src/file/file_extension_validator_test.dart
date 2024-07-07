import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('FileExtensionValidator -', () {
    test('should return null when the file extension is in the allowed list',
        () {
      // Arrange
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator =
          FileExtensionValidator(allowedExtensions);
      const String value = 'image.jpg';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the file extension is in the allowed list with mixed case',
        () {
      // Arrange
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator =
          FileExtensionValidator(allowedExtensions);
      const String value = 'image.JPG';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the file extension is not in the allowed list',
        () {
      // Arrange
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator =
          FileExtensionValidator(allowedExtensions);
      const String value = 'document.pdf';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current
              .fileExtensionErrorText(allowedExtensions.join(', ')),
        ),
      );
    });

    test(
        'should return the custom error message when the file extension is not in the allowed list',
        () {
      // Arrange
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      final FileExtensionValidator validator = FileExtensionValidator(
        allowedExtensions,
        errorText: customErrorMessage,
      );
      const String value = 'document.pdf';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator = FileExtensionValidator(
        allowedExtensions,
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
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator =
          FileExtensionValidator(allowedExtensions);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current
              .fileExtensionErrorText(allowedExtensions.join(', ')),
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator = FileExtensionValidator(
        allowedExtensions,
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
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator =
          FileExtensionValidator(allowedExtensions);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current
              .fileExtensionErrorText(allowedExtensions.join(', ')),
        ),
      );
    });

    test('should return null when the value has a valid path with extension',
        () {
      // Arrange
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator =
          FileExtensionValidator(allowedExtensions);
      const String value = 'path/to/image.jpg';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message for invalid file path format',
        () {
      // Arrange
      const List<String> allowedExtensions = <String>['jpg', 'png', 'gif'];
      const FileExtensionValidator validator =
          FileExtensionValidator(allowedExtensions);
      const String value = 'invalidpath';

      // Act & Assert
      expect(() => validator.validate(value), throwsA(isA<AssertionError>()));
    });
  });
}
