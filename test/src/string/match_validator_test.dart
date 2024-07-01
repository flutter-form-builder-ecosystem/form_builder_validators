import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MatchValidator -', () {
    test('should return null if the value matches the regex', () {
      // Arrange
      final MatchValidator validator = MatchValidator(RegExp(r'^[a-zA-Z]+$'));
      const String value = 'abcdef';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value does not match the regex',
        () {
      // Arrange
      final MatchValidator validator = MatchValidator(RegExp(r'^[a-zA-Z]+$'));
      const String value = '12345';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.matchErrorText));
    });

    test(
        'should return the custom error message if the value does not match the regex',
        () {
      // Arrange
      final MatchValidator validator = MatchValidator(
        RegExp(r'^[a-zA-Z]+$'),
        errorText: customErrorMessage,
      );
      const String value = '12345';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      final MatchValidator validator = MatchValidator(
        RegExp(r'^[a-zA-Z]+$'),
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      final MatchValidator validator = MatchValidator(RegExp(r'^[a-zA-Z]+$'));
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.matchErrorText));
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      final MatchValidator validator = MatchValidator(
        RegExp(r'^[a-zA-Z]+$'),
        checkNullOrEmpty: false,
      );
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
      final MatchValidator validator = MatchValidator(RegExp(r'^[a-zA-Z]+$'));
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.matchErrorText));
    });
  });
}
