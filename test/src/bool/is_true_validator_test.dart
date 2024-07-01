import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Is true -', () {
    test('should return null when the value is true', () {
      // Arrange
      const IsTrueValidator validator = IsTrueValidator();
      const bool value = true;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the custom error message when the value is false', () {
      // Arrange
      final IsTrueValidator validator =
          IsTrueValidator(errorText: customErrorMessage);
      const bool value = false;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return the custom error message when the value is null', () {
      // Arrange
      final IsTrueValidator validator =
          IsTrueValidator(errorText: customErrorMessage);
      const bool? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when not checking for null', () {
      // Arrange
      const IsTrueValidator validator =
          IsTrueValidator(checkNullOrEmpty: false);
      const bool? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
