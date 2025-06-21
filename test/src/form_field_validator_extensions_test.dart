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
      final FormFieldValidator<String> combinedValidator = validator1.and(
        validator2,
      );

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
      final FormFieldValidator<String> conditionalValidator = validator.when(
        condition,
      );

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
      final FormFieldValidator<String> conditionalValidator = validator.unless(
        (String? value) => value != null && value.isNotEmpty,
      );

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

    test(
      'FormFieldValidatorExtensions.transform with custom transformation',
      () {
        // Arrange
        final FormFieldValidator<String> validator =
            FormBuilderValidators.transform<String>(
              (String? value) => value?.toUpperCase() ?? '',
              FormBuilderValidators.match(RegExp(r'^[A-Z]+$')),
            );

        // Act & Assert
        // Pass
        expect(validator('abc'), isNull);
        expect(validator('ABC'), isNull);

        // Fail
        expect(validator('abc123'), isNotNull);
        expect(validator(null), isNotNull);
        expect(validator(''), isNotNull);
      },
    );

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
      String? logMessage;
      final FormFieldValidator<String> validator =
          FormBuilderValidators.log<String>(
            log: (String? value) => logMessage = 'Logging: $value',
          );

      // Act
      validator('test');

      // Assert
      expect(logMessage, 'Logging: test');

      // Act
      logMessage = null;
      validator(null);

      // Assert
      expect(logMessage, 'Logging: null');

      // Act
      logMessage = null;
      validator('');

      // Assert
      expect(logMessage, 'Logging: ');
    });

    test('FormFieldValidatorExtensions.withMessage', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.required();
      const String errorMessage = 'This field is required';
      final FormFieldValidator<String> validatorWithMessage = validator
          .withErrorMessage(errorMessage);

      // Act & Assert
      // Fail
      expect(validatorWithMessage(null), errorMessage);
      expect(validatorWithMessage(''), errorMessage);

      // Pass
      expect(validatorWithMessage('test'), isNull);
    });

    test('FormFieldValidatorExtensions.and with nested validators', () {
      // Arrange
      final FormFieldValidator<String> validator1 =
          FormBuilderValidators.required();
      final FormFieldValidator<String> validator2 =
          FormBuilderValidators.minLength(5);
      final FormFieldValidator<String> validator3 =
          FormBuilderValidators.maxLength(10);
      final FormFieldValidator<String> combinedValidator = validator1.and(
        validator2.and(validator3),
      );

      // Act & Assert
      // Pass
      expect(combinedValidator('hello'), isNull);
      expect(combinedValidator('hello123'), isNull);

      // Fail
      expect(combinedValidator(null), isNotNull);
      expect(combinedValidator(''), isNotNull);
      expect(combinedValidator('test'), isNotNull);
      expect(combinedValidator('hello world'), isNotNull);
    });

    test('FormFieldValidatorExtensions.or with nested validators', () {
      // Arrange
      final FormFieldValidator<String> validator1 =
          FormBuilderValidators.endsWith('world');
      final FormFieldValidator<String> validator2 =
          FormBuilderValidators.startsWith('Hello');
      final FormFieldValidator<String> validator3 = FormBuilderValidators.equal(
        'test',
      );
      final FormFieldValidator<String> combinedValidator = validator1.or(
        validator2.or(validator3),
      );

      // Act & Assert
      // Pass
      expect(combinedValidator('Hello world'), isNull);
      expect(combinedValidator('Hello'), isNull);
      expect(combinedValidator('test'), isNull);

      // Fail
      expect(combinedValidator('123 hello'), isNotNull);
      expect(combinedValidator(null), isNotNull);
      expect(combinedValidator(''), isNotNull);
    });

    test(
      'FormFieldValidatorExtensions.transform with custom transformation',
      () {
        // Arrange
        final FormFieldValidator<String> validator =
            FormBuilderValidators.transform<String>(
              (String? value) => value?.toUpperCase() ?? '',
              FormBuilderValidators.match(RegExp(r'^[A-Z]+$')),
            );

        // Act & Assert
        // Pass
        expect(validator('abc'), isNull);
        expect(validator('ABC'), isNull);

        // Fail
        expect(validator('abc123'), isNotNull);
        expect(validator(null), isNotNull);
        expect(validator(''), isNotNull);
      },
    );

    test('FormFieldValidatorExtensions.when with custom condition', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.required<String>();
      final FormFieldValidator<String> conditionalValidator = validator.when(
        (String? value) => value != 'skip',
      );

      // Act & Assert
      // Pass
      expect(conditionalValidator('test'), isNull);

      // Fail
      expect(conditionalValidator('skip'), isNull);
      expect(conditionalValidator(null), isNotNull);
      expect(conditionalValidator(''), isNotNull);
    });

    test('FormFieldValidatorExtensions.unless with custom condition', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.required<String>();
      final FormFieldValidator<String> conditionalValidator = validator.unless(
        (String? value) => value == 'skip',
      );

      // Act & Assert
      // Pass
      expect(conditionalValidator('skip'), isNull);

      // Fail
      expect(conditionalValidator('test'), isNull);
      expect(conditionalValidator(null), isNotNull);
      expect(conditionalValidator(''), isNotNull);
    });

    test('FormFieldValidatorExtensions.skipWhen with custom condition', () {
      // Arrange
      final FormFieldValidator<String> validator =
          FormBuilderValidators.skipWhen<String>(
            (String? value) => value == 'SKIP',
            FormBuilderValidators.required(errorText: customErrorMessage),
          );

      // Act & Assert
      // Pass
      expect(validator('SKIP'), isNull);

      // Fail
      expect(validator(''), customErrorMessage);
      expect(validator(null), customErrorMessage);
    });

    test('FormFieldValidatorExtensions.log with custom logger', () {
      // Arrange
      String? logMessage;
      final FormFieldValidator<String> validator =
          FormBuilderValidators.log<String>(
            log: (String? value) {
              logMessage = 'Custom Log: $value';
              return '';
            },
          );

      // Act
      validator('test');

      // Assert
      expect(logMessage, 'Custom Log: test');

      // Act
      logMessage = null;
      validator(null);

      // Assert
      expect(logMessage, 'Custom Log: null');

      // Act
      logMessage = null;
      validator('');

      // Assert
      expect(logMessage, 'Custom Log: ');
    });

    test(
      'FormFieldValidatorExtensions.transform with trimming and uppercasing',
      () {
        // Arrange
        final FormFieldValidator<String> validator =
            FormBuilderValidators.transform<String>(
              (String? value) => value?.trim().toUpperCase() ?? '',
              FormBuilderValidators.match(RegExp(r'^[A-Z]+$')),
            );

        // Act & Assert
        // Pass
        expect(validator(' abc '), isNull);
        expect(validator(' ABC '), isNull);

        // Fail
        expect(validator(' abc123 '), isNotNull);
        expect(validator(null), isNotNull);
        expect(validator(' '), isNotNull);
      },
    );

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

    test('FormFieldValidatorExtensions.skipWhen with custom condition', () {
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

    test('FormFieldValidatorExtensions.log with custom logger', () {
      // Arrange
      String? logMessage;
      final FormFieldValidator<String> validator =
          FormBuilderValidators.log<String>(
            log: (String? value) {
              logMessage = 'Custom Log: $value';
              return '';
            },
          );

      // Act
      validator('test');

      // Assert
      expect(logMessage, 'Custom Log: test');

      // Act
      logMessage = null;
      validator(null);

      // Assert
      expect(logMessage, 'Custom Log: null');

      // Act
      logMessage = null;
      validator('');

      // Assert
      expect(logMessage, 'Custom Log: ');
    });
  });
}
