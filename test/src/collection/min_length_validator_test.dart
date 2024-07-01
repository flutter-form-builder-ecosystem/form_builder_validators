import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Min length - String', () {
    test('should return null when the value has the exact minimum length', () {
      // Arrange
      const int minLength = 5;
      const MinLengthValidator<String> validator =
          MinLengthValidator<String>(minLength);
      const String value = 'abcde';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value is longer than the minimum length',
        () {
      // Arrange
      const int minLength = 5;
      const MinLengthValidator<String> validator =
          MinLengthValidator<String>(minLength);
      const String value = 'abcdef';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is shorter than the minimum length',
        () {
      // Arrange
      const int minLength = 5;
      const MinLengthValidator<String> validator =
          MinLengthValidator<String>(minLength);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.minLengthErrorText(minLength),
        ),
      );
    });

    test(
        'should return the custom error message when the value is shorter than the minimum length',
        () {
      // Arrange
      const int minLength = 5;
      final MinLengthValidator<String> validator =
          MinLengthValidator<String>(minLength, errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const int minLength = 5;
      const MinLengthValidator<String> validator =
          MinLengthValidator<String>(minLength, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const int minLength = 5;
      const MinLengthValidator<String> validator =
          MinLengthValidator<String>(minLength);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.minLengthErrorText(minLength),
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const int minLength = 5;
      const MinLengthValidator<String> validator =
          MinLengthValidator<String>(minLength, checkNullOrEmpty: false);
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
      const int minLength = 5;
      const MinLengthValidator<String> validator =
          MinLengthValidator<String>(minLength);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.minLengthErrorText(minLength),
        ),
      );
    });
  });

  group('Min length - List', () {
    test('should return null when the list has the exact minimum length', () {
      // Arrange
      const int minLength = 3;
      const MinLengthValidator<List<String>> validator =
          MinLengthValidator<List<String>>(minLength);
      const List<String> value = <String>['a', 'b', 'c'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the list is longer than the minimum length',
        () {
      // Arrange
      const int minLength = 3;
      const MinLengthValidator<List<String>> validator =
          MinLengthValidator<List<String>>(minLength);
      const List<String> value = <String>['a', 'b', 'c', 'd'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the list is shorter than the minimum length',
        () {
      // Arrange
      const int minLength = 3;
      const MinLengthValidator<List<String>> validator =
          MinLengthValidator<List<String>>(minLength);
      const List<String> value = <String>['a', 'b'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.minLengthErrorText(minLength),
        ),
      );
    });

    test(
        'should return the custom error message when the list is shorter than the minimum length',
        () {
      // Arrange
      const int minLength = 3;
      final MinLengthValidator<List<String>> validator =
          MinLengthValidator<List<String>>(
        minLength,
        errorText: customErrorMessage,
      );
      const List<String> value = <String>['a', 'b'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the list is null and null check is disabled',
        () {
      // Arrange
      const int minLength = 3;
      const MinLengthValidator<List<String>> validator =
          MinLengthValidator<List<String>>(minLength, checkNullOrEmpty: false);
      const List<String>? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the list is null', () {
      // Arrange
      const int minLength = 3;
      const MinLengthValidator<List<String>> validator =
          MinLengthValidator<List<String>>(minLength);
      const List<String>? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.minLengthErrorText(minLength),
        ),
      );
    });

    test('should return null when the list is empty and null check is disabled',
        () {
      // Arrange
      const int minLength = 3;
      const MinLengthValidator<List<String>> validator =
          MinLengthValidator<List<String>>(minLength, checkNullOrEmpty: false);
      const List<String> value = <String>[];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the list is empty', () {
      // Arrange
      const int minLength = 3;
      const MinLengthValidator<List<String>> validator =
          MinLengthValidator<List<String>>(minLength);
      const List<String> value = <String>[];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.minLengthErrorText(minLength),
        ),
      );
    });
  });
}
