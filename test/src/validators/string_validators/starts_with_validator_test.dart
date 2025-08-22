import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as val;

void main() {
  group('Validator: startsWith', () {
    group('Case sensitive validation', () {
      final List<({String input, bool isValid, String prefix})> testCases =
          <({String input, bool isValid, String prefix})>[
            // Empty prefix
            (prefix: '', input: '', isValid: true),
            (prefix: '', input: ' ', isValid: true),
            (prefix: '', input: 'this', isValid: true),
            (prefix: '', input: 'tHIs', isValid: true),
            // "a" prefix
            (prefix: 'a', input: '', isValid: false),
            (prefix: 'a', input: 'a', isValid: true),
            (prefix: 'a', input: ' a', isValid: false),
            (prefix: 'a', input: 'A', isValid: false),
            (prefix: 'a', input: 'b', isValid: false),
            (prefix: 'a', input: 'b a c', isValid: false),
            // " a " prefix
            (prefix: ' a ', input: 'a', isValid: false),
            (prefix: ' a ', input: '  a b c', isValid: false),
            (prefix: ' a ', input: ' a b c', isValid: true),
            // "hello" prefix
            (prefix: 'hello', input: 'hell o', isValid: false),
            (prefix: 'hello', input: 'hello, hello world!', isValid: true),
            (prefix: 'hello', input: 'helLo, helLo world!', isValid: false),
            (prefix: 'hello', input: 'helllo', isValid: false),
            // "Hello World!" prefix
            (prefix: 'Hello World!', input: 'hello world!', isValid: false),
            (prefix: 'Hello World!', input: 'Hello, World!', isValid: false),
            // "   " prefix
            (prefix: '   ', input: ' \t\t\t', isValid: false),
            (prefix: '   ', input: ' ', isValid: false),
            (prefix: '   ', input: '  ', isValid: false),
            (prefix: '   ', input: '   ', isValid: true),
            (prefix: '   ', input: '    ', isValid: true),
          ];

      for (final (
            prefix: String prefix,
            input: String input,
            isValid: bool isValid,
          )
          in testCases) {
        test(
          'should return ${isValid ? 'null' : 'error message'} when input is "$input" for prefix "$prefix"',
          () {
            final val.Validator<String> v = val.startsWith(prefix);
            expect(
              v(input),
              isValid
                  ? isNull
                  : FormBuilderLocalizations.current.startsWithErrorText(
                      prefix,
                    ),
            );
          },
        );
      }
    });
    group('Case insensitive validation', () {
      final List<({String input, bool isValid, String prefix})> testCases =
          <({String input, bool isValid, String prefix})>[
            // Empty prefix
            (prefix: '', input: '', isValid: true),
            (prefix: '', input: ' ', isValid: true),
            (prefix: '', input: 'this', isValid: true),
            (prefix: '', input: 'tHIs', isValid: true),
            // "a" prefix
            (prefix: 'a', input: '', isValid: false),
            (prefix: 'a', input: 'a', isValid: true),
            (prefix: 'A', input: 'a', isValid: true),
            (prefix: 'a', input: 'A', isValid: true),
            (prefix: 'a', input: 'b', isValid: false),
            (prefix: 'a', input: 'b a c', isValid: false),
            // " a " prefix
            (prefix: ' a ', input: ' a b c', isValid: true),
            (prefix: ' A ', input: ' a b c', isValid: true),
            (prefix: ' a ', input: ' A b c', isValid: true),
            (prefix: ' a ', input: 'a', isValid: false),
            (prefix: ' a ', input: '  a b c', isValid: false),
            // "hello" prefix
            (prefix: 'hElLO', input: 'hello, hello world!', isValid: true),
            (prefix: 'HEllo', input: 'helLo, helLo world!', isValid: true),
            (prefix: 'hello', input: 'hell o', isValid: false),
            (prefix: 'hello', input: 'helllo', isValid: false),
            // "Hello World!" prefix
            (prefix: 'Hello World', input: 'hello world!', isValid: true),
            (prefix: 'Hello World!', input: 'Hello, World!', isValid: false),
            // "   " prefix
            (prefix: '   ', input: ' \t\t\t', isValid: false),
            (prefix: '   ', input: ' ', isValid: false),
            (prefix: '   ', input: '  ', isValid: false),
            (prefix: '   ', input: '   ', isValid: true),
            (prefix: '   ', input: '    ', isValid: true),
          ];

      for (final (
            prefix: String prefix,
            input: String input,
            isValid: bool isValid,
          )
          in testCases) {
        test(
          'should return ${isValid ? 'null' : 'error message'} when input is "$input" for prefix "$prefix"',
          () {
            final val.Validator<String> v = val.startsWith(
              prefix,
              caseSensitive: false,
            );
            expect(
              v(input),
              isValid
                  ? isNull
                  : FormBuilderLocalizations.current.startsWithErrorText(
                      prefix,
                    ),
            );
          },
        );
      }
    });

    test('should return custom error message', () {
      const String errorMsg = 'error msg';
      final val.Validator<String> v = val.startsWith(
        'prefix test',
        caseSensitive: false,
        startsWithMsg: (_, _) => errorMsg,
      );

      expect(v('pREfix TESt: This must pass'), isNull);
      expect(v('preffiX test: This must not pass'), errorMsg);
    });
  });
}
