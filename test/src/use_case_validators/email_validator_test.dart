import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('EmailValidator -', () {
    test('should return null if the email address is valid', () {
      // Arrange
      final EmailValidator validator =
          EmailValidator(errorText: customErrorMessage);
      const String validEmail = 'user@example.com';

      // Act
      final result = validator(validEmail);

      // Assert
      expect(result, isNull);
    });
    test('should return null if the email address is valid generated email',
        () {
      // Arrange
      final EmailValidator validator =
          EmailValidator(errorText: customErrorMessage);
      final String validEmail = faker.internet.email();

      // Act
      final result = validator(validEmail);

      // Assert
      expect(result, isNull);
    });

    test('should return the error text if the email address is invalid', () {
      // Arrange
      final EmailValidator validator =
          EmailValidator(errorText: customErrorMessage);
      const String invalidEmail = 'invalid-email';

      // Act
      final result = validator(invalidEmail);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return the error text if the email address is empty', () {
      // Arrange
      final EmailValidator validator =
          EmailValidator(errorText: customErrorMessage);
      const String emptyEmail = '';

      // Act
      final result = validator(emptyEmail);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return the error text if the email address is null', () {
      // Arrange
      final EmailValidator validator =
          EmailValidator(errorText: customErrorMessage);
      const nullEmail = null;

      // Act
      final result = validator(nullEmail);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return the error text if the email address is a whitespace',
        () {
      // Arrange
      final EmailValidator validator =
          EmailValidator(errorText: customErrorMessage);
      const String whitespaceEmail = ' ';

      // Act
      final result = validator(whitespaceEmail);

      // Assert
      expect(result, customErrorMessage);
    });
  });
}
