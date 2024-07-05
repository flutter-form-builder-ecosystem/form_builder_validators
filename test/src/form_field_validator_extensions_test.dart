import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Validator extensions -', () {
    test('FormFieldValidatorExtensions.and', () {
      // Arrange
      final FormFieldValidator<String> validator1 =
          FormBuilderValidators.required();
      final FormFieldValidator<String> validator2 =
          FormBuilderValidators.minLength(5);
      final FormFieldValidator<String> combinedValidator =
          validator1.and(validator2);

      // Act & Assert
      // Pass
      expect(combinedValidator('hello'), isNull);

      // Fail
      expect(combinedValidator(null), isNotNull);
      expect(combinedValidator(''), isNotNull);
      expect(combinedValidator('test'), isNotNull);
    });

    test('FormFieldValidatorExtensions.or', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.or(<FormFieldValidator<String>>[
        FormBuilderValidators.endsWith('world'),
        FormBuilderValidators.startsWith('Hello'),
      ]);

      // Act & Assert
      // Pass
      expect(validator('Hello world'), isNull);
      expect(validator('Hello'), isNull);

      // Fail
      expect(validator('123 hello'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
    });

    test('FormFieldValidatorExtensions.when', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.required<String>();
      bool condition(String? value) => value != null && value.isNotEmpty;
      final FormFieldValidator<String> conditionalValidator =
          validator.when(condition);

      // Act & Assert
      // Pass
      expect(conditionalValidator('test'), isNull);

      // Fail
      expect(conditionalValidator(null), isNull);
      expect(conditionalValidator(''), isNull);
    });

    test('FormFieldValidatorExtensions.unless', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.required<String>();
      final FormFieldValidator<String> conditionalValidator = validator
          .unless((String? value) => value != null && value.isNotEmpty);

      // Act & Assert
      // Should skip validation if value is not null and not empty
      String? result = conditionalValidator('test');
      expect(result, isNull);

      // Should apply validation if value is null
      result = conditionalValidator(null);
      expect(result, isNotNull);

      // Should apply validation if value is empty
      result = conditionalValidator('');
      expect(result, isNotNull);

      // Should skip validation if value is not null and not empty
      result = conditionalValidator('non-empty');
      expect(result, isNull);
    });

    test('FormFieldValidatorExtensions.transform', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.transform<String>(
        (String? value) => value?.trim() ?? '',
        FormBuilderValidators.required(),
      );

      // Act & Assert
      // Pass
      expect(validator(' trimmed '), isNull);

      // Fail
      expect(validator('  '), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.transform<String>(
        (String? value) => value?.trim() ?? '',
        FormBuilderValidators.required(errorText: customErrorMessage),
      );

      // Pass
      expect(validatorWithErrorMessage(' trimmed '), isNull);

      // Fail
      expect(validatorWithErrorMessage('  '), customErrorMessage);
    });

    test('FormFieldValidatorExtensions.skipWhen', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.skipWhen<String>(
        (String? value) => value == 'skip',
        FormBuilderValidators.required(),
      );

      // Act & Assert
      // Pass
      expect(validator('skip'), isNull);

      // Fail
      expect(validator(''), isNotNull);
      expect(validator(null), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.skipWhen<String>(
        (String? value) => value == 'skip',
        FormBuilderValidators.required(errorText: customErrorMessage),
      );

      // Pass
      expect(validatorWithErrorMessage('skip'), isNull);

      // Fail
      expect(validatorWithErrorMessage(''), customErrorMessage);
    });

    test('FormFieldValidatorExtensions.log', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.log<String>(
        log: (String? value) => 'Logging: $value',
      );

      // Act & Assert
      // Pass
      expect(validator('test'), isNull);

      // Fail
      expect(validator(null), isNull);
      expect(validator(''), isNull);
    });

    test('FormFieldValidatorExtensions.withMessage', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.required();
      const String errorMessage = 'This field is required';
      final FormFieldValidator<String> validatorWithMessage =
          validator.withErrorMessage(errorMessage);

      // Act & Assert
      // Fail
      expect(validatorWithMessage(null), errorMessage);
      expect(validatorWithMessage(''), errorMessage);

      // Pass
      expect(validatorWithMessage('test'), isNull);
    });
  });
}
