import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';
  group('Validator: hasMinNumericCharsValidator', () {
    group('Validations with default error message', () {
      final List<({String input, bool isValid, int? minValue})> testCases =
          <({int? minValue, String input, bool isValid})>[
        (minValue: null, input: '', isValid: false),
        (minValue: null, input: '   \t', isValid: false),
        (minValue: null, input: 'D', isValid: false),
        (minValue: null, input: 'password', isValid: false),
        (minValue: 1, input: '9', isValid: true),
        (minValue: 1, input: 'dA1D', isValid: true),
        (minValue: 1, input: '08', isValid: true),
        (minValue: 1, input: 'Password123', isValid: true),
        (minValue: 2, input: '4D', isValid: false),
        (minValue: 2, input: '40', isValid: true),
        (minValue: 2, input: '287', isValid: true),
        (minValue: 2, input: 'password13', isValid: true),
        (minValue: 2, input: 'Password123', isValid: true),
        (minValue: 4, input: 'Pass0word123', isValid: true),
      ];

      for (final (
            minValue: int? minValue,
            input: String input,
            isValid: bool isValid
          ) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current
                .containsNumberErrorText(minValue ?? 1);
        test(
            'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input", min numeric = ${minValue ?? 1}',
            () {
          expect(
            hasMinNumericChars(min: minValue ?? 1)(input),
            equals(expectedReturnValue),
          );
        });
      }
    });
    group('Validations with custom error message', () {
      test(
          'Should return custom error message when the value does not have any numeric value',
          () {
        final Validator<String> validator = hasMinNumericChars(
          hasMinNumericCharsMsg: (_, __) => customErrorMessage,
        );
        expect(validator('passWORD'), equals(customErrorMessage));
      });
      test(
          'Should return custom error message when the value does not have enough numeric value',
          () {
        final Validator<String> validator = hasMinNumericChars(
          min: 4,
          hasMinNumericCharsMsg: (_, __) => customErrorMessage,
        );
        expect(validator('pas4sWORD1'), equals(customErrorMessage));
      });
    });

    test('Should pass when abcdef and ABCDEF is also considered numeric digits',
        () {
      const String s = '123aBc ijklm*';

      expect(hasMinNumericChars(min: 6)(s),
          equals(FormBuilderLocalizations.current.containsNumberErrorText(6)));
      expect(
          hasMinNumericChars(
              min: 6,
              customNumericCounter: (String v) =>
                  RegExp('[0-9a-fA-F]').allMatches(v).length)(s),
          isNull);
    });

    test('Should throw assertion error when the min parameter is invalid', () {
      expect(() => hasMinNumericChars(min: -10), throwsAssertionError);
      expect(() => hasMinNumericChars(min: -1), throwsAssertionError);
      expect(() => hasMinNumericChars(min: 0), throwsAssertionError);
    });
  });
}
