import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';

  group('Validator: uppercase', () {
    group('Validations with default error message', () {
      String turkishUppercase = 'ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ';
      String randomUppercase =
          'B, Æ, À, Ø, Ĉ, Ĳ, Ɣ, Φ, Ϋ, Ϗ, Ϧ, Ѓ, Ѽ, Ծ, Ⴌ, Ḝ, Ἄ, Ⓜ, Ⰲ, Ⲫ, Ａ, 𐐜';
      String turkishWithLowercase = 'ABCçDEFGğHIIJKLMNOöPRSŞTUüVYZ';
      String randomWithLowercase =
          'B, æ, À, Ø, Ĉ, Ĳ, Ɣ, φ, Ϋ, Ϗ, Ϧ, Ѓ, Ѽ, ծ, Ⴌ, Ḝ, Ἄ, Ⓜ, ⰲ, Ⲫ, Ａ, 𐑄';
      final List<({String input, bool isValid})> testCases =
          <({String input, bool isValid})>[
            (input: '', isValid: true),
            (input: '   \t', isValid: true),
            (input: 'd', isValid: false),
            (input: 'password123', isValid: false),
            (input: 'D', isValid: true),
            (input: 'DD', isValid: true),
            (input: 'D A', isValid: true),
            (input: '1 2dAD', isValid: false),
            (input: 'Password123', isValid: false),
            (input: 'IDL', isValid: true),
            // Testing for non A-Z chars
            (input: 'Ç', isValid: true),
            (input: 'ç', isValid: false),
            (input: '123!@#\$%¨&*()_+`{}[]´^~/?:', isValid: true),
            (input: 'AÁ12', isValid: true),
            (input: turkishUppercase, isValid: true),
            (input: randomUppercase, isValid: true),
            (input: turkishWithLowercase, isValid: false),
            (input: randomWithLowercase, isValid: false),
            // Examples that does not work:
            // (input: 'ფ, ꟶ, 𐓀', isValid: true),
          ];

      for (final (input: String input, isValid: bool isValid) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current.uppercaseErrorText;
        test(
          'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input"',
          () {
            expect(uppercase()(input), equals(expectedReturnValue));
          },
        );
      }
    });

    group('Validations with custom error message', () {
      test(
        'should return the custom error message when the value has lowercase',
        () {
          // Arrange
          final Validator<String> validator = uppercase(
            uppercaseMsg: (_) => customErrorMessage,
          );
          const String value = 'PAsSWORD123';

          // Act
          final String? result = validator(value);

          // Assert
          expect(result, equals(customErrorMessage));
        },
      );
    });
  });
}
