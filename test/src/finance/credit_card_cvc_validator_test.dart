import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('CreditCardCvcValidator -', () {
    test('should return null if the CVC is valid (3 digits)', () {
      // Arrange
      const CreditCardCvcValidator validator = CreditCardCvcValidator();
      const String validCvc = '123';

      // Act
      final String? result = validator.validate(validCvc);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the CVC is valid (4 digits)', () {
      // Arrange
      const CreditCardCvcValidator validator = CreditCardCvcValidator();
      const String validCvc = '1234';

      // Act
      final String? result = validator.validate(validCvc);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the CVC is invalid (less than 3 digits)',
        () {
      // Arrange
      const CreditCardCvcValidator validator = CreditCardCvcValidator();
      const String invalidCvc = '12';

      // Act
      final String? result = validator.validate(invalidCvc);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardCVCErrorText),
      );
    });

    test(
        'should return the default error message if the CVC is invalid (more than 4 digits)',
        () {
      // Arrange
      const CreditCardCvcValidator validator = CreditCardCvcValidator();
      const String invalidCvc = '12345';

      // Act
      final String? result = validator.validate(invalidCvc);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardCVCErrorText),
      );
    });

    test('should return the custom error message if the CVC is invalid', () {
      // Arrange
      final CreditCardCvcValidator validator =
          CreditCardCvcValidator(errorText: customErrorMessage);
      const String invalidCvc = 'abc';

      // Act
      final String? result = validator.validate(invalidCvc);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const CreditCardCvcValidator validator =
          CreditCardCvcValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const CreditCardCvcValidator validator = CreditCardCvcValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardCVCErrorText),
      );
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      const CreditCardCvcValidator validator =
          CreditCardCvcValidator(checkNullOrEmpty: false);
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
      const CreditCardCvcValidator validator = CreditCardCvcValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardCVCErrorText),
      );
    });

    test(
        'should return the default error message if the CVC contains non-numeric characters',
        () {
      // Arrange
      const CreditCardCvcValidator validator = CreditCardCvcValidator();
      const String invalidCvc = '12a';

      // Act
      final String? result = validator.validate(invalidCvc);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.creditCardCVCErrorText),
      );
    });
  });
}
