import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as val;

void main() {
  group('Validator: contains', () {
    group('Case sensitive validation', () {
      final List<({String input, bool isValid, String substring})> testCases =
          <({String input, bool isValid, String substring})>[
            // Empty substring
            (substring: '', input: '', isValid: true),
            (substring: '', input: ' ', isValid: true),
            (substring: '', input: 'this', isValid: true),
            (substring: '', input: 'tHIs', isValid: true),
            // "a" substring
            (substring: 'a', input: '', isValid: false),
            (substring: 'a', input: 'a', isValid: true),
            (substring: 'a', input: 'A', isValid: false),
            (substring: 'a', input: 'b', isValid: false),
            (substring: 'a', input: 'b a c', isValid: true),
            // " a " substring
            (substring: ' a ', input: 'a', isValid: false),
            (substring: ' a ', input: 'b a c', isValid: true),
            // "hello" substring
            (substring: 'hello', input: 'hell o', isValid: false),
            (substring: 'hello', input: 'Hello, hello world!', isValid: true),
            (substring: 'hello', input: 'Hello, helLo world!', isValid: false),
            (substring: 'hello', input: 'helllo', isValid: false),
            // "Hello World!" substring
            (substring: 'Hello World!', input: 'hello world!', isValid: false),
            (substring: 'Hello World!', input: 'Hello, World!', isValid: false),
            // "   " substring
            (substring: '   ', input: ' \t\t\t', isValid: false),
            (substring: '   ', input: ' ', isValid: false),
            (substring: '   ', input: '  ', isValid: false),
            (substring: '   ', input: '   ', isValid: true),
            (substring: '   ', input: '    ', isValid: true),
          ];

      for (final (
            substring: String substring,
            input: String input,
            isValid: bool isValid,
          )
          in testCases) {
        test(
          'should return ${isValid ? 'null' : 'error message'} when input is "$input" for substring "$substring"',
          () {
            final val.Validator<String> v = val.contains(substring);
            expect(
              v(input),
              isValid
                  ? isNull
                  : FormBuilderLocalizations.current.containsErrorText(
                      substring,
                    ),
            );
          },
        );
      }
    });
    group('Case insensitive validation', () {
      final List<({String input, bool isValid, String substring})> testCases =
          <({String input, bool isValid, String substring})>[
            // Empty substring
            (substring: '', input: '', isValid: true),
            (substring: '', input: ' ', isValid: true),
            (substring: '', input: 'this', isValid: true),
            (substring: '', input: 'tHIs', isValid: true),
            // "a" substring
            (substring: 'a', input: '', isValid: false),
            (substring: 'a', input: 'a', isValid: true),
            (substring: 'a', input: 'A', isValid: true),
            (substring: 'a', input: 'b', isValid: false),
            (substring: 'a', input: 'b a c', isValid: true),
            // " a " substring
            (substring: ' a ', input: 'a', isValid: false),
            (substring: ' a ', input: 'b a c', isValid: true),
            (substring: ' a ', input: 'b A c', isValid: true),
            // "hello" substring
            (substring: 'hello', input: 'hell o', isValid: false),
            (substring: 'hello', input: 'Hello, hello world!', isValid: true),
            (substring: 'hello', input: 'Hello, helLo world!', isValid: true),
            (substring: 'hello', input: 'helllo', isValid: false),
            // "Hello World!" substring
            (substring: 'Hello World!', input: 'hello world!', isValid: true),
            (substring: 'Hello World!', input: 'Hello, World!', isValid: false),
          ];

      for (final (
            substring: String substring,
            input: String input,
            isValid: bool isValid,
          )
          in testCases) {
        test(
          'should return ${isValid ? 'null' : 'error message'} when input is "$input" for substring "$substring"',
          () {
            final val.Validator<String> v = val.contains(
              substring,
              caseSensitive: false,
            );
            expect(
              v(input),
              isValid
                  ? isNull
                  : FormBuilderLocalizations.current.containsErrorText(
                      substring,
                    ),
            );
          },
        );
      }
    });

    test('should return custom error message', () {
      const String errorMsg = 'error msg';
      final val.Validator<String> v = val.contains(
        'substring test',
        caseSensitive: false,
        containsMsg: (_, _) => errorMsg,
      );

      expect(v('This must pass: subSTRING TESt'), isNull);
      expect(v('This must not pass: subSTRIN TESt'), errorMsg);
    });
  });
}
