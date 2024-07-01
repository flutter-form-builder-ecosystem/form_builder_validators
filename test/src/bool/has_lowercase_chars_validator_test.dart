import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Has lowercase chars -', () {
    final HasLowercaseCharsValidator validator = HasLowercaseCharsValidator();

    test('should return null when the value has at least 1 lowercase character',
        () {
      // Arrange
      const String value = 'Password123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the value has at least 3 lowercase characters',
        () {
      // Arrange
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(atLeast: 3);
      const String value = 'paSsword123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error message when the value does not have any lowercase characters',
        () {
      // Arrange
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(errorText: customErrorMessage);
      const String value = 'PASSWORD123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message when the value does not have any lowercase characters',
        () {
      // Arrange
      const String value = 'PASSWORD123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.containsLowercaseCharErrorText(1),
        ),
      );
    });

    test('should return null when the value has exactly 1 lowercase character',
        () {
      // Arrange
      const String value = 'Password';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error message when the value does not have enough lowercase characters',
        () {
      // Arrange
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(atLeast: 2, errorText: customErrorMessage);
      const String value = 'PASSWORD';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message when the value does not have enough lowercase characters',
        () {
      // Arrange
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(atLeast: 2);
      const String value = 'PASSWORD';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.containsLowercaseCharErrorText(2),
        ),
      );
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
        FormBuilderLocalizations.current.containsLowercaseCharErrorText(1),
      );
    });

    test('should return null when the value is an empty string', () {
      // Arrange
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value is null', () {
      // Arrange
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error message when using a custom regex and the value does not match',
        () {
      // Arrange
      final HasLowercaseCharsValidator validator = HasLowercaseCharsValidator(
        regex: RegExp('[a-z]'),
        errorText: customErrorMessage,
      );
      const String value = 'PASSWORD';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when using a custom regex and the value matches',
        () {
      // Arrange
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(regex: RegExp('[a-z]'));
      const String value = 'Password';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
