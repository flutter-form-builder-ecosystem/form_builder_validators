import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  group('Validator: between', () {
    group('Valid inclusive comparisons', () {
      final List<(List<(num, bool)>, {num max, int min})> testCases =
          <(List<(num, bool)>, {num max, int min})>[
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
              ],
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
              ],
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
              ],
            ),
          ];
      for (final (List<(num, bool)>, {num max, int min}) testCase
          in testCases) {
        final int min = testCase.min;
        final num max = testCase.max;
        test('Should return error message if input is not in [$min, $max]', () {
          final Validator<num> v = between(min, max);
          final String errorMsg = FormBuilderLocalizations.current
              .betweenNumErrorText(min, max, 'true', 'true');
          for (final (num input, bool isValid) in testCase.$1) {
            expect(
              v(input),
              isValid ? isNull : errorMsg,
              reason:
                  '"$input" should ${isValid ? '' : 'not'} be between [$min, $max]',
            );
          }
        });
      }
    });
    test('Should throw Argument error when min is greater than max', () {
      expect(() => between(0, -2), throwsArgumentError);
      expect(() => between(232, 89), throwsArgumentError);
    });

    test('Should validate with non-inclusive references', () {
      const int left = -3;
      const int right = 45;
      const double mid = (left + right) / 2;
      final Validator<num> vLeft = between(left, right, minInclusive: false);
      final String leftErrorMsg = FormBuilderLocalizations.current
          .betweenNumErrorText(left, right, 'false', 'true');
      final Validator<num> vRight = between(left, right, maxInclusive: false);
      final String rightErrorMsg = FormBuilderLocalizations.current
          .betweenNumErrorText(left, right, 'true', 'false');
      final Validator<num> vBoth = between(
        left,
        right,
        minInclusive: false,
        maxInclusive: false,
      );
      final String bothErrorMsg = FormBuilderLocalizations.current
          .betweenNumErrorText(left, right, 'false', 'false');

      expect(
        vLeft(left),
        equals(leftErrorMsg),
        reason:
            '(L1) Left boundary should be invalid when left is non-inclusive',
      );
      expect(
        vRight(left),
        isNull,
        reason: '(L2) Left boundary should be valid when left is inclusive',
      );
      expect(
        vBoth(left),
        equals(bothErrorMsg),
        reason:
            '(L3) Left boundary should be invalid when both sides are non-inclusive',
      );

      expect(
        vLeft(mid),
        isNull,
        reason: '(M1) Midpoint should always be valid with non-inclusive left',
      );
      expect(
        vRight(mid),
        isNull,
        reason: '(M2) Midpoint should always be valid with non-inclusive right',
      );
      expect(
        vBoth(mid),
        isNull,
        reason:
            '(M3) Midpoint should always be valid with both sides non-inclusive',
      );

      expect(
        vLeft(right),
        isNull,
        reason: '(R1) Right boundary should be valid when right is inclusive',
      );
      expect(
        vRight(right),
        equals(rightErrorMsg),
        reason:
            '(R2) Right boundary should be invalid when right is non-inclusive',
      );
      expect(
        vBoth(right),
        equals(bothErrorMsg),
        reason:
            '(R3) Right boundary should be invalid when both sides are non-inclusive',
      );
    });
    test('Should validate with custom message', () {
      const String msg = 'error msg';
      final Validator<int> v = between(
        0,
        34,
        betweenMsg: (_, _, _, _, _) => msg,
      );

      expect(v(3), isNull);
      expect(v(-1234), msg);
    });
  });
}
