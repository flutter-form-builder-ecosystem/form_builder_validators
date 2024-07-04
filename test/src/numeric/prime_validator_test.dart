import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('PrimeNumberValidator -', () {
    test('should return null for valid prime number strings', () {
      // Arrange
      const PrimeNumberValidator<String> validator =
          PrimeNumberValidator<String>();

      // Act & Assert
      expect(validator.validate('2'), isNull);
      expect(validator.validate('3'), isNull);
      expect(validator.validate('5'), isNull);
      expect(validator.validate('7'), isNull);
      expect(validator.validate('11'), isNull);
    });

    test('should return null for valid prime numbers', () {
      // Arrange
      const PrimeNumberValidator<num> validator = PrimeNumberValidator<num>();

      // Act & Assert
      expect(validator.validate(2), isNull);
      expect(validator.validate(3), isNull);
      expect(validator.validate(5), isNull);
      expect(validator.validate(7), isNull);
      expect(validator.validate(11), isNull);
    });

    test(
        'should return the default error message for invalid prime number strings',
        () {
      // Arrange
      const PrimeNumberValidator<String> validator =
          PrimeNumberValidator<String>();

      // Act & Assert
      expect(
        validator.validate('4'),
        equals(FormBuilderLocalizations.current.primeNumberErrorText),
      );
      expect(
        validator.validate('10'),
        equals(FormBuilderLocalizations.current.primeNumberErrorText),
      );
    });

    test(
        'should return the custom error message for invalid prime number strings',
        () {
      // Arrange
      final PrimeNumberValidator<String> validator =
          PrimeNumberValidator<String>(
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('4'), equals(customErrorMessage));
      expect(validator.validate('10'), equals(customErrorMessage));
    });

    test('should return the default error message for invalid prime numbers',
        () {
      // Arrange
      const PrimeNumberValidator<int> validator = PrimeNumberValidator<int>();

      // Act & Assert
      expect(
        validator.validate(4),
        equals(FormBuilderLocalizations.current.primeNumberErrorText),
      );
      expect(
        validator.validate(10),
        equals(FormBuilderLocalizations.current.primeNumberErrorText),
      );
    });

    test('should return the custom error message for invalid prime numbers',
        () {
      // Arrange
      final PrimeNumberValidator<num> validator = PrimeNumberValidator<num>(
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate(4), equals(customErrorMessage));
      expect(validator.validate(10), equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const PrimeNumberValidator<String> validator =
          PrimeNumberValidator<String>(
        checkNullOrEmpty: false,
      );
      const String value = '';

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const PrimeNumberValidator<String> validator =
          PrimeNumberValidator<String>(
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });
  });
}
