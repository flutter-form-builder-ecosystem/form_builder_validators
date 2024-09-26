import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';

  group('Validator: hasMinUppercaseChars', () {
    group('Validations with default error message', () {
      final List<({String input, bool isValid, int? minValue})> testCases =
          <({int? minValue, String input, bool isValid})>[
        (minValue: null, input: '', isValid: false),
        (minValue: null, input: '   \t', isValid: false),
        (minValue: null, input: 'd', isValid: false),
        (minValue: null, input: 'password123', isValid: false),
        (minValue: 1, input: 'D', isValid: true),
        (minValue: 1, input: '1 2dAd', isValid: true),
        (minValue: 1, input: 'DI', isValid: true),
        (minValue: 1, input: 'PASSword123', isValid: true),
        (minValue: 2, input: 'dD', isValid: false),
        (minValue: 2, input: 'DL', isValid: true),
        (minValue: 2, input: 'IDL', isValid: true),
        (minValue: 2, input: 'passWOrd123', isValid: true),
        (minValue: 4, input: 'PASSWOrd123', isValid: true),
      ];

      for (final (
            minValue: int? minValue,
            input: String input,
            isValid: bool isValid
          ) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current
                .containsUppercaseCharErrorText(minValue ?? 1);
        test(
            'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input", min uppercase = ${minValue ?? 1}',
            () {
          expect(
            hasMinUppercaseChars(min: minValue ?? 1)(input),
            equals(expectedReturnValue),
          );
        });
      }
    });

    group('Validations with custom error message', () {
      test(
          'should return the custom error message when the value does not have any uppercase characters',
          () {
        // Arrange
        final Validator<String> validator = hasMinUppercaseChars(
            hasMinUppercaseCharsMsg: (_) => customErrorMessage);
        const String value = 'password123';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });

      test(
          'should return the custom error message when the value does not have enough uppercase characters',
          () {
        // Arrange
        final Validator<String> validator = hasMinUppercaseChars(
            min: 2, hasMinUppercaseCharsMsg: (_) => customErrorMessage);
        const String value = 'passwoRd';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('Should throw assertion error when the min parameter is invalid', () {
      expect(() => hasMinUppercaseChars(min: -10), throwsAssertionError);
      expect(() => hasMinUppercaseChars(min: -1), throwsAssertionError);
      expect(() => hasMinUppercaseChars(min: 0), throwsAssertionError);
    });
  });
}
