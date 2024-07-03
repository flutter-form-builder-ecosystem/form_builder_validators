import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('BicValidator -', () {
    test('should return null if the BIC is valid with 8 characters', () {
      // Arrange
      final BicValidator validator = BicValidator();
      const String validBic = 'DEUTDEFF';

      // Act
      final String? result = validator.validate(validBic);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the BIC is valid with 11 characters', () {
      // Arrange
      final BicValidator validator = BicValidator();
      const String validBic = 'DEUTDEFF500';

      // Act
      final String? result = validator.validate(validBic);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the BIC is invalid', () {
      // Arrange
      final BicValidator validator = BicValidator();
      const String invalidBic = 'INVALIDBIC';

      // Act
      final String? result = validator.validate(invalidBic);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.bicErrorText));
    });

    test('should return the custom error message if the BIC is invalid', () {
      // Arrange
      final BicValidator validator =
          BicValidator(errorText: customErrorMessage);
      const String invalidBic = 'INVALIDBIC';

      // Act
      final String? result = validator.validate(invalidBic);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      final BicValidator validator = BicValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      final BicValidator validator = BicValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.bicErrorText));
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      final BicValidator validator = BicValidator(checkNullOrEmpty: false);
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
      final BicValidator validator = BicValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.bicErrorText));
    });
  });
}
