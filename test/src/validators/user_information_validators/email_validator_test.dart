import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Validator: email', () {
    test('should return null if the email address is valid', () {
      // Arrange
      final Validator<String> validator =
          email(emailMsg: (_) => customErrorMessage);
      const String validEmail = 'user@example.com';

      // Act
      final String? result = validator(validEmail);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the email address is a valid generated email',
        () {
      // Arrange
      final Validator<String> validator =
          email(emailMsg: (_) => customErrorMessage);
      final String validEmail = faker.internet.email();

      // Act
      final String? result = validator(validEmail);

      // Assert
      expect(result, isNull);
    });

    test('should return the error text if the email address is invalid', () {
      // Arrange
      final Validator<String> validator =
          email(emailMsg: (_) => customErrorMessage);
      const String invalidEmail = 'invalid-email';

      // Act
      final String? result = validator(invalidEmail);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return the error text if the email address is empty', () {
      // Arrange
      final Validator<String> validator =
          email(emailMsg: (_) => customErrorMessage);
      const String emptyEmail = '';

      // Act
      final String? result = validator(emptyEmail);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return the error text if the email address is whitespace', () {
      // Arrange
      final Validator<String> validator =
          email(emailMsg: (_) => customErrorMessage);
      const String whitespaceEmail = ' ';

      // Act
      final String? result = validator(whitespaceEmail);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return the default error text if the email address is invalid and no custom error message is provided',
        () {
      // Arrange
      final Validator<String> validator = email();
      const String invalidEmail = 'invalid-email';

      // Act
      final String? result = validator(invalidEmail);

      // Assert
      expect(result, FormBuilderLocalizations.current.emailErrorText);
    });

    test(
        'should return null if the email address is valid according to a custom regex',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[\w\.-]+@example\.com$');
      final Validator<String> validator =
          email(regex: customRegex, emailMsg: (_) => customErrorMessage);
      const String validEmail = 'user@example.com';

      // Act
      final String? result = validator(validEmail);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error text if the email address is invalid according to a custom regex',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[\w\.-]+@example\.com$');
      final Validator<String> validator =
          email(regex: customRegex, emailMsg: (_) => customErrorMessage);
      const String invalidEmail = 'user@notexample.com';

      // Act
      final String? result = validator(invalidEmail);

      // Assert
      expect(result, customErrorMessage);
    });
  });
}
