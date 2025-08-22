import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/user_information_validators.dart'
    as u;

void main() {
  group('Validator: password', () {
    group('Validations with default error message', () {
      final List<({String? expectedOutput, String password})>
      testCases = <({String? expectedOutput, String password})>[
        // Valid one
        (password: 'A1@abcefrtdsgjto', expectedOutput: null),
        // Invalid ones
        (
          password: '',
          expectedOutput: FormBuilderLocalizations.current.minLengthErrorText(
            16,
          ),
        ),
        (
          password:
              'this string has more than 32 characters, which is not allowed as a password by default',
          expectedOutput: FormBuilderLocalizations.current.maxLengthErrorText(
            32,
          ),
        ),
        (
          password: 'almostvalidpassword123@',
          expectedOutput: FormBuilderLocalizations.current
              .containsUppercaseCharErrorText(1),
        ),
        (
          password: 'ALMOSTVALIDPASSWORD123@',
          expectedOutput: FormBuilderLocalizations.current
              .containsLowercaseCharErrorText(1),
        ),
        (
          password: 'Almostvalidpassword!@#@',
          expectedOutput: FormBuilderLocalizations.current
              .containsNumberErrorText(1),
        ),
        (
          password: 'Almostvalidpaççword1234',
          expectedOutput: FormBuilderLocalizations.current
              .containsSpecialCharErrorText(1),
        ),
      ];

      final Validator<String> validator = u.password();
      for (final (
            password: String password,
            expectedOutput: String? expectedOutput,
          )
          in testCases) {
        test(
          'Should ${expectedOutput == null ? 'pass' : 'fail'} with password "$password"',
          () => expect(validator(password), equals(expectedOutput)),
        );
      }
    });
    group('Validations with custom', () {
      final String customErrorMessage = 'invalid password';
      final List<({bool fails, String password})>
      testCases = <({bool fails, String password})>[
        // Valid one
        (password: 'A1@abcefrtdsgjto', fails: false),
        // Invalid ones
        (password: '', fails: true),
        (
          password:
              'this string has more than 32 characters, which is not allowed as a password by default',
          fails: true,
        ),
        (password: 'almostvalidpassword123@', fails: true),
        (password: 'ALMOSTVALIDPASSWORD123@', fails: true),
        (password: 'ALMOSTVALIDPASSWORD!@#@', fails: true),
        (password: 'Almostvalidpaççword1234', fails: true),
      ];

      final Validator<String> validator = u.password(
        passwordMsg: (_) => customErrorMessage,
      );
      for (final (password: String password, fails: bool fails) in testCases) {
        test(
          'Should ${fails ? 'fail' : 'pass'} with password "$password" (custom message)',
          () => expect(
            validator(password),
            equals(fails ? customErrorMessage : null),
          ),
        );
      }
    });

    test(
      'should return null if the password meets all customized requirements',
      () {
        // Arrange
        final Validator<String> validator = u.password(
          minLength: 10,
          maxLength: 20,
          minUppercaseCount: 2,
          minLowercaseCount: 2,
          minNumberCount: 2,
          minSpecialCharCount: 2,
        );

        expect(validator('AbcdefG12!@'), isNull);
      },
    );

    test('Should throw argument error if any of the arguments are invalid', () {
      expect(() => u.password(minLength: -12), throwsArgumentError);
      expect(() => u.password(maxLength: -12), throwsArgumentError);
      expect(() => u.password(minUppercaseCount: -12), throwsArgumentError);
      expect(() => u.password(minLowercaseCount: -12), throwsArgumentError);
      expect(() => u.password(minNumberCount: -12), throwsArgumentError);
      expect(() => u.password(minSpecialCharCount: -12), throwsArgumentError);
      expect(
        () => u.password(minLength: 12, maxLength: 3),
        throwsArgumentError,
      );
    });
  });
}
