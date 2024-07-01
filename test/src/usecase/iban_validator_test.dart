import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('IbanValidator -', () {
    test('should return null if the IBAN is valid', () {
      // Arrange
      final IbanValidator validator = IbanValidator();
      const String validIban = 'DE89370400440532013000';

      // Act
      final String? result = validator.validate(validIban);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the IBAN is valid with spaces', () {
      // Arrange
      final IbanValidator validator = IbanValidator();
      const String validIban = 'DE89 3704 0044 0532 0130 00';

      // Act
      final String? result = validator.validate(validIban);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the IBAN is invalid', () {
      // Arrange
      final IbanValidator validator = IbanValidator();
      const String invalidIban = 'DE89370400440532013001';

      // Act
      final String? result = validator.validate(invalidIban);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.ibanErrorText));
    });

    test('should return the custom error message if the IBAN is invalid', () {
      // Arrange
      final IbanValidator validator =
          IbanValidator(errorText: customErrorMessage);
      const String invalidIban = 'DE89370400440532013001';

      // Act
      final String? result = validator.validate(invalidIban);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      final IbanValidator validator = IbanValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      final IbanValidator validator = IbanValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.ibanErrorText));
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      final IbanValidator validator = IbanValidator(checkNullOrEmpty: false);
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
      final IbanValidator validator = IbanValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.ibanErrorText));
    });

    test(
        'should return the default error message if the IBAN length is less than 15 characters',
        () {
      // Arrange
      final IbanValidator validator = IbanValidator();
      const String shortIban = 'DE8937040044';

      // Act
      final String? result = validator.validate(shortIban);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.ibanErrorText));
    });

    test(
        'should return null if the IBAN length is exactly 15 characters and valid',
        () {
      // Arrange
      final IbanValidator validator = IbanValidator();
      const String validShortIban = 'AL47212110090000000235698741';

      // Act
      final String? result = validator.validate(validShortIban);

      // Assert
      expect(result, isNull);
    });
  });
}
