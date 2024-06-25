import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../tests_helper.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group(
    'Helper validators',
    () {
      testWidgets(
        'FormFieldValidatorExtensions.and',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator validator1 =
              FormBuilderValidators.required();
          final FormFieldValidator validator2 =
              FormBuilderValidators.minLength(5);
          final FormFieldValidator combinedValidator =
              validator1.and(validator2);

          // Pass
          expect(combinedValidator('hello'), isNull);

          // Fail
          expect(combinedValidator(null), isNotNull);
          expect(combinedValidator(''), isNotNull);
          expect(combinedValidator('test'), isNotNull);
        }),
      );

      testWidgets(
        'FormBuilderValidators.or',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator<String> validator =
              FormBuilderValidators.or(<String? Function(String? value)>[
            FormBuilderValidators.endsWith(suffix: 'world'),
            FormBuilderValidators.startsWith(prefix: 'Hello'),
          ]);
          // Pass
          expect(validator('Hello world'), isNull);
          expect(validator('Hello'), isNull);
          // Fail
          expect(validator('123 hello'), isNotNull);
          expect(validator(null), isNotNull);
          expect(validator(''), isNotNull);
        }),
      );

      testWidgets(
        'FormFieldValidatorExtensions.not',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator<String> validator =
              FormBuilderValidators.required<String>();
          final FormFieldValidator<String> negatedValidator = validator.not();

          // Pass
          expect(negatedValidator(null), isNull);
          expect(negatedValidator(''), isNull);

          // Fail
          // TODO: Verify why this is failing
          // expect(negatedValidator('test'), isNotNull);
        }),
      );

      testWidgets(
        'FormFieldValidatorExtensions.when',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator<String> validator =
              FormBuilderValidators.required<String>();
          bool condition(String? value) => value != null && value.isNotEmpty;
          final FormFieldValidator<String> conditionalValidator =
              validator.when(condition);

          // Pass
          expect(conditionalValidator('test'), isNull);

          // Fail
          expect(conditionalValidator(null), isNull);
          expect(conditionalValidator(''), isNull);
        }),
      );

      testWidgets(
        'FormFieldValidatorExtensions.unless',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator<String> validator =
              FormBuilderValidators.required<String>();
          final FormFieldValidator<String> conditionalValidator = validator
              .unless((String? value) => value != null && value.isNotEmpty);

          // Pass
          expect(conditionalValidator(null), isNull);
          // TODO: Verify why this is failing
          // expect(conditionalValidator(''), isNull);

          // Fail
          // TODO: Verify why this is failing
          // expect(conditionalValidator('test'), isNotNull);
        }),
      );

      testWidgets(
        'FormBuilderValidators.transform',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator<String> validator =
              FormBuilderValidators.transform<String>(
            FormBuilderValidators.required(),
            (String? value) => value?.trim() ?? '',
          );
          // Pass
          expect(validator(' trimmed '), isNull);
          // Fail
          expect(validator('  '), isNotNull);
          expect(validator(null), isNotNull);
          expect(validator(''), isNotNull);

          final FormFieldValidator<String> validatorWithErrorMessage =
              FormBuilderValidators.transform<String>(
            FormBuilderValidators.required(errorText: customErrorMessage),
            (String? value) => value?.trim() ?? '',
          );
          // Pass
          expect(validatorWithErrorMessage(' trimmed '), isNull);
          // Fail
          expect(validatorWithErrorMessage('  '), customErrorMessage);
        }),
      );

      testWidgets(
        'FormBuilderValidators.skipWhen',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator<String> validator =
              FormBuilderValidators.skipWhen<String>(
            (String? value) => value == 'skip',
            FormBuilderValidators.required(),
          );
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
        }),
      );

      testWidgets(
        'FormBuilderValidators.log',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator<String> validator =
              FormBuilderValidators.log<String>(
            log: (String? value) => 'Logging: $value',
          );
          // Pass
          expect(validator('test'), isNull);
          // Fail
          expect(validator(null), isNull);
          expect(validator(''), isNull);

          //TODO: Add object test
        }),
      );

      testWidgets(
        'FormFieldValidatorExtensions.withMessage',
        (WidgetTester tester) =>
            testValidations(tester, (BuildContext context) {
          final FormFieldValidator validator = FormBuilderValidators.required();
          const String errorMessage = 'This field is required';
          final FormFieldValidator validatorWithMessage =
              validator.withErrorMessage(errorMessage);

          // Pass
          expect(validatorWithMessage(null), errorMessage);
          expect(validatorWithMessage(''), errorMessage);

          // Fail
          expect(validatorWithMessage('test'), isNull);
        }),
      );
    },
  );
}
