import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('DefaultValueValidator -', () {
    test('should use default value if the value is null', () {
      // Arrange
      const String defaultValue = 'default';
      final DefaultValueValidator<String> validator =
          DefaultValueValidator<String>(
        defaultValue,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should use provided value if it is not null', () {
      // Arrange
      const String defaultValue = 'default';
      final DefaultValueValidator<String> validator =
          DefaultValueValidator<String>(
        defaultValue,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = 'provided';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the default value is invalid', () {
      // Arrange
      const String defaultValue = '';
      final DefaultValueValidator<String> validator =
          DefaultValueValidator<String>(
        defaultValue,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the provided value is invalid', () {
      // Arrange
      const String defaultValue = 'default';
      final DefaultValueValidator<String> validator =
          DefaultValueValidator<String>(
        defaultValue,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the provided value is valid', () {
      // Arrange
      const String defaultValue = 'default';
      final DefaultValueValidator<String> validator =
          DefaultValueValidator<String>(
        defaultValue,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = 'valid';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the default value is valid', () {
      // Arrange
      const String defaultValue = 'valid';
      final DefaultValueValidator<String> validator =
          DefaultValueValidator<String>(
        defaultValue,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should handle numeric default value correctly', () {
      // Arrange
      const int defaultValue = 5;
      final DefaultValueValidator<int> validator = DefaultValueValidator<int>(
        defaultValue,
        FormBuilderValidators.min(3, errorText: customErrorMessage),
      );
      const int? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should handle numeric provided value correctly', () {
      // Arrange
      const int defaultValue = 5;
      final DefaultValueValidator<int> validator = DefaultValueValidator<int>(
        defaultValue,
        FormBuilderValidators.min(3, errorText: customErrorMessage),
      );
      const int value = 2;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });
  });
}
