import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Is false -', () {
    test('should return null when the value is false', () {
      // Arrange
      const IsFalseValidator validator = IsFalseValidator();
      const bool value = false;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the custom error message when the value is true', () {
      // Arrange
      final IsFalseValidator validator = IsFalseValidator(
        errorText: customErrorMessage,
      );
      const bool value = true;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return the custom error message when the value is null', () {
      // Arrange
      final IsFalseValidator validator = IsFalseValidator(
        errorText: customErrorMessage,
      );
      const bool? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when not checking for null', () {
      // Arrange
      const IsFalseValidator validator = IsFalseValidator(
        checkNullOrEmpty: false,
      );
      const bool? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message if the value is true and no custom message is set',
      () {
        // Arrange
        const IsFalseValidator validator = IsFalseValidator();
        const bool value = true;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.mustBeFalseErrorText),
        );
      },
    );
  });
}
