import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MaxLengthValidator - String', () {
    test('should return null when the value has the exact maximum length', () {
      // Arrange
      const int maxLength = 5;
      const MaxLengthValidator<String> validator =
          MaxLengthValidator<String>(maxLength);
      const String value = 'abcde';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value is shorter than the maximum length',
        () {
      // Arrange
      const int maxLength = 5;
      const MaxLengthValidator<String> validator =
          MaxLengthValidator<String>(maxLength);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is longer than the maximum length',
        () {
      // Arrange
      const int maxLength = 5;
      const MaxLengthValidator<String> validator =
          MaxLengthValidator<String>(maxLength);
      const String value = 'abcdef';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxLengthErrorText(maxLength),
        ),
      );
    });

    test(
        'should return the custom error message when the value is longer than the maximum length',
        () {
      // Arrange
      const int maxLength = 5;
      final MaxLengthValidator<String> validator =
          MaxLengthValidator<String>(maxLength, errorText: customErrorMessage);
      const String value = 'abcdef';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const int maxLength = 5;
      const MaxLengthValidator<String> validator =
          MaxLengthValidator<String>(maxLength, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const int maxLength = 5;
      const MaxLengthValidator<String> validator =
          MaxLengthValidator<String>(maxLength);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxLengthErrorText(maxLength),
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const int maxLength = 5;
      const MaxLengthValidator<String> validator =
          MaxLengthValidator<String>(maxLength, checkNullOrEmpty: false);
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
      const int maxLength = 5;
      const MaxLengthValidator<String> validator =
          MaxLengthValidator<String>(maxLength);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxLengthErrorText(maxLength),
        ),
      );
    });
  });

  group('MaxLengthValidator - List', () {
    test('should return null when the list has the exact maximum length', () {
      // Arrange
      const int maxLength = 3;
      const MaxLengthValidator<List<String>> validator =
          MaxLengthValidator<List<String>>(maxLength);
      const List<String> value = <String>['a', 'b', 'c'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the list is shorter than the maximum length',
        () {
      // Arrange
      const int maxLength = 3;
      const MaxLengthValidator<List<String>> validator =
          MaxLengthValidator<List<String>>(maxLength);
      const List<String> value = <String>['a', 'b'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the list is longer than the maximum length',
        () {
      // Arrange
      const int maxLength = 3;
      const MaxLengthValidator<List<String>> validator =
          MaxLengthValidator<List<String>>(maxLength);
      const List<String> value = <String>['a', 'b', 'c', 'd'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxLengthErrorText(maxLength),
        ),
      );
    });

    test(
        'should return the custom error message when the list is longer than the maximum length',
        () {
      // Arrange
      const int maxLength = 3;
      final MaxLengthValidator<List<String>> validator =
          MaxLengthValidator<List<String>>(
        maxLength,
        errorText: customErrorMessage,
      );
      const List<String> value = <String>['a', 'b', 'c', 'd'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the list is null and null check is disabled',
        () {
      // Arrange
      const int maxLength = 3;
      const MaxLengthValidator<List<String>> validator =
          MaxLengthValidator<List<String>>(maxLength, checkNullOrEmpty: false);
      const List<String>? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the list is null', () {
      // Arrange
      const int maxLength = 3;
      const MaxLengthValidator<List<String>> validator =
          MaxLengthValidator<List<String>>(maxLength);
      const List<String>? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxLengthErrorText(maxLength),
        ),
      );
    });

    test('should return null when the list is empty and null check is disabled',
        () {
      // Arrange
      const int maxLength = 3;
      const MaxLengthValidator<List<String>> validator =
          MaxLengthValidator<List<String>>(maxLength, checkNullOrEmpty: false);
      const List<String> value = <String>[];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the list is empty', () {
      // Arrange
      const int maxLength = 3;
      const MaxLengthValidator<List<String>> validator =
          MaxLengthValidator<List<String>>(maxLength);
      const List<String> value = <String>[];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxLengthErrorText(maxLength),
        ),
      );
    });
  });
}
