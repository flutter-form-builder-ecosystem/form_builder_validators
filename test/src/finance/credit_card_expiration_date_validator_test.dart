import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('CreditCardExpirationDateValidator -', () {
    test(
      'should return null if the expiration date is valid and not expired',
      () {
        // Arrange
        final CreditCardExpirationDateValidator validator =
            CreditCardExpirationDateValidator();
        final String validDate =
            '${DateTime.now().add(const Duration(days: 30)).month.toString().padLeft(2, '0')}/${(DateTime.now().year % 100 + 1).toString().padLeft(2, '0')}'; // MM/YY format for next year

        // Act
        final String? result = validator.validate(validDate);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return null if the expiration date is valid and expired check is disabled',
      () {
        // Arrange
        final CreditCardExpirationDateValidator validator =
            CreditCardExpirationDateValidator(checkForExpiration: false);
        const String validDate = '01/22'; // An expired date

        // Act
        final String? result = validator.validate(validDate);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message if the expiration date is expired',
      () {
        // Arrange
        final CreditCardExpirationDateValidator validator =
            CreditCardExpirationDateValidator();
        const String expiredDate = '01/20'; // MM/YY format for an expired date

        // Act
        final String? result = validator.validate(expiredDate);

        // Assert
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.creditCardExpirationDateErrorText,
          ),
        );
      },
    );

    test(
      'should return the custom error message if the expiration date is invalid',
      () {
        // Arrange
        final CreditCardExpirationDateValidator validator =
            CreditCardExpirationDateValidator(errorText: customErrorMessage);
        const String invalidDate = '13/25'; // Invalid month

        // Act
        final String? result = validator.validate(invalidDate);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return null if the value is null and null check is disabled',
      () {
        // Arrange
        final CreditCardExpirationDateValidator validator =
            CreditCardExpirationDateValidator(checkNullOrEmpty: false);
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test('should return the default error message if the value is null', () {
      // Arrange
      final CreditCardExpirationDateValidator validator =
          CreditCardExpirationDateValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.creditCardExpirationDateErrorText,
        ),
      );
    });

    test(
      'should return null if the value is an empty string and null check is disabled',
      () {
        // Arrange
        final CreditCardExpirationDateValidator validator =
            CreditCardExpirationDateValidator(checkNullOrEmpty: false);
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message if the value is an empty string',
      () {
        // Arrange
        final CreditCardExpirationDateValidator validator =
            CreditCardExpirationDateValidator();
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.creditCardExpirationDateErrorText,
          ),
        );
      },
    );

    test(
      'should return the default error message if the expiration date is in invalid format',
      () {
        // Arrange
        final CreditCardExpirationDateValidator validator =
            CreditCardExpirationDateValidator();
        const String invalidFormatDate = '2025/01'; // Invalid format

        // Act
        final String? result = validator.validate(invalidFormatDate);

        // Assert
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.creditCardExpirationDateErrorText,
          ),
        );
      },
    );
  });
}
