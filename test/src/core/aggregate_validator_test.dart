import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage1 = faker.lorem.sentence();
  final String customErrorMessage2 = faker.lorem.sentence();

  group('AggregateValidator -', () {
    test('should return null if all validators pass', () {
      // Arrange
      final AggregateValidator<String> validator =
          AggregateValidator<String>(<FormFieldValidator<String>>[
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(3),
      ]);
      const String validValue = 'abc';

      // Act
      final String? result = validator.validate(validValue);

      // Assert
      expect(result, isNull);
    });

    test('should return single error message if one validator fails', () {
      // Arrange
      final AggregateValidator<String> validator =
          AggregateValidator<String>(<FormFieldValidator<String>>[
        FormBuilderValidators.required(errorText: customErrorMessage1),
        FormBuilderValidators.minLength(5, errorText: customErrorMessage2),
      ]);
      const String invalidValue = 'abc';

      // Act
      final String? result = validator.validate(invalidValue);

      // Assert
      expect(result, customErrorMessage2);
    });

    test('should return multiple error messages if multiple validators fail',
        () {
      // Arrange
      final AggregateValidator<String> validator =
          AggregateValidator<String>(<FormFieldValidator<String>>[
        FormBuilderValidators.required(errorText: customErrorMessage1),
        FormBuilderValidators.minLength(5, errorText: customErrorMessage2),
      ]);
      const String invalidValue = '';

      // Act
      final String? result = validator.validate(invalidValue);

      // Assert
      expect(result, '$customErrorMessage1\n$customErrorMessage2');
    });

    test('should return custom error message from validator if value is null',
        () {
      // Arrange
      final AggregateValidator<String> validator =
          AggregateValidator<String>(<FormFieldValidator<String>>[
        FormBuilderValidators.required(errorText: customErrorMessage1),
      ]);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage1);
    });

    test('should return null if value is null and null check is disabled', () {
      // Arrange
      final AggregateValidator<String> validator =
          AggregateValidator<String>(<FormFieldValidator<String>>[
        FormBuilderValidators.required(
          errorText: customErrorMessage1,
          checkNullOrEmpty: false,
        ),
      ]);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return custom error message from validator if value is empty',
        () {
      // Arrange
      final AggregateValidator<String> validator =
          AggregateValidator<String>(<FormFieldValidator<String>>[
        FormBuilderValidators.required(errorText: customErrorMessage1),
      ]);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage1);
    });

    test('should return null if value is empty and null check is disabled', () {
      // Arrange
      final AggregateValidator<String> validator =
          AggregateValidator<String>(<FormFieldValidator<String>>[
        FormBuilderValidators.required(
          errorText: customErrorMessage1,
          checkNullOrEmpty: false,
        ),
      ]);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
