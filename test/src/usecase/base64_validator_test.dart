import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Base64Validator -', () {
    test('should return null if the value is a valid base64 string', () {
      // Arrange
      const Base64Validator validator = Base64Validator();
      const String value = 'U29tZSB2YWxpZCBiYXNlNjQgc3RyaW5n';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is not a valid base64 string',
        () {
      // Arrange
      const Base64Validator validator = Base64Validator();
      const String value = 'Invalid base64 string';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.base64ErrorText));
    });

    test(
        'should return the custom error message if the value is not a valid base64 string',
        () {
      // Arrange
      final Base64Validator validator =
          Base64Validator(errorText: customErrorMessage);
      const String value = 'Invalid base64 string';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const Base64Validator validator =
          Base64Validator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const Base64Validator validator = Base64Validator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.base64ErrorText));
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      const Base64Validator validator =
          Base64Validator(checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is an empty string',
        () {
      // Arrange
      const Base64Validator validator = Base64Validator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.base64ErrorText));
    });
  });
}
