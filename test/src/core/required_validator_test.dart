import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('RequiredValidator -', () {
    test('should return null if the value is not null', () {
      // Arrange
      const RequiredValidator<String> validator = RequiredValidator<String>();
      const String value = 'Not Null Value';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error text if the value is null', () {
      // Arrange
      final RequiredValidator<String?> validator = RequiredValidator<String?>(
        errorText: customErrorMessage,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error text if the value is empty string', () {
      // Arrange
      final RequiredValidator<String> validator = RequiredValidator<String>(
        errorText: customErrorMessage,
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the value is not null for int type', () {
      // Arrange
      const RequiredValidator<int> validator = RequiredValidator<int>();
      const int value = 42;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error text if the value is null for int type', () {
      // Arrange
      final RequiredValidator<int?> validator = RequiredValidator<int?>(
        errorText: customErrorMessage,
      );
      const int? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the value is not null for double type', () {
      // Arrange
      const RequiredValidator<double> validator = RequiredValidator<double>();
      const double value = 42;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error text if the value is null for double type', () {
      // Arrange
      final RequiredValidator<double?> validator = RequiredValidator<double?>(
        errorText: customErrorMessage,
      );
      const double? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the value is not null for List type', () {
      // Arrange
      const RequiredValidator<List<String>> validator =
          RequiredValidator<List<String>>();
      const List<String> value = <String>['Item1', 'Item2'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error text if the value is null for List type', () {
      // Arrange
      final RequiredValidator<List<String>?> validator =
          RequiredValidator<List<String>?>(errorText: customErrorMessage);
      const List<String>? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the value is not null for Map type', () {
      // Arrange
      const RequiredValidator<Map<String, String>> validator =
          RequiredValidator<Map<String, String>>();
      const Map<String, String> value = <String, String>{
        'key1': 'value1',
        'key2': 'value2',
      };

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error text if the value is null for Map type', () {
      // Arrange
      final RequiredValidator<Map<String, String>?> validator =
          RequiredValidator<Map<String, String>?>(
            errorText: customErrorMessage,
          );
      const Map<String, String>? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });
  });
}
