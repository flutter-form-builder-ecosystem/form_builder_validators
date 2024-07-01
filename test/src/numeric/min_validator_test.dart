import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MinValidator -', () {
    group('String', () {
      test('should return null if the value is greater than the min', () {
        // Arrange
        const num min = 10;
        const MinValidator<String> validator = MinValidator<String>(min);
        const String value = '15';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return null if the value is equal to the min and inclusive',
          () {
        // Arrange
        const num min = 10;
        const MinValidator<String> validator = MinValidator<String>(min);
        const String value = '10';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test(
          'should return error if the value is equal to the min and not inclusive',
          () {
        // Arrange
        const num min = 10;
        const MinValidator<String> validator =
            MinValidator<String>(min, inclusive: false);
        const String value = '10';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.minErrorText(min),
          ),
        );
      });

      test('should return error if the value is less than the min', () {
        // Arrange
        const num min = 10;
        const MinValidator<String> validator = MinValidator<String>(min);
        const String value = '5';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.minErrorText(min),
          ),
        );
      });

      test(
          'should return custom error message if the value is less than the min',
          () {
        // Arrange
        const num min = 10;
        final MinValidator<String> validator =
            MinValidator<String>(min, errorText: customErrorMessage);
        const String value = '5';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    group('num', () {
      test('should return null if the value is greater than the min', () {
        // Arrange
        const num min = 10;
        const MinValidator<num> validator = MinValidator<num>(min);
        const num value = 15;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return null if the value is equal to the min and inclusive',
          () {
        // Arrange
        const num min = 10;
        const MinValidator<num> validator = MinValidator<num>(min);
        const num value = 10;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test(
          'should return error if the value is equal to the min and not inclusive',
          () {
        // Arrange
        const num min = 10;
        const MinValidator<num> validator =
            MinValidator<num>(min, inclusive: false);
        const num value = 10;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.minErrorText(min),
          ),
        );
      });

      test('should return error if the value is less than the min', () {
        // Arrange
        const num min = 10;
        const MinValidator<num> validator = MinValidator<num>(min);
        const num value = 5;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.minErrorText(min),
          ),
        );
      });

      test(
          'should return custom error message if the value is less than the min',
          () {
        // Arrange
        const num min = 10;
        final MinValidator<num> validator =
            MinValidator<num>(min, errorText: customErrorMessage);
        const num value = 5;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const num min = 10;
      const MinValidator<String> validator =
          MinValidator<String>(min, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const num min = 10;
      const MinValidator<String> validator = MinValidator<String>(min);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.minErrorText(min),
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const num min = 10;
      const MinValidator<String> validator =
          MinValidator<String>(min, checkNullOrEmpty: false);
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
      const num min = 10;
      const MinValidator<String> validator = MinValidator<String>(min);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.minErrorText(min),
        ),
      );
    });
  });
}
