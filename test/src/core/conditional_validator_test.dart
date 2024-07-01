import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('ConditionalValidator -', () {
    test('should return null if the condition is false', () {
      // Arrange
      final ConditionalValidator<String> validator =
          ConditionalValidator<String>(
        (String? value) => false,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the condition is true and value is invalid',
        () {
      // Arrange
      final ConditionalValidator<String> validator =
          ConditionalValidator<String>(
        (String? value) => true,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the condition is true and value is valid', () {
      // Arrange
      final ConditionalValidator<String> validator =
          ConditionalValidator<String>(
        (String? value) => true,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = 'valid';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null if the condition is false even if value is invalid',
        () {
      // Arrange
      final ConditionalValidator<String> validator =
          ConditionalValidator<String>(
        (String? value) => false,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should work with a custom condition', () {
      // Arrange
      final ConditionalValidator<String> validator =
          ConditionalValidator<String>(
        (String? value) => value == 'check',
        FormBuilderValidators.required(errorText: customErrorMessage),
      );

      // Act
      final String? result1 = validator.validate('check');
      final String? result2 = validator.validate('');

      // Assert
      expect(result1, customErrorMessage);
      expect(result2, isNull);
    });

    test('should return null if value is null and condition is false', () {
      // Arrange
      final ConditionalValidator<String> validator =
          ConditionalValidator<String>(
        (String? value) => false,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error if value is null and condition is true', () {
      // Arrange
      final ConditionalValidator<String> validator =
          ConditionalValidator<String>(
        (String? value) => true,
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });
  });
}
