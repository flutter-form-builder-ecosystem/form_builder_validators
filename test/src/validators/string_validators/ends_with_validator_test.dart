import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as val;

void main() {
  group('Validator: endsWith', () {
    group('Case sensitive validation', () {
      final List<({String input, bool isValid, String suffix})> testCases =
          <({String input, bool isValid, String suffix})>[
            // Empty suffix
            (suffix: '', input: '', isValid: true),
            (suffix: '', input: ' ', isValid: true),
            (suffix: '', input: 'this', isValid: true),
            (suffix: '', input: 'tHIs', isValid: true),
            // "a" suffix
            (suffix: 'a', input: '', isValid: false),
            (suffix: 'a', input: 'a', isValid: true),
            (suffix: 'a', input: 'a ', isValid: false),
            (suffix: 'a', input: 'A', isValid: false),
            (suffix: 'a', input: 'b', isValid: false),
            (suffix: 'a', input: 'b a c', isValid: false),
            // " a " suffix
            (suffix: ' a ', input: 'a', isValid: false),
            (suffix: ' a ', input: 'b c a  ', isValid: false),
            (suffix: ' a ', input: 'b b  a ', isValid: true),
            // "hello" suffix
            (suffix: 'world', input: 'w orld', isValid: false),
            (suffix: 'world', input: 'hello, hello world', isValid: true),
            (suffix: 'world', input: 'helLo, helLo world!', isValid: false),
            (suffix: 'world', input: 'worldd', isValid: false),
            // "Hello World!" suffix
            (suffix: 'Hello World!', input: 'hello world!', isValid: false),
            (suffix: 'Hello World!', input: 'Hello, World!', isValid: false),
            // "   " suffix
            (suffix: '   ', input: ' \t\t\t', isValid: false),
            (suffix: '   ', input: ' ', isValid: false),
            (suffix: '   ', input: '  ', isValid: false),
            (suffix: '   ', input: '   ', isValid: true),
            (suffix: '   ', input: '    ', isValid: true),
          ];

      for (final (
            suffix: String suffix,
            input: String input,
            isValid: bool isValid,
          )
          in testCases) {
        test(
          'should return ${isValid ? 'null' : 'error message'} when input is "$input" for suffix "$suffix"',
          () {
            final val.Validator<String> v = val.endsWith(suffix);
            expect(
              v(input),
              isValid
                  ? isNull
                  : FormBuilderLocalizations.current.endsWithErrorText(suffix),
            );
          },
        );
      }
    });
    group('Case insensitive validation', () {
      final List<({String input, bool isValid, String suffix})> testCases =
          <({String input, bool isValid, String suffix})>[
            // Empty suffix
            (suffix: '', input: '', isValid: true),
            (suffix: '', input: ' ', isValid: true),
            (suffix: '', input: 'this', isValid: true),
            (suffix: '', input: 'tHIs', isValid: true),
            // "a" suffix
            (suffix: 'a', input: '', isValid: false),
            (suffix: 'a', input: 'a', isValid: true),
            (suffix: 'A', input: 'a', isValid: true),
            (suffix: 'a', input: 'A', isValid: true),
            (suffix: 'a', input: 'b', isValid: false),
            (suffix: 'a', input: 'b a c', isValid: false),
            // " a " suffix
            (suffix: ' a ', input: 'c b a ', isValid: true),
            (suffix: ' A ', input: 'c b a ', isValid: true),
            (suffix: ' a ', input: 'c b A ', isValid: true),
            (suffix: ' a ', input: 'a', isValid: false),
            (suffix: ' a ', input: ' a b a  ', isValid: false),
            // "hello" suffix
            (suffix: 'WorLd!', input: 'hello, hello world!', isValid: true),
            (suffix: 'world!', input: 'helLo, helLo WoRlD!', isValid: true),
            // "Hello World!" suffix
            (suffix: 'Hello World!', input: 'hello world!', isValid: true),
            (suffix: 'Hello World!', input: 'Hello, World!', isValid: false),
            // "   " suffix
            (suffix: '   ', input: ' \t\t\t', isValid: false),
            (suffix: '   ', input: ' ', isValid: false),
            (suffix: '   ', input: '  ', isValid: false),
            (suffix: '   ', input: '   ', isValid: true),
            (suffix: '   ', input: '    ', isValid: true),
          ];

      for (final (
            suffix: String suffix,
            input: String input,
            isValid: bool isValid,
          )
          in testCases) {
        test(
          'should return ${isValid ? 'null' : 'error message'} when input is "$input" for suffix "$suffix"',
          () {
            final val.Validator<String> v = val.endsWith(
              suffix,
              caseSensitive: false,
            );
            expect(
              v(input),
              isValid
                  ? isNull
                  : FormBuilderLocalizations.current.endsWithErrorText(suffix),
            );
          },
        );
      }
    });

    test('should return custom error message', () {
      const String errorMsg = 'error msg';
      final val.Validator<String> v = val.endsWith(
        'suffix test',
        caseSensitive: false,
        endsWithMsg: (_, _) => errorMsg,
      );

      expect(v('This must pass: suffix tesT'), isNull);
      expect(v('This must not pass: sufix text'), errorMsg);
    });
  });
}
