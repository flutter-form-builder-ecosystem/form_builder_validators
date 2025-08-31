import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/src/validators/validators.dart';
import 'package:intl/intl.dart';

void main() {
  final List<NumberFormat> formattingMask = <NumberFormat>[
    NumberFormat("#,##0.#"),
    NumberFormat("#,##0,000.#"),
    NumberFormat("#,##0,000,000.#"),
    NumberFormat("#,##0,000,000,000.#"),
    NumberFormat("#,##0,000,000,000,000.#"),
  ];
  group('Validator: maxFileSize', () {
    final List<
      ({Base base, ({String input, String max})? expected, int input, int max})
    >
    testCases =
        <
          ({
            int max,
            int input,
            Base base,
            ({String input, String max})? expected,
          })
        >[
          (max: 1000, input: 1000, base: Base.b1000, expected: null),
          (max: 1024, input: 1024, base: Base.b1024, expected: null),
          (max: 1024, input: 512, base: Base.b1024, expected: null),
          (
            max: 1024,
            input: 1025,
            base: Base.b1024,
            expected: (
              max: '${formattingMask[1].format(1024)} B',
              input: '${formattingMask[1].format(1025)} B',
            ),
          ),
          (
            max: 1024 * 1024,
            input: 1025 * 1024,
            base: Base.b1024,
            expected: (
              max: '${formattingMask[1].format(1024)} KiB',
              input: '${formattingMask[1].format(1025)} KiB',
            ),
          ),
          (
            max: 5_000_000_000_000,
            input: 5_000_000_000_234,
            base: Base.b1000,
            expected: (
              max: '${formattingMask[3].format(5_000_000_000.0)} KB',
              input: '${formattingMask[3].format(5_000_000_000.2)} KB',
            ),
          ),
          (
            max: 5_000_000_000_234,
            input: 5_000_000_000_234,
            base: Base.b1000,
            expected: null,
          ),
          (
            max: 5_000_000_000_234,
            input: 5_000_000_000_233,
            base: Base.b1000,
            expected: null,
          ),
          (
            max: 5_000_000_000_000,
            input: 5_000_000_000_034,
            base: Base.b1000,
            expected: (
              max: '${formattingMask[4].format(5_000_000_000_000)} B',
              input: '${formattingMask[4].format(5_000_000_000_034)} B',
            ),
          ),
        ];

    for (final (
          max: int max,
          input: int input,
          base: Base base,
          expected: ({String input, String max})? expected,
        )
        in testCases) {
      test(
        'should ${expected == null ? 'match' : 'return error'} when max is $max B, input is $input B, and base ${base.base}',
        () {
          expect(
            maxFileSize(max, base: base)(input),
            expected == null
                ? isNull
                : stringContainsInOrder(<String>[expected.max, expected.input]),
          );
        },
      );
    }

    test('should return the custom error msg', () {
      final Validator<int> v = maxFileSize(
        12,
        maxFileSizeMsg: (_, int max, _) => 'File size should be less than $max',
      );

      expect(v(10), isNull);
      expect(v(12), isNull);
      expect(v(13), equals('File size should be less than 12'));
    });
  });

  group('Helper function: formatBoth', () {
    final List<({Base base, (String, String) expected, int v1, int v2})>
    testCases = <({Base base, (String, String) expected, int v1, int v2})>[
      (
        v1: 1024,
        v2: 1025,
        base: Base.b1000,
        expected: (
          '${formattingMask[1].format(1024)} B',
          '${formattingMask[1].format(1025)} B',
        ),
      ),
      (
        v1: 1024,
        v2: 1025,
        base: Base.b1024,
        expected: (
          '${formattingMask[1].format(1024)} B',
          '${formattingMask[1].format(1025)} B',
        ),
      ),
      (
        v1: 1024,
        v2: 1023,
        base: Base.b1024,
        expected: (
          '${formattingMask[0].format(1.0)} KiB',
          '${formattingMask[1].format(1023)} B',
        ),
      ),
      (v1: 1, v2: 2, base: Base.b1000, expected: ('1 B', '2 B')),
      (v1: 1, v2: 2, base: Base.b1024, expected: ('1 B', '2 B')),
      (
        v1: 10_000,
        v2: 12_123,
        base: Base.b1000,
        expected: (
          '${formattingMask[0].format(10.0)} KB',
          '${formattingMask[0].format(12.1)} KB',
        ),
      ),
      (
        v1: 10_000,
        v2: 12_123,
        base: Base.b1024,
        expected: (
          '${formattingMask[0].format(9.8)} KiB',
          '${formattingMask[0].format(11.8)} KiB',
        ),
      ),
      (
        v1: 12_124_000,
        v2: 12_123_000,
        base: Base.b1000,
        expected: (
          '${formattingMask[1].format(12_124.0)} KB',
          '${formattingMask[1].format(12_123.0)} KB',
        ),
      ),
      (
        v1: 12_124_000,
        v2: 12_123_000,
        base: Base.b1024,
        expected: (
          '${formattingMask[1].format(11_839.84)} KiB',
          '${formattingMask[1].format(11_838.87)} KiB',
        ),
      ),
      (
        v1: 12_100_000,
        v2: 12_199_999,
        base: Base.b1000,
        expected: (
          '${formattingMask[0].format(12.1)} MB',
          '${formattingMask[0].format(12.2)} MB',
        ),
      ),
      (
        v1: 12_100_000,
        v2: 12_199_999,
        base: Base.b1024,
        expected: (
          '${formattingMask[0].format(11.53)} MiB',
          '${formattingMask[0].format(11.63)} MiB',
        ),
      ),
      (
        v1: 9_100_000_000,
        v2: 9_100_300_001,
        base: Base.b1000,
        expected: (
          '${formattingMask[1].format(9_100.0)} MB',
          '${formattingMask[1].format(9_100.3)} MB',
        ),
      ),
      (
        v1: 9_100_000_000,
        v2: 9_100_000_001,
        base: Base.b1024,
        expected: (
          '${formattingMask[3].format(9_100_000_000)} B',
          '${formattingMask[3].format(9_100_000_001)} B',
        ),
      ),
      (
        v1: 999_231_665_990_003,
        v2: 999_231_665_990_004,
        base: Base.b1000,
        expected: (
          '${formattingMask[4].format(999_231_665_990_003)} B',
          '${formattingMask[4].format(999_231_665_990_004)} B',
        ),
      ),
      (
        v1: 999_231_665_990_003,
        v2: 999_231_665_990_004,
        base: Base.b1024,
        expected: (
          '${formattingMask[4].format(999_231_665_990_003)} B',
          '${formattingMask[4].format(999_231_665_990_004)} B',
        ),
      ),
      (
        v1: 12 * 1024 * 1024,
        v2: 23 * 1024,
        base: Base.b1024,
        expected: (
          '${formattingMask[0].format(12)} MiB',
          '${formattingMask[0].format(23)} KiB',
        ),
      ),
    ];

    for (final (
          v1: int v1,
          v2: int v2,
          base: Base base,
          expected: (String, String) expected,
        )
        in testCases) {
      test(
        'should return $expected when v1:$v1, v2:$v2, and base: ${base.base}',
        () {
          expect(formatBoth(v1, v2, base).toString(), expected.toString());
        },
      );
    }
  });
}
