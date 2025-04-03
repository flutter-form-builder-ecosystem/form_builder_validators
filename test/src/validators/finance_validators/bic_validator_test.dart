import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/finance_validators.dart';

void main() {
  group('Validator: bic', () {
    final List<({bool fails, String input})> testCases =
        <({bool fails, String input})>[
      (
        input: '',
        fails: true,
      ),
      (
        input: 'DEUTDEFF',
        fails: false,
      ),
      (
        input: 'DEUTDEFF500',
        fails: false,
      ),
      (
        input: 'INVALIDBIC',
        fails: true,
      ),
    ];

    final Validator<String> v = bic();
    for (final (input: String input, fails: bool fails) in testCases) {
      test('should ${fails ? 'fail' : 'pass'} for input "$input"', () {
        expect(v(input),
            fails ? FormBuilderLocalizations.current.bicErrorText : isNull);
      });
    }

    test('should return custom error msg', () {
      final Validator<String> v = bic(bicMsg: (_) => 'error text');

      expect(v('BOTKJPJTXXX'), isNull);
      expect(v('BOTKJPJTXX'), equals('error text'));
    });

    test('should use the custom logic to check if the input is a valid bic',
        () {
      final Validator<String> v =
          bic(isBic: (String input) => input.length == 3);
      expect(v('abc'), isNull);
      expect(v('abc '), equals(FormBuilderLocalizations.current.bicErrorText));
    });
  });
}
