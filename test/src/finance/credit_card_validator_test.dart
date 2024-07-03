import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('CreditCardValidator -', () {
    test('should return null if the credit card number is valid (Visa)', () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String validVisaCard = '4111111111111111';

      // Act
      final String? result = validator.validate(validVisaCard);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the credit card number is valid (MasterCard)',
        () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String validMasterCard = '5500000000000004';

      // Act
      final String? result = validator.validate(validMasterCard);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null if the credit card number is valid (American Express)',
        () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String validAmexCard = '340000000000009';

      // Act
      final String? result = validator.validate(validAmexCard);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the credit card number is valid (Discover)',
        () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String validDiscoverCard = '6011111111111117';

      // Act
      final String? result = validator.validate(validDiscoverCard);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the credit card number is valid (JCB)', () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String validJcbCard = '3530111333300000';

      // Act
      final String? result = validator.validate(validJcbCard);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the credit card number is valid (Diners Club)',
        () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String validDinersClubCard = '30569309025904';

      // Act
      final String? result = validator.validate(validDinersClubCard);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the credit card number is invalid',
        () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String invalidCard = '1234567890123456';

      // Act
      final String? result = validator.validate(invalidCard);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardErrorText),
      );
    });

    test(
        'should return the custom error message if the credit card number is invalid',
        () {
      // Arrange
      final CreditCardValidator validator =
          CreditCardValidator(errorText: customErrorMessage);
      const String invalidCard = '1234567890123456';

      // Act
      final String? result = validator.validate(invalidCard);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      final CreditCardValidator validator =
          CreditCardValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardErrorText),
      );
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      final CreditCardValidator validator =
          CreditCardValidator(checkNullOrEmpty: false);
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
      final CreditCardValidator validator = CreditCardValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardErrorText),
      );
    });

    test(
        'should return the default error message if the credit card number fails the Luhn check',
        () {
      // Arrange
      final CreditCardValidator validator = CreditCardValidator();
      const String invalidLuhnCard = '4111111111111112'; // Fails Luhn check

      // Act
      final String? result = validator.validate(invalidLuhnCard);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardErrorText),
      );
    });
  });
}
