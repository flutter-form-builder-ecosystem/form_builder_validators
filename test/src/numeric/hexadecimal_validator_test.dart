import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('HexadecimalValidator -', () {
    test('should return null if the value is a valid hexadecimal string', () {
      // Arrange
      final HexadecimalValidator validator =
          HexadecimalValidator(errorText: customErrorMessage);
      const String validHex = '1A3F';

      // Act
      final String? result = validator.validate(validHex);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null if the value is a valid generated hexadecimal string',
        () {
      // Arrange
      final HexadecimalValidator validator =
          HexadecimalValidator(errorText: customErrorMessage);
      final String validHex = faker.datatype.hexaDecimal();

      // Act
      final String? result = validator.validate(validHex);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error text if the value is not a valid hexadecimal string',
        () {
      // Arrange
      final HexadecimalValidator validator =
          HexadecimalValidator(errorText: customErrorMessage);
      const String invalidHex = 'XYZ123';

      // Act
      final String? result = validator.validate(invalidHex);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return the error text if the value is empty', () {
      // Arrange
      final HexadecimalValidator validator =
          HexadecimalValidator(errorText: customErrorMessage);
      const String emptyHex = '';

      // Act
      final String? result = validator.validate(emptyHex);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return the error text if the value is null', () {
      // Arrange
      final HexadecimalValidator validator =
          HexadecimalValidator(errorText: customErrorMessage);
      const String? nullHex = null;

      // Act
      final String? result = validator.validate(nullHex);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return the error text if the value is whitespace', () {
      // Arrange
      final HexadecimalValidator validator =
          HexadecimalValidator(errorText: customErrorMessage);
      const String whitespaceHex = ' ';

      // Act
      final String? result = validator.validate(whitespaceHex);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return the default error text if the value is invalid and no custom error message is provided',
        () {
      // Arrange
      final HexadecimalValidator validator = HexadecimalValidator();
      const String invalidHex = 'XYZ123';

      // Act
      final String? result = validator.validate(invalidHex);

      // Assert
      expect(result, FormBuilderLocalizations.current.hexadecimalErrorText);
    });

    test('should return null if the value is valid according to a custom regex',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[0-9a-f]+$');
      final HexadecimalValidator validator = HexadecimalValidator(
          regex: customRegex, errorText: customErrorMessage);
      const String validHex = '1a3f';

      // Act
      final String? result = validator.validate(validHex);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error text if the value is invalid according to a custom regex',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[0-9a-f]+$');
      final HexadecimalValidator validator = HexadecimalValidator(
          regex: customRegex, errorText: customErrorMessage);
      const String invalidHex = '1A3F';

      // Act
      final String? result = validator.validate(invalidHex);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      final HexadecimalValidator validator =
          HexadecimalValidator(checkNullOrEmpty: false);
      const String? nullHex = null;

      // Act
      final String? result = validator.validate(nullHex);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the value is empty and null check is disabled',
        () {
      // Arrange
      final HexadecimalValidator validator =
          HexadecimalValidator(checkNullOrEmpty: false);
      const String emptyHex = '';

      // Act
      final String? result = validator.validate(emptyHex);

      // Assert
      expect(result, isNull);
    });
  });
}
