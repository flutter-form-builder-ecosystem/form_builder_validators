import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('IsbnValidator -', () {
    test('should return null if the ISBN-10 is valid', () {
      // Arrange
      const IsbnValidator validator = IsbnValidator();
      const String validIsbn10 = '0-306-40615-2';

      // Act
      final String? result = validator.validate(validIsbn10);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the ISBN-13 is valid', () {
      // Arrange
      const IsbnValidator validator = IsbnValidator();
      const String validIsbn13 = '978-3-16-148410-0';

      // Act
      final String? result = validator.validate(validIsbn13);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the ISBN-10 is invalid',
        () {
      // Arrange
      const IsbnValidator validator = IsbnValidator();
      const String invalidIsbn10 = '0-306-40615-3';

      // Act
      final String? result = validator.validate(invalidIsbn10);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.isbnErrorText));
    });

    test('should return the default error message if the ISBN-13 is invalid',
        () {
      // Arrange
      const IsbnValidator validator = IsbnValidator();
      const String invalidIsbn13 = '978-3-16-148410-1';

      // Act
      final String? result = validator.validate(invalidIsbn13);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.isbnErrorText));
    });

    test('should return the custom error message if the ISBN is invalid', () {
      // Arrange
      final IsbnValidator validator =
          IsbnValidator(errorText: customErrorMessage);
      const String invalidIsbn = '978-3-16-148410-1';

      // Act
      final String? result = validator.validate(invalidIsbn);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const IsbnValidator validator = IsbnValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const IsbnValidator validator = IsbnValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.isbnErrorText));
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      const IsbnValidator validator = IsbnValidator(checkNullOrEmpty: false);
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
      const IsbnValidator validator = IsbnValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.isbnErrorText));
    });

    test(
        'should return the default error message if the ISBN length is neither 10 nor 13 characters',
        () {
      // Arrange
      const IsbnValidator validator = IsbnValidator();
      const String invalidIsbn = '123456789';

      // Act
      final String? result = validator.validate(invalidIsbn);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.isbnErrorText));
    });

    test('should return null if the ISBN-10 is valid without hyphens', () {
      // Arrange
      const IsbnValidator validator = IsbnValidator();
      const String validIsbn10 = '0306406152';

      // Act
      final String? result = validator.validate(validIsbn10);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the ISBN-13 is valid without hyphens', () {
      // Arrange
      const IsbnValidator validator = IsbnValidator();
      const String validIsbn13 = '9783161484100';

      // Act
      final String? result = validator.validate(validIsbn13);

      // Assert
      expect(result, isNull);
    });
  });
}
