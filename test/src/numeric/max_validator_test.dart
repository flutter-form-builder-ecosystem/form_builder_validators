import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MaxValidator -', () {
    group('String', () {
      test('should return null if the value is less than the max', () {
        // Arrange
        const num max = 10;
        const MaxValidator<String> validator = MaxValidator<String>(max);
        const String value = '5';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return null if the value is equal to the max and inclusive',
          () {
        // Arrange
        const num max = 10;
        const MaxValidator<String> validator = MaxValidator<String>(max);
        const String value = '10';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test(
          'should return error if the value is equal to the max and not inclusive',
          () {
        // Arrange
        const num max = 10;
        const MaxValidator<String> validator =
            MaxValidator<String>(max, inclusive: false);
        const String value = '10';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.maxErrorText(max),
          ),
        );
      });

      test('should return error if the value is greater than the max', () {
        // Arrange
        const num max = 10;
        const MaxValidator<String> validator = MaxValidator<String>(max);
        const String value = '15';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.maxErrorText(max),
          ),
        );
      });

      test(
          'should return custom error message if the value is greater than the max',
          () {
        // Arrange
        const num max = 10;
        final MaxValidator<String> validator =
            MaxValidator<String>(max, errorText: customErrorMessage);
        const String value = '15';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    group('num', () {
      test('should return null if the value is less than the max', () {
        // Arrange
        const num max = 10;
        const MaxValidator<num> validator = MaxValidator<num>(max);
        const num value = 5;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test('should return null if the value is equal to the max and inclusive',
          () {
        // Arrange
        const num max = 10;
        const MaxValidator<num> validator = MaxValidator<num>(max);
        const num value = 10;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      });

      test(
          'should return error if the value is equal to the max and not inclusive',
          () {
        // Arrange
        const num max = 10;
        const MaxValidator<num> validator =
            MaxValidator<num>(max, inclusive: false);
        const num value = 10;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.maxErrorText(max),
          ),
        );
      });

      test('should return error if the value is greater than the max', () {
        // Arrange
        const num max = 10;
        const MaxValidator<num> validator = MaxValidator<num>(max);
        const num value = 15;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.maxErrorText(max),
          ),
        );
      });

      test(
          'should return custom error message if the value is greater than the max',
          () {
        // Arrange
        const num max = 10;
        final MaxValidator<num> validator =
            MaxValidator<num>(max, errorText: customErrorMessage);
        const num value = 15;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const num max = 10;
      const MaxValidator<String> validator =
          MaxValidator<String>(max, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const num max = 10;
      const MaxValidator<String> validator = MaxValidator<String>(max);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxErrorText(max),
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const num max = 10;
      const MaxValidator<String> validator =
          MaxValidator<String>(max, checkNullOrEmpty: false);
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
      const num max = 10;
      const MaxValidator<String> validator = MaxValidator<String>(max);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxErrorText(max),
        ),
      );
    });
  });
}
