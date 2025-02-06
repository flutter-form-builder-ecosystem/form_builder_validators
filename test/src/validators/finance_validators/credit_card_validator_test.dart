import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Validator: creditCard', () {
    test('should return null if the credit card number is valid (Visa)', () {
      // Arrange
      final Validator<String> validator = creditCard();
      const String validVisaCard = '4111111111111111';

      // Act
      final String? result = validator(validVisaCard);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the credit card number is valid (MasterCard)',
        () {
      // Arrange
      final Validator<String> validator = creditCard();
      const String validMasterCard = '5500000000000004';

      // Act
      final String? result = validator(validMasterCard);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null if the credit card number is valid (American Express)',
        () {
      // Arrange
      final Validator<String> validator = creditCard();
      const String validAmexCard = '340000000000009';

      // Act
      final String? result = validator(validAmexCard);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the credit card number is valid (Discover)',
        () {
      // Arrange
      final Validator<String> validator = creditCard();
      const String validDiscoverCard = '6011111111111117';

      // Act
      final String? result = validator(validDiscoverCard);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the credit card number is valid (JCB)', () {
      // Arrange
      final Validator<String> validator = creditCard();
      const String validJcbCard = '3530111333300000';

      // Act
      final String? result = validator(validJcbCard);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the credit card number is valid (Diners Club)',
        () {
      // Arrange
      final Validator<String> validator = creditCard();
      const String validDinersClubCard = '30569309025904';

      // Act
      final String? result = validator(validDinersClubCard);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the credit card number is invalid',
        () {
      // Arrange
      final Validator<String> validator = creditCard();
      const String invalidCard = '1234567890123456';

      // Act
      final String? result = validator(invalidCard);

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
      final Validator<String> validator =
          creditCard(creditCardMsg: (_) => customErrorMessage);
      const String invalidCard = '1234567890123456';

      // Act
      final String? result = validator(invalidCard);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message if the value is an empty string',
        () {
      // Arrange
      final Validator<String> validator = creditCard();
      const String value = '';

      // Act
      final String? result = validator(value);

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
      final Validator<String> validator = creditCard();
      const String invalidLuhnCard = '4111111111111112'; // Fails Luhn check

      // Act
      final String? result = validator(invalidLuhnCard);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardErrorText),
      );
    });
  });
}
