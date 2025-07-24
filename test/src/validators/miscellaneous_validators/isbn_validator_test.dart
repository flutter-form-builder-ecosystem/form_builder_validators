import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('IsbnValidator -', () {
    test('should return null if the ISBN-10 is valid', () {
      // Arrange
      final Validator<String> validator = isbn();
      const String validIsbn10 = '0-306-40615-2';

      // Act
      final String? result = validator(validIsbn10);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the ISBN-13 is valid', () {
      // Arrange
      final Validator<String> validator = isbn();
      const String validIsbn13 = '978-3-16-148410-0';

      // Act
      final String? result = validator(validIsbn13);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the ISBN-10 is invalid',
        () {
      // Arrange
      final Validator<String> validator = isbn();
      const String invalidIsbn10 = '0-306-40615-3';

      // Act
      final String? result = validator(invalidIsbn10);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.isbnErrorText));
    });

    test('should return the default error message if the ISBN-13 is invalid',
        () {
      // Arrange
      final Validator<String> validator = isbn();
      const String invalidIsbn13 = '978-3-16-148410-1';

      // Act
      final String? result = validator(invalidIsbn13);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.isbnErrorText));
    });

    test('should return the custom error message if the ISBN is invalid', () {
      // Arrange
      final Validator<String> validator =
          isbn(isbnMsg: (_) => customErrorMessage);
      const String invalidIsbn = '978-3-16-148410-1';

      // Act
      final String? result = validator(invalidIsbn);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message if the ISBN length is neither 10 nor 13 characters',
        () {
      // Arrange
      final Validator<String> validator = isbn();
      const String invalidIsbn = '123456789';

      // Act
      final String? result = validator(invalidIsbn);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.isbnErrorText));
    });

    test('should return null if the ISBN-10 is valid without hyphens', () {
      // Arrange
      final Validator<String> validator = isbn();
      const String validIsbn10 = '0306406152';

      // Act
      final String? result = validator(validIsbn10);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the ISBN-13 is valid without hyphens', () {
      // Arrange
      final Validator<String> validator = isbn();
      const String validIsbn13 = '9783161484100';

      // Act
      final String? result = validator(validIsbn13);

      // Assert
      expect(result, isNull);
    });
  });
}
