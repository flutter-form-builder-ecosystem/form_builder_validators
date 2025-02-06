import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as val;

void main() {
  group('Validator: greaterThanOrEqualTo', () {
    group('Valid comparisons', () {
      final List<(List<(num, bool)>, {num n})> testCases =
          <(List<(num, bool)>, {num n})>[
        (
          n: 0,
          <(num, bool)>[
            // (input, isValid)
            (-1, false),
            (-0.1, false),
            (0, true),
            (0.001, true),
            (10, true),
          ]
        ),
        (
          n: 7,
          <(num, bool)>[
            // (input, isValid)
            (6.7, false),
            (6.9, false),
            (7, true),
            (7.1, true),
            (10, true),
          ]
        ),
        (
          n: -232,
          <(num, bool)>[
            // (input, isValid)
            (-1000, false),
            (6.7, true),
            (4510, true),
          ]
        ),
      ];
      for (final (List<(num, bool)>, {num n}) testCase in testCases) {
        final num n = testCase.n;
        test(
            'Should return error message if input is not greater than or equal to $n',
            () {
          final val.Validator<num> v = val.greaterThanOrEqualTo(n);
          final String errorMsg =
              FormBuilderLocalizations.current.greaterThanOrEqualToErrorText(n);
          for (final (num input, bool isValid) in testCase.$1) {
            expect(v(input), isValid ? isNull : errorMsg,
                reason:
                    '"$input" should ${isValid ? '' : 'not'} be greater than or equal to $n');
          }
        });
      }
    });
    test('Should validate with custom message', () {
      const String msg = 'error msg';
      final val.Validator<int> v =
          val.greaterThanOrEqualTo(34, greaterThanOrEqualToMsg: (_, __) => msg);

      expect(v(35), isNull);
      expect(v(-1234), msg);
    });
  });
}
