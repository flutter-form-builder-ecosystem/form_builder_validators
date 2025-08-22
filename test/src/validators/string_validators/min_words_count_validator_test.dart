import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';

  group('Validator: minWordsCount', () {
    group('Validations with default error message', () {
      final List<({String input, bool isValid, int minValue})> testCases =
          <({int minValue, String input, bool isValid})>[
            // min = 0
            (minValue: 0, input: '', isValid: true),
            (minValue: 0, input: '         ', isValid: true),
            (minValue: 0, input: '\t\n', isValid: true),
            (minValue: 0, input: 'j', isValid: true),
            (minValue: 0, input: 'with three words', isValid: true),
            // min = 1
            (minValue: 1, input: '', isValid: false),
            (minValue: 1, input: '   \t', isValid: false),
            (minValue: 1, input: 'd', isValid: true),
            (minValue: 1, input: 'password123', isValid: true),
            (minValue: 1, input: '1 2 3', isValid: true),
            // min = 2
            (minValue: 2, input: '#_&', isValid: false),
            (minValue: 2, input: '# &', isValid: true),
            (minValue: 2, input: '# & *', isValid: true),
            (minValue: 2, input: '   2   ', isValid: false),
            // min = 10
            (minValue: 10, input: 'hello, world!', isValid: false),
            (minValue: 10, input: 'a-b-c-d-e-f-g-i-j-k-l', isValid: false),
            (
              minValue: 10,
              input: 'a - b - c - d - e - f - g - i - j - k - l',
              isValid: true,
            ),
          ];

      for (final (
            minValue: int minValue,
            input: String input,
            isValid: bool isValid,
          )
          in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current.minWordsCountErrorText(minValue);
        test(
          'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input", min words = $minValue',
          () {
            expect(minWordsCount(minValue)(input), equals(expectedReturnValue));
          },
        );
      }
    });

    group('Validations with custom error message', () {
      test(
        'should return the custom error message when the value has less than 4 words',
        () {
          // Arrange
          final Validator<String> validator = minWordsCount(
            4,
            minWordsCountMsg: (_, __) => customErrorMessage,
          );
          const String value = 'only three words';

          // Act
          final String? result = validator(value);

          // Assert
          expect(result, equals(customErrorMessage));
        },
      );
    });

    test('Should throw argument error when the min parameter is invalid', () {
      expect(() => minWordsCount(-10), throwsArgumentError);
      expect(() => minWordsCount(-1), throwsArgumentError);
    });
  });
}
