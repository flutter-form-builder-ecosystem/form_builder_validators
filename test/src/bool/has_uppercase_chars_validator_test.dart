import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Has uppercase chars -', () {
    final HasUppercaseCharsValidator validator = HasUppercaseCharsValidator();

    test('should return null when the value has at least 1 uppercase character',
        () {
      // Arrange
      const String value = 'abcA';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the value has at least 3 uppercase characters',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(atLeast: 3);
      const String value = 'aAbBcC';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error message when the value has no uppercase characters',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the custom error message when the value has less than 3 uppercase characters',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(atLeast: 3, errorText: customErrorMessage);
      const String value = 'aA';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value has exactly 1 uppercase character',
        () {
      // Arrange
      const String value = 'Password';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error message when the value does not have enough uppercase characters',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(atLeast: 2, errorText: customErrorMessage);
      const String value = 'aA';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message when the value is an empty string',
        () {
      // Arrange
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        FormBuilderLocalizations.current.containsUppercaseCharErrorText(1),
      );
    });

    test('should return null when the value is an empty string', () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value is null', () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(errorText: customErrorMessage);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return an error message when using a custom regex and the value does not match',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(regex: RegExp('[A-G]'));
      const String value = 'HIJKLMNOP';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
    });

    test(
        'should return the custom error message when the value has no uppercase characters and a custom regex is used',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator = HasUppercaseCharsValidator(
        regex: RegExp('[d-z]'),
        errorText: customErrorMessage,
      );
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when using a custom regex and the value matches',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(regex: RegExp('[A-G]'));
      const String value = 'ABC';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
