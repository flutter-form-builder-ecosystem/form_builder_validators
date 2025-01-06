import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as v;

void main() {
  const String customErrorMessage = 'custom error message';
  group('Validator: isFalse', () {
    group('Validations with default error message', () {
      final List<({Object input, bool isValid})> testCases =
          <({Object input, bool isValid})>[
        (input: '', isValid: false),
        (input: '1', isValid: false),
        (input: 'notFalse', isValid: false),
        (input: 'F', isValid: false),
        (input: 'fals e', isValid: false),
        (input: 'false', isValid: true),
        (input: ' faLSe    ', isValid: true),
        (input: 'false\n', isValid: true),
        (input: '\tfalse', isValid: true),
        (input: 'fAlSe', isValid: true),
        (input: false, isValid: true),
        (input: 'true', isValid: false),
        (input: 'tRUe', isValid: false),
        (input: true, isValid: false),
      ];

      for (final (input: Object input, isValid: bool isValid) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current.mustBeFalseErrorText;
        test(
            'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input"',
            () {
          expect(
            v.isFalse()(input),
            equals(expectedReturnValue),
          );
        });
      }
    });

    test(
        'Should return default error message when input is invalid with caseSensitive = true',
        () {
      expect(v.isFalse(caseSensitive: true)('False'),
          FormBuilderLocalizations.current.mustBeFalseErrorText);
    });
    test(
        'Should return default error message when input is invalid with trim = false',
        () {
      expect(v.isFalse(trim: false)('false  '),
          FormBuilderLocalizations.current.mustBeFalseErrorText);
      expect(v.isFalse(trim: false)(' false'),
          FormBuilderLocalizations.current.mustBeFalseErrorText);
      expect(v.isFalse(trim: false)(' false '),
          FormBuilderLocalizations.current.mustBeFalseErrorText);
    });

    test('should return the custom error message when the value is not false',
        () {
      // Arrange
      final v.Validator<String> validator =
          v.isFalse(isFalseMsg: (_) => customErrorMessage);
      const String value = 'not valid false';

      // Act
      final String? result = validator(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
