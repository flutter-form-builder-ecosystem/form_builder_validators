import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('OddNumberValidator -', () {
    test('should return null if the value is a valid odd number string', () {
      // Arrange
      const OddNumberValidator validator = OddNumberValidator();
      const String value = '3';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is a valid even number string',
        () {
      // Arrange
      const OddNumberValidator validator = OddNumberValidator();
      const String value = '4';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.oddNumberErrorText,
        ),
      );
    });

    test(
        'should return the custom error message if the value is a valid even number string',
        () {
      // Arrange
      final OddNumberValidator validator =
          OddNumberValidator(errorText: customErrorMessage);
      const String value = '4';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message if the value is not a number string',
        () {
      // Arrange
      const OddNumberValidator validator = OddNumberValidator();
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.oddNumberErrorText,
        ),
      );
    });

    test(
        'should return the custom error message if the value is not a number string',
        () {
      // Arrange
      final OddNumberValidator validator =
          OddNumberValidator(errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const OddNumberValidator validator =
          OddNumberValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const OddNumberValidator validator = OddNumberValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.oddNumberErrorText,
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const OddNumberValidator validator =
          OddNumberValidator(checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is an empty string',
        () {
      // Arrange
      const OddNumberValidator validator = OddNumberValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.oddNumberErrorText,
        ),
      );
    });
  });
}
