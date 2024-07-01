import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Unique - String', () {
    test(
        'should return null when the value appears exactly once in the list (unique)',
        () {
      // Arrange
      const List<String> values = <String>['a', 'b', 'c'];
      const UniqueValidator<String> validator = UniqueValidator<String>(values);
      const String value = 'a';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value does not appear exactly once in the list',
        () {
      // Arrange
      const List<String> values = <String>['a', 'a', 'b', 'c'];
      const UniqueValidator<String> validator = UniqueValidator<String>(values);
      const String value = 'a';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.uniqueErrorText));
    });

    test(
        'should return the custom error message when the value does not appear exactly once in the list',
        () {
      // Arrange
      const List<String> values = <String>['a', 'a', 'b', 'c'];
      final UniqueValidator<String> validator =
          UniqueValidator<String>(values, errorText: customErrorMessage);
      const String value = 'a';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const List<String> values = <String>['a', 'b', 'c'];
      const UniqueValidator<String> validator =
          UniqueValidator<String>(values, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const List<String> values = <String>['a', 'b', 'c'];
      const UniqueValidator<String> validator = UniqueValidator<String>(values);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.uniqueErrorText));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const List<String> values = <String>['a', 'b', 'c'];
      const UniqueValidator<String> validator =
          UniqueValidator<String>(values, checkNullOrEmpty: false);
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
      const List<String> values = <String>['a', 'b', 'c'];
      const UniqueValidator<String> validator = UniqueValidator<String>(values);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.uniqueErrorText));
    });

    test(
        'should return null when the value is unique in a list with duplicates',
        () {
      // Arrange
      const List<String> values = <String>['a', 'a', 'b', 'c'];
      const UniqueValidator<String> validator = UniqueValidator<String>(values);
      const String value = 'b';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is not unique in a list with duplicates',
        () {
      // Arrange
      const List<String> values = <String>['a', 'a', 'b', 'c'];
      const UniqueValidator<String> validator = UniqueValidator<String>(values);
      const String value = 'a';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.uniqueErrorText));
    });
  });

  group('Unique - int', () {
    test(
        'should return null when the value appears exactly once in the list (unique)',
        () {
      // Arrange
      const List<int> values = <int>[1, 2, 3];
      const UniqueValidator<int> validator = UniqueValidator<int>(values);
      const int value = 1;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value does not appear exactly once in the list',
        () {
      // Arrange
      const List<int> values = <int>[1, 1, 2, 3];
      const UniqueValidator<int> validator = UniqueValidator<int>(values);
      const int value = 1;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.uniqueErrorText));
    });

    test(
        'should return the custom error message when the value does not appear exactly once in the list',
        () {
      // Arrange
      const List<int> values = <int>[1, 1, 2, 3];
      final UniqueValidator<int> validator =
          UniqueValidator<int>(values, errorText: customErrorMessage);
      const int value = 1;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const List<int> values = <int>[1, 2, 3];
      const UniqueValidator<int> validator =
          UniqueValidator<int>(values, checkNullOrEmpty: false);
      const int? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const List<int> values = <int>[1, 2, 3];
      const UniqueValidator<int> validator = UniqueValidator<int>(values);
      const int? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.uniqueErrorText));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const List<int> values = <int>[1, 2, 3];
      const UniqueValidator<int> validator =
          UniqueValidator<int>(values, checkNullOrEmpty: false);
      const int? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is zero', () {
      // Arrange
      const List<int> values = <int>[1, 2, 3];
      const UniqueValidator<int> validator = UniqueValidator<int>(values);
      const int value = 0;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.uniqueErrorText));
    });

    test(
        'should return null when the value is unique in a list with duplicates',
        () {
      // Arrange
      const List<int> values = <int>[1, 1, 2, 3];
      const UniqueValidator<int> validator = UniqueValidator<int>(values);
      const int value = 2;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is not unique in a list with duplicates',
        () {
      // Arrange
      const List<int> values = <int>[1, 1, 2, 3];
      const UniqueValidator<int> validator = UniqueValidator<int>(values);
      const int value = 1;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(FormBuilderLocalizations.current.uniqueErrorText));
    });
  });
}
