import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  group('Validator: between', () {
    final List<(List<(num, bool)>, {num max, int min})> testCases = [
      (
        min: 0,
        max: 0,
        <(num, bool)>[
          // (input, isValid)
          (-1, false),
          (-0.1, false),
          (0, true),
          (0.001, false),
          (10, false),
        ]
      ),
      (
        min: 7,
        max: 10.90,
        <(num, bool)>[
          // (input, isValid)
          (6.7, false),
          (6.9, false),
          (7, true),
          (7.1, true),
          (10, true),
          (10.9, true),
          (10.91, false),
          (110, false),
        ]
      ),
      (
        min: -232,
        max: 510,
        <(num, bool)>[
          // (input, isValid)
          (-1000, false),
          (6.7, true),
          (110, true),
          (4510, false),
        ]
      ),
    ];
    for (final testCase in testCases) {
      final min = testCase.min;
      final max = testCase.max;
      test('Should return error message if input is not in [$min, $max]', () {
        final v = between(min, max);
        final errorMsg = betweenTmpMsg(true, true, min, max);
        for (final (num input, bool isValid) in testCase.$1) {
          expect(v(input), isValid ? isNull : errorMsg,
              reason:
                  '"$input" should ${isValid ? '' : 'not'} be between [$min, $max]');
        }
      });
    }
  });
}
