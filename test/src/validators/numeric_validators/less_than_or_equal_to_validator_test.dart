import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as val;

void main() {
  group('Validator: lessThanOrEqualTo', () {
    group('Valid comparisons', () {
      final List<(List<(num, bool)>, {num n})> testCases =
          <(List<(num, bool)>, {num n})>[
            (
              n: 0,
              <(num, bool)>[
                // (input, isValid)
                (-1, true),
                (-0.1, true),
                (0, true),
                (0.001, false),
                (10, false),
              ],
            ),
            (
              n: 7,
              <(num, bool)>[
                // (input, isValid)
                (6.7, true),
                (6.9, true),
                (7, true),
                (7.1, false),
                (10, false),
              ],
            ),
            (
              n: -232,
              <(num, bool)>[
                // (input, isValid)
                (-1000, true),
                (6.7, false),
                (4510, false),
              ],
            ),
          ];
      for (final (List<(num, bool)>, {num n}) testCase in testCases) {
        final num n = testCase.n;
        test(
          'Should return error message if input is not less than or equal to $n',
          () {
            final val.Validator<num> v = val.lessThanOrEqualTo(n);
            final String errorMsg = FormBuilderLocalizations.current
                .lessThanOrEqualToErrorText(n);
            for (final (num input, bool isValid) in testCase.$1) {
              expect(
                v(input),
                isValid ? isNull : errorMsg,
                reason:
                    '"$input" should ${isValid ? '' : 'not'} be less than or equal to $n',
              );
            }
          },
        );
      }
    });
    test('Should validate with custom message', () {
      const String msg = 'error msg';
      final val.Validator<int> v = val.lessThanOrEqualTo(
        34,
        lessThanOrEqualToMsg: (_, _) => msg,
      );

      expect(v(35), msg);
      expect(v(-1234), isNull);
    });
  });
}
