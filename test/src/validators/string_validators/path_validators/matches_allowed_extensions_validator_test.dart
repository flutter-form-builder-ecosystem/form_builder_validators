import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  group('Validator: matchesAllowedExtensionsValidator', () {
    final List<({List<String> extensions, bool isValid, String userInput})>
        testCases =
        <({List<String> extensions, bool isValid, String userInput})>[
      (userInput: '.gitignore', extensions: <String>['.', ''], isValid: true),
      (userInput: 'file.txt', extensions: <String>['.txt'], isValid: true),
      (userInput: 'file.exe', extensions: <String>['.txt'], isValid: false),

      // Empty and null cases
      (userInput: '', extensions: <String>['.txt'], isValid: false),
      (userInput: 'noextension', extensions: <String>['.txt'], isValid: false),

      // Multiple extensions
      (
        userInput: 'script.js',
        extensions: <String>['.js', '.ts'],
        isValid: true
      ),
      (
        userInput: 'style.css',
        extensions: <String>['.js', '.ts'],
        isValid: false
      ),

      // Case sensitivity
      (userInput: 'file.TXT', extensions: <String>['.txt'], isValid: false),
      (userInput: 'file.Txt', extensions: <String>['.txt'], isValid: false),

      // Path handling
      (userInput: '../dir1/file.2', extensions: <String>['.2'], isValid: true),
      (
        userInput: '/absolute/path/file.txt',
        extensions: <String>['.txt'],
        isValid: true
      ),
      (
        userInput: 'relative/path/file.txt',
        extensions: <String>['.txt'],
        isValid: true
      ),

      // Multiple dots
      (
        userInput: '.gitignore.exe',
        extensions: <String>['.exe'],
        isValid: true
      ),
      (
        userInput: '.gitignore.nexe.exe',
        extensions: <String>['.exe'],
        isValid: true
      ),
      (
        userInput: '.gitignore.exe.nexe',
        extensions: <String>['.exe'],
        isValid: false
      ),
      (
        userInput: '.gitignore.exe.nexe',
        extensions: <String>['.exe.nexe'],
        isValid: true
      ),
      (userInput: 'archive.tar.gz', extensions: <String>['.gz'], isValid: true),
      (userInput: '.hidden', extensions: <String>['.hidden'], isValid: false),
      (
        userInput: '.hidden.hidden',
        extensions: <String>['.hidden'],
        isValid: true
      ),
      (userInput: '..double', extensions: <String>['.double'], isValid: true),
      (userInput: 'file.', extensions: <String>[''], isValid: false),
      (userInput: 'file.', extensions: <String>['.', ''], isValid: true),
      (userInput: '.', extensions: <String>['.', ''], isValid: true),

      // Special characters
      (userInput: 'file name.txt', extensions: <String>['.txt'], isValid: true),
      (userInput: 'file-name.txt', extensions: <String>['.txt'], isValid: true),
    ];
    for (final ({
      List<String> extensions,
      bool isValid,
      String userInput
    }) testCase in testCases) {
      test(
          'Should ${testCase.isValid ? 'return null' : 'return error message'} when input is "${testCase.userInput}" for extensions ${testCase.extensions}',
          () {
        final String errorMsg =
            FormBuilderLocalizations.current.fileExtensionErrorText(
          testCase.extensions.join(', '),
        );
        final Validator<String> v =
            matchesAllowedExtensions(testCase.extensions);

        expect(
          v(testCase.userInput),
          testCase.isValid ? isNull : errorMsg,
        );
      });
    }
    test('Should throw ArgumentError when allowed extensions is empty', () {
      expect(() => matchesAllowedExtensions(<String>[]), throwsArgumentError);
    });
    test(
        'Should throw ArgumentError when an invalid extension is provided to extensions',
        () {
      expect(
          () => matchesAllowedExtensions(<String>['invalid extension', '.txt']),
          throwsArgumentError);
    });

    test(
        'Should accept files with extension "tXt" or empty when case insensitive',
        () {
      final List<String> extensions = <String>['.tXt', ''];
      final String errorMsg =
          FormBuilderLocalizations.current.fileExtensionErrorText(
        extensions.join(', '),
      );
      final Validator<String> v =
          matchesAllowedExtensions(extensions, caseSensitive: false);

      expect(v('valid.tXt'), isNull, reason: 'Input: "valid.tXt"');
      expect(v('valid.tXT'), isNull, reason: 'Input: "valid.tXT"');
      expect(v('emptyExtension'), isNull, reason: 'Input: "emptyExtension"');
      expect(v(''), isNull, reason: 'Input: empty string');
      expect(v('invalid.txt '), errorMsg, reason: 'Input: "invalid.txt "');
      expect(v('text.ttxt'), errorMsg, reason: 'Input: "text.ttxt"');
      expect(v('text. txt'), errorMsg, reason: 'Input: "text. txt"');
    });
    test(
        'Should accept files with extension ".abc" or ".a.b.d" or "" with custom message',
        () {
      final List<String> extensions = <String>['.abc', '.a.b.c', ''];
      const String errorMsg = 'custom error message';
      final Validator<String> v = matchesAllowedExtensions(extensions,
          matchesAllowedExtensionsMsg: (_) => errorMsg);

      expect(v('/valid/.abc'), isNull, reason: 'Input: "/valid/.abc"');
      // todo check if there is a bug with the p.extension function.
      // It seems to have a bug => https://github.com/dart-lang/core/issues/723
      //expect(v('/valid/.a.b'), errorMsg, reason: 'Input: "/valid/.a.b"');
    });
  });
}
