import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/constants.dart';
import 'package:form_builder_validators/src/validators/finance_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('IbanValidator -', () {
    test('should return null if the IBAN is valid', () {
      // Arrange
      final Validator<String> validator = iban();
      const String validIban = 'DE89370400440532013000';

      // Act
      final String? result = validator(validIban);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the IBAN is valid with spaces', () {
      // Arrange
      final Validator<String> validator = iban();
      const String validIban = 'DE89 3704 0044 0532 0130 00';

      // Act
      final String? result = validator(validIban);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the IBAN is invalid', () {
      // Arrange
      final Validator<String> validator = iban();
      const String invalidIban = 'DE89370400440532013001';

      // Act
      final String? result = validator(invalidIban);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.ibanErrorText));
    });

    test(
      'should return the custom error message if the IBAN Validator<String> is invalid',
      () {
        // Arrange
        final Validator<String> validator = iban(
          ibanMsg: (_) => customErrorMessage,
        );
        const String invalidIban = 'DE89370400440532013001';

        // Act
        final String? result = validator(invalidIban);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return the default error message if the value is an empty string',
      () {
        // Arrange
        final Validator<String> validator = iban();
        const String value = '';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(FormBuilderLocalizations.current.ibanErrorText));
      },
    );

    test(
      'should return the default error message if the IBAN length is less than 15 characters',
      () {
        // Arrange
        final Validator<String> validator = iban();
        const String shortIban = 'DE8937040044';

        // Act
        final String? result = validator(shortIban);

        // Assert
        expect(result, equals(FormBuilderLocalizations.current.ibanErrorText));
      },
    );

    test(
      'should return null if the IBAValidator<String> N length is exactly 15 characters and valid',
      () {
        // Arrange
        final Validator<String> validator = iban();
        const String validShortIban = 'AL47212110090000000235698741';

        // Act
        final String? result = validator(validShortIban);

        // Assert
        expect(result, isNull);
      },
    );
  });
}
