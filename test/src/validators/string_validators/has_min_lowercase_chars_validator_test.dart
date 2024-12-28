import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';

  group('Validator: hasMinLowercaseChars', () {
    group('Validations with default error message', () {
      String turkishLowercase = 'abcçdefgğhıijklmnoöprsştuüvyz';
      String randomLowercase =
          'b, æ, à, ø, ĉ, ĳ, ɣ, φ, ϋ, ϗ, ϧ, ѓ, ѽ, ծ, ⴌ, ḝ, ἄ, ⓜ, ⰲ, ⲫ, ａ, 𐑄';
      final List<({String input, bool isValid, int? minValue})> testCases =
          <({int? minValue, String input, bool isValid})>[
        (minValue: null, input: '', isValid: false),
        (minValue: null, input: '   \t', isValid: false),
        (minValue: null, input: 'D', isValid: false),
        (minValue: null, input: 'PASSWORD123', isValid: false),
        (minValue: 1, input: 'd', isValid: true),
        (minValue: 1, input: '1 2dAD', isValid: true),
        (minValue: 1, input: 'di', isValid: true),
        (minValue: 1, input: 'Password123', isValid: true),
        (minValue: 2, input: 'dD', isValid: false),
        (minValue: 2, input: 'dl', isValid: true),
        (minValue: 2, input: 'idl', isValid: true),
        (minValue: 2, input: 'PAssWORD123', isValid: true),
        (minValue: 2, input: 'Password123', isValid: true),
        (minValue: 4, input: 'Password123', isValid: true),
        // Testing for non A-Z chars
        (minValue: 1, input: 'ç', isValid: true),
        (minValue: 1, input: 'Ç', isValid: false),
        (minValue: 1, input: '123!@#\$%¨&*()_+`{}[]´^~/?:', isValid: false),
        (minValue: 1, input: 'Aá12', isValid: true),
        (minValue: 29, input: turkishLowercase, isValid: true),
        (minValue: 30, input: turkishLowercase, isValid: false),
        (minValue: 22, input: randomLowercase, isValid: true),
        (minValue: 23, input: randomLowercase, isValid: false),
        // Examples that does not work:
        // (minValue: 3, input: 'ფ, ꟶ, 𐓀', isValid: true),
      ];

      for (final (
            minValue: int? minValue,
            input: String input,
            isValid: bool isValid
          ) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current
                .containsLowercaseCharErrorText(minValue ?? 1);
        test(
            'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input", min lowercase = ${minValue ?? 1}',
            () {
          expect(
            hasMinLowercaseChars(min: minValue ?? 1)(input),
            equals(expectedReturnValue),
          );
        });
      }
    });

    group('Validations with custom error message', () {
      test(
          'should return the custom error message when the value does not have any lowercase characters',
          () {
        // Arrange
        final Validator<String> validator = hasMinLowercaseChars(
            hasMinLowercaseCharsMsg: (_, __) => customErrorMessage);
        const String value = 'PASSWORD123';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });

      test(
          'should return the custom error message when the value does not have enough lowercase characters',
          () {
        // Arrange
        final Validator<String> validator = hasMinLowercaseChars(
            min: 2, hasMinLowercaseCharsMsg: (_, __) => customErrorMessage);
        const String value = 'PASSWOrD';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('Should pass with custom counter that identifies # as lowercase', () {
      const String value = 'ABC#abc';
      expect(
          hasMinUppercaseChars(min: 4)(value),
          equals(FormBuilderLocalizations.current
              .containsUppercaseCharErrorText(4)));
      expect(
          hasMinUppercaseChars(
              min: 4,
              customUppercaseCounter: (String v) =>
                  RegExp('[a-z#]').allMatches(v).length)(value),
          isNull);
    });

    test('Should throw assertion error when the min parameter is invalid', () {
      expect(() => hasMinLowercaseChars(min: -10), throwsAssertionError);
      expect(() => hasMinLowercaseChars(min: -1), throwsAssertionError);
      expect(() => hasMinLowercaseChars(min: 0), throwsAssertionError);
    });
  });
}
