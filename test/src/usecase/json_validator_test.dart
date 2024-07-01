import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('JsonValidator -', () {
    test('should return null if the JSON string is valid', () {
      // Arrange
      const JsonValidator validator = JsonValidator();
      const String validJson =
          '{"name": "John", "age": 30, "city": "New York"}';

      // Act
      final String? result = validator.validate(validJson);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the JSON string is valid with arrays', () {
      // Arrange
      const JsonValidator validator = JsonValidator();
      const String validJson =
          '{"name": "John", "age": 30, "cities": ["New York", "Los Angeles"]}';

      // Act
      final String? result = validator.validate(validJson);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the JSON string is invalid',
        () {
      // Arrange
      const JsonValidator validator = JsonValidator();
      const String invalidJson =
          '{"name": "John", "age": 30, "city": "New York"';

      // Act
      final String? result = validator.validate(invalidJson);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.jsonErrorText));
    });

    test('should return the custom error message if the JSON string is invalid',
        () {
      // Arrange
      final JsonValidator validator =
          JsonValidator(errorText: customErrorMessage);
      const String invalidJson =
          '{"name": "John", "age": 30, "city": "New York"';

      // Act
      final String? result = validator.validate(invalidJson);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const JsonValidator validator = JsonValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const JsonValidator validator = JsonValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.jsonErrorText));
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      const JsonValidator validator = JsonValidator(checkNullOrEmpty: false);
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
      const JsonValidator validator = JsonValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.jsonErrorText));
    });

    test('should return null if the JSON string is valid with nested objects',
        () {
      // Arrange
      const JsonValidator validator = JsonValidator();
      const String validJson =
          '{"person": {"name": "John", "age": 30, "address": {"city": "New York", "zip": "10001"}}}';

      // Act
      final String? result = validator.validate(validJson);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the JSON string is valid with boolean values',
        () {
      // Arrange
      const JsonValidator validator = JsonValidator();
      const String validJson = '{"name": "John", "active": true}';

      // Act
      final String? result = validator.validate(validJson);

      // Assert
      expect(result, isNull);
    });
  });
}
