import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('SkipWhenValidator -', () {
    test('should return null if the condition is met', () {
      // Arrange
      final SkipWhenValidator<String> validator = SkipWhenValidator<String>(
        (String? value) => value == 'skip',
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = 'skip';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return error if the condition is not met and the value is invalid',
      () {
        // Arrange
        final SkipWhenValidator<String> validator = SkipWhenValidator<String>(
          (String? value) => value == 'validate',
          FormBuilderValidators.required(errorText: customErrorMessage),
        );
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );

    test(
      'should return null if the condition is not met and the value is valid',
      () {
        // Arrange
        final SkipWhenValidator<String> validator = SkipWhenValidator<String>(
          (String? value) => value != 'validate',
          FormBuilderValidators.required(errorText: customErrorMessage),
        );
        const String value = 'validate';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return error if the condition is not met for non-string type and the value is invalid',
      () {
        // Arrange
        final SkipWhenValidator<int> validator = SkipWhenValidator<int>(
          (int? value) => value == 0,
          (int? value) =>
              value != null && value > 0 ? null : customErrorMessage,
        );
        const int value = -1;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );

    test('should return null if the condition is met for non-string type', () {
      // Arrange
      final SkipWhenValidator<int> validator = SkipWhenValidator<int>(
        (int? value) => value == 0,
        (int? value) => value != null && value > 0 ? null : customErrorMessage,
      );
      const int value = 0;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return null if the value is null and condition is not met',
      () {
        // Arrange
        final SkipWhenValidator<String?> validator = SkipWhenValidator<String?>(
          (String? value) => value == 'skip',
          FormBuilderValidators.required(errorText: customErrorMessage),
        );
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );

    test(
      'should return error if the condition is not met and validator returns error',
      () {
        // Arrange
        final SkipWhenValidator<String> validator = SkipWhenValidator<String>(
          (String? value) => value == 'skip',
          FormBuilderValidators.required(errorText: customErrorMessage),
        );
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, customErrorMessage);
      },
    );
  });
}
