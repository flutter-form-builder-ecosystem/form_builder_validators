import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Equal length - String', () {
    test('should return null when the value has the exact length', () {
      // Arrange
      const int length = 5;
      const EqualLengthValidator<String> validator =
          EqualLengthValidator<String>(length);
      const String value = 'abcde';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is shorter than the specified length',
        () {
      // Arrange
      const int length = 5;
      const EqualLengthValidator<String> validator =
          EqualLengthValidator<String>(length);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.equalLengthErrorText(length),
        ),
      );
    });

    test(
        'should return the default error message when the value is longer than the specified length',
        () {
      // Arrange
      const int length = 5;
      const EqualLengthValidator<String> validator =
          EqualLengthValidator<String>(length);
      const String value = 'abcdef';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.equalLengthErrorText(length),
        ),
      );
    });

    test(
        'should return the custom error message when the value does not have the exact length',
        () {
      // Arrange
      const int length = 5;
      final EqualLengthValidator<String> validator =
          EqualLengthValidator<String>(length, errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const int length = 5;
      const EqualLengthValidator<String> validator =
          EqualLengthValidator<String>(length, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const int length = 5;
      const EqualLengthValidator<String> validator =
          EqualLengthValidator<String>(length);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.equalLengthErrorText(length),
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const int length = 5;
      const EqualLengthValidator<String> validator =
          EqualLengthValidator<String>(length, checkNullOrEmpty: false);
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
      const int length = 5;
      const EqualLengthValidator<String> validator =
          EqualLengthValidator<String>(length);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.equalLengthErrorText(length),
        ),
      );
    });
  });

  group('Equal length - List', () {
    test('should return null when the list has the exact length', () {
      // Arrange
      const int length = 3;
      const EqualLengthValidator<List<String>> validator =
          EqualLengthValidator<List<String>>(length);
      const List<String> value = ['a', 'b', 'c'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the list is shorter than the specified length',
        () {
      // Arrange
      const int length = 3;
      const EqualLengthValidator<List<String>> validator =
          EqualLengthValidator<List<String>>(length);
      const List<String> value = ['a', 'b'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.equalLengthErrorText(length),
        ),
      );
    });

    test(
        'should return the default error message when the list is longer than the specified length',
        () {
      // Arrange
      const int length = 3;
      const EqualLengthValidator<List<String>> validator =
          EqualLengthValidator<List<String>>(length);
      const List<String> value = ['a', 'b', 'c', 'd'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.equalLengthErrorText(length),
        ),
      );
    });

    test(
        'should return the custom error message when the list does not have the exact length',
        () {
      // Arrange
      const int length = 3;
      final EqualLengthValidator<List<String>> validator =
          EqualLengthValidator<List<String>>(
        length,
        errorText: customErrorMessage,
      );
      const List<String> value = ['a', 'b'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the list is null and null check is disabled',
        () {
      // Arrange
      const int length = 3;
      const EqualLengthValidator<List<String>> validator =
          EqualLengthValidator<List<String>>(length, checkNullOrEmpty: false);
      const List<String>? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the list is null', () {
      // Arrange
      const int length = 3;
      const EqualLengthValidator<List<String>> validator =
          EqualLengthValidator<List<String>>(length);
      const List<String>? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.equalLengthErrorText(length),
        ),
      );
    });

    test('should return null when the list is empty and null check is disabled',
        () {
      // Arrange
      const int length = 3;
      const EqualLengthValidator<List<String>> validator =
          EqualLengthValidator<List<String>>(length, checkNullOrEmpty: false);
      const List<String> value = [];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the list is empty', () {
      // Arrange
      const int length = 3;
      const EqualLengthValidator<List<String>> validator =
          EqualLengthValidator<List<String>>(length);
      const List<String> value = [];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.equalLengthErrorText(length),
        ),
      );
    });
  });
}
