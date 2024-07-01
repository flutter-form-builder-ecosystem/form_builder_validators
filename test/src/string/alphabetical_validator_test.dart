import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('AlphabeticalValidator -', () {
    test(
        'should return null if the value contains only alphabetical characters',
        () {
      // Arrange
      final AlphabeticalValidator validator = AlphabeticalValidator();
      const String validValue1 = 'abcdef';
      const String validValue2 = 'XYZ';

      // Act
      final String? result1 = validator.validate(validValue1);
      final String? result2 = validator.validate(validValue2);

      // Assert
      expect(result1, isNull);
      expect(result2, isNull);
    });

    test(
        'should return the default error message if the value contains non-alphabetical characters',
        () {
      // Arrange
      final AlphabeticalValidator validator = AlphabeticalValidator();
      const String invalidValue1 = 'abc123';
      const String invalidValue2 = 'abc!@#';

      // Act
      final String? result1 = validator.validate(invalidValue1);
      final String? result2 = validator.validate(invalidValue2);

      // Assert
      expect(
        result1,
        equals(FormBuilderLocalizations.current.alphabeticalErrorText),
      );
      expect(
        result2,
        equals(FormBuilderLocalizations.current.alphabeticalErrorText),
      );
    });

    test(
        'should return the custom error message if the value contains non-alphabetical characters',
        () {
      // Arrange
      final AlphabeticalValidator validator =
          AlphabeticalValidator(errorText: customErrorMessage);
      const String invalidValue = 'abc123';

      // Act
      final String? result = validator.validate(invalidValue);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      final AlphabeticalValidator validator =
          AlphabeticalValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      final AlphabeticalValidator validator = AlphabeticalValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.alphabeticalErrorText),
      );
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      final AlphabeticalValidator validator =
          AlphabeticalValidator(checkNullOrEmpty: false);
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
      final AlphabeticalValidator validator = AlphabeticalValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.alphabeticalErrorText),
      );
    });

    test('should return null if the value matches the custom regex', () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[a-z]+$'); // Lowercase letters only
      final AlphabeticalValidator validator =
          AlphabeticalValidator(regex: customRegex);
      const String validValue = 'abcdef';

      // Act
      final String? result = validator.validate(validValue);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value does not match the custom regex',
        () {
      // Arrange
      final RegExp customRegex = RegExp(r'^[a-z]+$'); // Lowercase letters only
      final AlphabeticalValidator validator =
          AlphabeticalValidator(regex: customRegex);
      const String invalidValue = 'abcDEF';

      // Act
      final String? result = validator.validate(invalidValue);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.alphabeticalErrorText),
      );
    });
  });
}
