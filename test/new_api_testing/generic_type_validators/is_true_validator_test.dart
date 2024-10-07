import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart' as v;

void main() {
  const String customErrorMessage = 'custom error message';
  group('Validator: isTrue', () {
    group('Validations with default error message', () {
      final List<({Object input, bool isValid})> testCases =
          <({Object input, bool isValid})>[
        (input: '', isValid: false),
        (input: '1', isValid: false),
        (input: 'notTrue', isValid: false),
        (input: 'T', isValid: false),
        (input: 'tru e', isValid: false),
        (input: 'true', isValid: true),
        (input: ' tRUe    ', isValid: true),
        (input: 'true\n', isValid: true),
        (input: '\ttrue', isValid: true),
        (input: 'tRuE', isValid: true),
        (input: true, isValid: true),
        (input: 'false', isValid: false),
        (input: 'fAlSe', isValid: false),
        (input: false, isValid: false),
      ];

      for (final (input: Object input, isValid: bool isValid) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : v.FormBuilderLocalizations.current.mustBeTrueErrorText;
        test(
            'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input"',
            () {
          expect(
            v.isTrue()(input),
            equals(expectedReturnValue),
          );
        });
      }
    });

    test(
        'Should return default error message when input is invalid with caseSensitive = true',
        () {
      expect(v.isTrue(caseSensitive: true)('tRue'),
          v.FormBuilderLocalizations.current.mustBeTrueErrorText);
    });
    test(
        'Should return default error message when input is invalid with trim = false',
        () {
      expect(v.isTrue(trim: false)('true  '),
          v.FormBuilderLocalizations.current.mustBeTrueErrorText);
      expect(v.isTrue(trim: false)(' true'),
          v.FormBuilderLocalizations.current.mustBeTrueErrorText);
      expect(v.isTrue(trim: false)(' true '),
          v.FormBuilderLocalizations.current.mustBeTrueErrorText);
    });

    test('should return the custom error message when the value is not true',
        () {
      // Arrange
      final v.Validator<String> validator =
          v.isTrue(isTrueMsg: customErrorMessage);
      const String value = 'not valid true';

      // Act
      final String? result = validator(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
