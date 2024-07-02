import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('NotEqualValidator -', () {
    test('should return null if the value is not equal to the specified value',
        () {
      // Arrange
      const NotEqualValidator<String> validator =
          NotEqualValidator<String>('test');
      const String value = 'example';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return errorText if the value is equal to the specified value',
        () {
      // Arrange
      final NotEqualValidator<String> validator = NotEqualValidator<String>(
        'test',
        errorText: customErrorMessage,
      );
      const String value = 'test';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const NotEqualValidator<String> validator = NotEqualValidator<String>(
        'test',
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return errorText if the value is null and null check is enabled',
        () {
      // Arrange
      final NotEqualValidator<String> validator = NotEqualValidator<String>(
        'test',
        errorText: customErrorMessage,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return null if the integer value is not equal to the specified value',
        () {
      // Arrange
      const NotEqualValidator<int> validator = NotEqualValidator<int>(5);
      const int value = 10;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return errorText if the integer value is equal to the specified value',
        () {
      // Arrange
      final NotEqualValidator<int> validator = NotEqualValidator<int>(
        5,
        errorText: customErrorMessage,
      );
      const int value = 5;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return null if the double value is not equal to the specified value',
        () {
      // Arrange
      const NotEqualValidator<double> validator =
          NotEqualValidator<double>(5.5);
      const double value = 10;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return errorText if the double value is equal to the specified value',
        () {
      // Arrange
      final NotEqualValidator<double> validator = NotEqualValidator<double>(
        5.5,
        errorText: customErrorMessage,
      );
      const double value = 5.5;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
        'should return null if the list value is not equal to the specified value',
        () {
      // Arrange
      const NotEqualValidator<List<String>> validator =
          NotEqualValidator<List<String>>(<String>['a', 'b']);
      const List<String> value = <String>['a', 'b', 'c'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return errorText if the list value is equal to the specified value',
        () {
      // Arrange
      const List<String> value = <String>['a', 'b'];
      final NotEqualValidator<List<String>> validator =
          NotEqualValidator<List<String>>(
        value,
        errorText: customErrorMessage,
      );

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });
  });
}
