import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';

  group('Validator: maxWordsCount', () {
    group('Validations with default error message', () {
      final List<({String input, bool isValid, int maxValue})> testCases =
          <({int maxValue, String input, bool isValid})>[
            // max = 0
            (maxValue: 0, input: '', isValid: true),
            (maxValue: 0, input: '         ', isValid: true),
            (maxValue: 0, input: '\t\n', isValid: true),
            (maxValue: 0, input: 'j', isValid: false),
            (maxValue: 0, input: 'with three words', isValid: false),
            // max = 1
            (maxValue: 1, input: '', isValid: true),
            (maxValue: 1, input: '   \t', isValid: true),
            (maxValue: 1, input: 'd', isValid: true),
            (maxValue: 1, input: 'password123', isValid: true),
            (maxValue: 1, input: '1\n\n3', isValid: false),
            (maxValue: 1, input: '1\t3', isValid: false),
            (maxValue: 1, input: '1 2 3', isValid: false),
            // max = 2
            (maxValue: 2, input: '#_&', isValid: true),
            (maxValue: 2, input: '# &', isValid: true),
            (maxValue: 2, input: '# & *', isValid: false),
            (maxValue: 2, input: '   2   ', isValid: true),
            // max = 10
            (maxValue: 10, input: 'hello, world!', isValid: true),
            (maxValue: 10, input: 'a-b-c-d-e-f-g-i-j-k-l', isValid: true),
            (
              maxValue: 10,
              input: 'a - b - c - d - e - f - g - i - j - k - l',
              isValid: false,
            ),
          ];

      for (final (
            maxValue: int maxValue,
            input: String input,
            isValid: bool isValid,
          )
          in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current.maxWordsCountErrorText(maxValue);
        test(
          'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input", max words = $maxValue',
          () {
            expect(maxWordsCount(maxValue)(input), equals(expectedReturnValue));
          },
        );
      }
    });

    group('Validations with custom error message', () {
      test(
        'should return the custom error message when the value has more than 4 words',
        () {
          // Arrange
          final Validator<String> validator = maxWordsCount(
            4,
            maxWordsCountMsg: (_, _) => customErrorMessage,
          );
          const String value = 'only five words\n! .';

          // Act
          final String? result = validator(value);

          // Assert
          expect(result, equals(customErrorMessage));
        },
      );
    });

    test('Should throw argument error when the max parameter is invalid', () {
      expect(() => maxWordsCount(-10), throwsArgumentError);
      expect(() => maxWordsCount(-1), throwsArgumentError);
    });
  });
}
