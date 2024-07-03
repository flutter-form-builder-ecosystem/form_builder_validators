import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('PasswordValidator -', () {
    test('should return null if the password meets all requirements', () {
      // Arrange
      const PasswordValidator validator = PasswordValidator();
      const String validPassword = 'Abcde12345!';

      // Act
      final String? result = validator.validate(validPassword);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the password is too short', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String shortPassword = 'Ab1!';

      // Act
      final String? result = validator.validate(shortPassword);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the password is too long', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(maxLength: 8, errorText: customErrorMessage);
      const String longPassword = 'Abcdefgh12345!';

      // Act
      final String? result = validator.validate(longPassword);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if the password does not have enough uppercase characters',
        () {
      // Arrange
      final PasswordValidator validator = PasswordValidator(
        minUppercaseCount: 2,
        errorText: customErrorMessage,
      );
      const String password = 'aabcde12345!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if the password does not have enough lowercase characters',
        () {
      // Arrange
      final PasswordValidator validator = PasswordValidator(
        minLowercaseCount: 2,
        errorText: customErrorMessage,
      );
      const String password = 'AABCDE12345!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if the password does not have enough numeric characters',
        () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(minNumberCount: 2, errorText: customErrorMessage);
      const String password = 'Abcdefgh!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if the password does not have enough special characters',
        () {
      // Arrange
      final PasswordValidator validator = PasswordValidator(
        minSpecialCharCount: 2,
        errorText: customErrorMessage,
      );
      const String password = 'Abcdefgh12345';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the password meets all customized requirements',
        () {
      // Arrange
      const PasswordValidator validator = PasswordValidator(
        minLength: 10,
        maxLength: 20,
        minUppercaseCount: 2,
        minLowercaseCount: 2,
        minNumberCount: 2,
        minSpecialCharCount: 2,
      );
      const String validPassword = 'AbcdefG12!@';

      // Act
      final String? result = validator.validate(validPassword);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the value is null', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the value is empty', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the password has no uppercase letters', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String password = 'abcdef12345!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the password has no lowercase letters', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String password = 'ABCDEF12345!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the password has no numeric characters', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String password = 'Abcdefghijk!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the password has no special characters', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String password = 'Abcdefgh12345';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the password has only one special character',
        () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String password = 'Abcdefgh12345!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the password meets the exact min length', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(errorText: customErrorMessage);
      const String password = 'Abcde123!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the password meets the exact max length', () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(maxLength: 12, errorText: customErrorMessage);
      const String password = 'Abcde12345!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return error if the password does not meet the min numeric characters requirement',
        () {
      // Arrange
      final PasswordValidator validator =
          PasswordValidator(minNumberCount: 3, errorText: customErrorMessage);
      const String password = 'Abcdefgh!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if the password does not meet the min special characters requirement',
        () {
      // Arrange
      final PasswordValidator validator = PasswordValidator(
        minSpecialCharCount: 2,
        errorText: customErrorMessage,
      );
      const String password = 'Abcdefgh12345!';

      // Act
      final String? result = validator.validate(password);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return null if the password meets all requirements including min and max length',
        () {
      // Arrange
      const PasswordValidator validator = PasswordValidator(
        maxLength: 12,
      );
      const String validPassword = 'Abcde123!';

      // Act
      final String? result = validator.validate(validPassword);

      // Assert
      expect(result, isNull);
    });
  });
}
