import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';
  group('Validator: hasMinSpecialCharsValidator', () {
    group('Validations with default error message', () {
      final List<({String input, bool isValid, int? minValue})> testCases =
          <({int? minValue, String input, bool isValid})>[
        (minValue: null, input: '', isValid: false),
        (minValue: null, input: 'D', isValid: false),
        (minValue: null, input: 'password', isValid: false),
        (minValue: 1, input: '*', isValid: true),
        (minValue: 1, input: '\$A1D', isValid: true),
        (minValue: 1, input: '(¨', isValid: true),
        (minValue: 1, input: 'Password123#', isValid: true),
        (minValue: 2, input: '+D', isValid: false),
        (minValue: 2, input: '==', isValid: true),
        (minValue: 2, input: '@_-', isValid: true),
        (minValue: 2, input: 'password13%%', isValid: true),
        (minValue: 2, input: 'Password123#@#', isValid: true),
        (minValue: 4, input: 'Pass0word123!!!!', isValid: true),
      ];

      for (final (
            minValue: int? minValue,
            input: String input,
            isValid: bool isValid
          ) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current
                .containsSpecialCharErrorText(minValue ?? 1);
        test(
            'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input", min special = ${minValue ?? 1}',
            () {
          expect(
            hasMinSpecialChars(min: minValue ?? 1)(input),
            equals(expectedReturnValue),
          );
        });
      }
    });
    group('Validations with custom error message', () {
      test(
          'Should return custom error message when the value does not have any special value',
          () {
        final Validator<String> validator = hasMinSpecialChars(
          hasMinSpecialCharsMsg: (_) => customErrorMessage,
        );
        expect(validator('passWORD'), equals(customErrorMessage));
      });
      test(
          'Should return custom error message when the value does not have enough special value',
          () {
        final Validator<String> validator = hasMinSpecialChars(
          min: 4,
          hasMinSpecialCharsMsg: (_) => customErrorMessage,
        );
        expect(validator('pas4sWORD1'), equals(customErrorMessage));
      });
    });

    test('Should throw assertion error when the min parameter is invalid', () {
      expect(() => hasMinSpecialChars(min: -10), throwsAssertionError);
      expect(() => hasMinSpecialChars(min: -1), throwsAssertionError);
      expect(() => hasMinSpecialChars(min: 0), throwsAssertionError);
    });
  });
}
