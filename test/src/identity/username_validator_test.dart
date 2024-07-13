import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('UsernameValidator -', () {
    test('should return null if the username meets all requirements', () {
      // Arrange
      const UsernameValidator validator = UsernameValidator();
      const String validUsername = 'validUsername';

      // Act
      final String? result = validator.validate(validUsername);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the username is too short', () {
      // Arrange
      final UsernameValidator validator =
          UsernameValidator(minLength: 5, errorText: customErrorMessage);
      const String shortUsername = 'usr';

      // Act
      final String? result = validator.validate(shortUsername);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the username is too long', () {
      // Arrange
      final UsernameValidator validator =
          UsernameValidator(maxLength: 10, errorText: customErrorMessage);
      const String longUsername = 'thisIsAVeryLongUsername';

      // Act
      final String? result = validator.validate(longUsername);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if numbers are not allowed and username contains numbers',
        () {
      // Arrange
      final UsernameValidator validator =
          UsernameValidator(allowNumbers: false, errorText: customErrorMessage);
      const String usernameWithNumbers = 'user123';

      // Act
      final String? result = validator.validate(usernameWithNumbers);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if underscores are not allowed and username contains underscores',
        () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText: customErrorMessage,
      );
      const String usernameWithUnderscore = 'user_name';

      // Act
      final String? result = validator.validate(usernameWithUnderscore);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if dots are not allowed and username contains dots',
        () {
      // Arrange
      final UsernameValidator validator =
          UsernameValidator(errorText: customErrorMessage);
      const String usernameWithDot = 'user.name';

      // Act
      final String? result = validator.validate(usernameWithDot);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if dashes are not allowed and username contains dashes',
        () {
      // Arrange
      final UsernameValidator validator =
          UsernameValidator(errorText: customErrorMessage);
      const String usernameWithDash = 'user-name';

      // Act
      final String? result = validator.validate(usernameWithDash);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if spaces are not allowed and username contains spaces',
        () {
      // Arrange
      final UsernameValidator validator =
          UsernameValidator(errorText: customErrorMessage);
      const String usernameWithSpace = 'user name';

      // Act
      final String? result = validator.validate(usernameWithSpace);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return error if special characters are not allowed and username contains special characters',
        () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText: customErrorMessage,
      );
      const String usernameWithSpecialChar = 'user@name';

      // Act
      final String? result = validator.validate(usernameWithSpecialChar);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the username meets all customized requirements',
        () {
      // Arrange
      const UsernameValidator validator = UsernameValidator(
        minLength: 5,
        maxLength: 10,
        allowNumbers: false,
        allowUnderscore: true,
        allowDots: true,
        allowDash: true,
        allowSpace: true,
        allowSpecialChar: true,
      );
      const String validUsername = 'user_name.';

      // Act
      final String? result = validator.validate(validUsername);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the value is null', () {
      // Arrange
      final UsernameValidator validator =
          UsernameValidator(errorText: customErrorMessage);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the value is empty', () {
      // Arrange
      final UsernameValidator validator =
          UsernameValidator(errorText: customErrorMessage);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return null if the username allows all characters and contains all characters',
        () {
      // Arrange
      const UsernameValidator validator = UsernameValidator(
        minLength: 5,
        maxLength: 20,
        allowUnderscore: true,
        allowDots: true,
        allowDash: true,
        allowSpace: true,
        allowSpecialChar: true,
      );
      const String validUsername = 'user_name. 123-@!';

      // Act
      final String? result = validator.validate(validUsername);

      // Assert
      expect(result, isNull);
    });

    // Additional tests to cover FormBuilderLocalizations
    test('should return localized error if username is too short', () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        minLength: 5,
        errorText: FormBuilderLocalizations.current.minLengthErrorText(5),
      );
      const String shortUsername = 'usr';

      // Act
      final String? result = validator.validate(shortUsername);

      // Assert
      expect(result, FormBuilderLocalizations.current.minLengthErrorText(5));
    });

    test('should return localized error if username is too long', () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        maxLength: 10,
        errorText: FormBuilderLocalizations.current.maxLengthErrorText(10),
      );
      const String longUsername = 'thisIsAVeryLongUsername';

      // Act
      final String? result = validator.validate(longUsername);

      // Assert
      expect(result, FormBuilderLocalizations.current.maxLengthErrorText(10));
    });

    test(
        'should return localized error if numbers are not allowed and username contains numbers',
        () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        allowNumbers: false,
        errorText: FormBuilderLocalizations
            .current.usernameCannotContainNumbersErrorText,
      );
      const String usernameWithNumbers = 'user123';

      // Act
      final String? result = validator.validate(usernameWithNumbers);

      // Assert
      expect(
        result,
        FormBuilderLocalizations.current.usernameCannotContainNumbersErrorText,
      );
    });

    test(
        'should return localized error if underscores are not allowed and username contains underscores',
        () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText: FormBuilderLocalizations
            .current.usernameCannotContainUnderscoreErrorText,
      );
      const String usernameWithUnderscore = 'user_name';

      // Act
      final String? result = validator.validate(usernameWithUnderscore);

      // Assert
      expect(
        result,
        FormBuilderLocalizations
            .current.usernameCannotContainUnderscoreErrorText,
      );
    });

    test(
        'should return localized error if dots are not allowed and username contains dots',
        () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText:
            FormBuilderLocalizations.current.usernameCannotContainDotsErrorText,
      );
      const String usernameWithDot = 'user.name';

      // Act
      final String? result = validator.validate(usernameWithDot);

      // Assert
      expect(
        result,
        FormBuilderLocalizations.current.usernameCannotContainDotsErrorText,
      );
    });

    test(
        'should return localized error if dashes are not allowed and username contains dashes',
        () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText: FormBuilderLocalizations
            .current.usernameCannotContainDashesErrorText,
      );
      const String usernameWithDash = 'user-name';

      // Act
      final String? result = validator.validate(usernameWithDash);

      // Assert
      expect(
        result,
        FormBuilderLocalizations.current.usernameCannotContainDashesErrorText,
      );
    });

    test(
        'should return localized error if spaces are not allowed and username contains spaces',
        () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText: FormBuilderLocalizations
            .current.usernameCannotContainSpacesErrorText,
      );
      const String usernameWithSpace = 'user name';

      // Act
      final String? result = validator.validate(usernameWithSpace);

      // Assert
      expect(
        result,
        FormBuilderLocalizations.current.usernameCannotContainSpacesErrorText,
      );
    });

    test(
        'should return localized error if special characters are not allowed and username contains special characters',
        () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText: FormBuilderLocalizations
            .current.usernameCannotContainSpecialCharErrorText,
      );
      const String usernameWithSpecialChar = 'user@name';

      // Act
      final String? result = validator.validate(usernameWithSpecialChar);

      // Assert
      expect(
        result,
        FormBuilderLocalizations
            .current.usernameCannotContainSpecialCharErrorText,
      );
    });

    test('should return localized error if value is null', () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText: FormBuilderLocalizations.current.usernameErrorText,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, FormBuilderLocalizations.current.usernameErrorText);
    });

    test('should return localized error if value is empty', () {
      // Arrange
      final UsernameValidator validator = UsernameValidator(
        errorText: FormBuilderLocalizations.current.usernameErrorText,
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, FormBuilderLocalizations.current.usernameErrorText);
    });
    test('should return null if the username meets all customized requirements',
        () {
      // Arrange
      const UsernameValidator validator = UsernameValidator(
        minLength: 4,
        maxLength: 15,
        allowNumbers: true,
      );
      const String validUsername = 'abc1';

      // Act
      final String? result = validator.validate(validUsername);

      // Assert
      expect(result, isNull);
    });
  });
}
