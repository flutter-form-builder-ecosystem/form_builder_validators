import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('EqualValidator -', () {
    test('should return null if the value is equal to the specified value', () {
      // Arrange
      const String testValue = 'test';
      const EqualValidator<String> validator = EqualValidator<String>(
        testValue,
      );
      const String value = 'test';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return error if the value is not equal to the specified value',
      () {
        // Arrange
        const String testValue = 'test';
        final EqualValidator<String> validator = EqualValidator<String>(
          testValue,
          errorText: customErrorMessage,
        );
        const String value = 'different';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );

    test(
      'should return null if the numeric value is equal to the specified value',
      () {
        // Arrange
        const int testValue = 123;
        const EqualValidator<int> validator = EqualValidator<int>(testValue);
        const int value = 123;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return error if the numeric value is not equal to the specified value',
      () {
        // Arrange
        const int testValue = 123;
        final EqualValidator<int> validator = EqualValidator<int>(
          testValue,
          errorText: customErrorMessage,
        );
        const int value = 456;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );

    test(
      'should return error if the value is null and null check is enabled',
      () {
        // Arrange
        const String testValue = 'test';
        final EqualValidator<String> validator = EqualValidator<String>(
          testValue,
          errorText: customErrorMessage,
        );
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );

    test(
      'should return null if the value is null and null check is disabled',
      () {
        // Arrange
        const String testValue = 'test';
        final EqualValidator<String> validator = EqualValidator<String>(
          testValue,
          errorText: customErrorMessage,
          checkNullOrEmpty: false,
        );
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return null if the value is empty and null check is disabled',
      () {
        // Arrange
        const String testValue = 'test';
        final EqualValidator<String> validator = EqualValidator<String>(
          testValue,
          errorText: customErrorMessage,
          checkNullOrEmpty: false,
        );
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return error if the value is empty and null check is enabled',
      () {
        // Arrange
        const String testValue = 'test';
        final EqualValidator<String> validator = EqualValidator<String>(
          testValue,
          errorText: customErrorMessage,
        );
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );

    test(
      'should return custom error message if the value is not equal to the specified value',
      () {
        // Arrange
        const String testValue = 'test';
        final EqualValidator<String> validator = EqualValidator<String>(
          testValue,
          errorText: customErrorMessage,
        );
        const String value = 'different';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );
  });
}
