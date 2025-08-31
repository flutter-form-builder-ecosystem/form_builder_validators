import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';

  group('Validator: lowercase', () {
    group('Validations with default error message', () {
      String turkishLowercase = 'abcçdefgğhıijklmnoöprsştuüvyz';
      String randomLowercase =
          'b, æ, à, ø, ĉ, ĳ, ɣ, φ, ϋ, ϗ, ϧ, ѓ, ѽ, ծ, ⴌ, ḝ, ἄ, ⓜ, ⰲ, ⲫ, ａ, 𐑄';
      String turkishWithUppercase = 'abcçdefgĞhıijklmnoÖprsŞtuÜvyz';
      String randomWithUppercase =
          'b, æ, à, Ø, ĉ, ĳ, ɣ, Φ, ϋ, ϗ, ϧ, ѓ, Ѽ, ծ, ⴌ, ḝ, ἄ, Ⓜ, ⰲ, Ⲫ, ａ, 𐑄';
      final List<({String input, bool isValid})> testCases =
          <({String input, bool isValid})>[
            (input: '', isValid: true),
            (input: '   \t', isValid: true),
            (input: 'D', isValid: false),
            (input: 'PASSWORD123', isValid: false),
            (input: 'd', isValid: true),
            (input: 'dd', isValid: true),
            (input: 'd a', isValid: true),
            (input: '1 2dAD', isValid: false),
            (input: 'Password123', isValid: false),
            (input: 'idl', isValid: true),
            // Testing for non A-Z chars
            (input: 'ç', isValid: true),
            (input: 'Ç', isValid: false),
            (input: '123!@#\$%¨&*()_+`{}[]´^~/?:', isValid: true),
            (input: 'aá12', isValid: true),
            (input: turkishLowercase, isValid: true),
            (input: randomLowercase, isValid: true),
            (input: turkishWithUppercase, isValid: false),
            (input: randomWithUppercase, isValid: false),
            // Examples that does not work:
            // (input: 'ფ, ꟶ, 𐓀', isValid: true),
          ];

      for (final (input: String input, isValid: bool isValid) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current.lowercaseErrorText;
        test(
          'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input"',
          () {
            expect(lowercase()(input), equals(expectedReturnValue));
          },
        );
      }
    });

    group('Validations with custom error message', () {
      test(
        'should return the custom error message when the value has uppercase',
        () {
          // Arrange
          final Validator<String> validator = lowercase(
            lowercaseMsg: (_) => customErrorMessage,
          );
          const String value = 'pasSword123';

          // Act
          final String? result = validator(value);

          // Assert
          expect(result, equals(customErrorMessage));
        },
      );
    });
  });
}
