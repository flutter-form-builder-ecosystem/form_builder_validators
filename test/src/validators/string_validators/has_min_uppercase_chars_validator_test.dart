import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String customErrorMessage = 'custom error message';

  group('Validator: hasMinUppercaseChars', () {
    group('Validations with default error message', () {
      String turkishUpper = 'ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ';
      String randomUppercase =
          'B, Æ, À, Ø, Ĉ, Ĳ, Ɣ, Φ, Ϋ, Ϗ, Ϧ, Ѓ, Ѽ, Ծ, Ⴌ, Ḝ, Ἄ, Ⓜ, Ⰲ, Ⲫ, Ａ, 𐐜';
      final List<({String input, bool isValid, int? minValue})> testCases =
          <({int? minValue, String input, bool isValid})>[
        (minValue: null, input: '', isValid: false),
        (minValue: null, input: '   \t', isValid: false),
        (minValue: null, input: 'd', isValid: false),
        (minValue: null, input: 'password123', isValid: false),
        (minValue: 1, input: 'D', isValid: true),
        (minValue: 1, input: '1 2dAd', isValid: true),
        (minValue: 1, input: 'DI', isValid: true),
        (minValue: 1, input: 'PASSword123', isValid: true),
        (minValue: 2, input: 'dD', isValid: false),
        (minValue: 2, input: 'DL', isValid: true),
        (minValue: 2, input: 'IDL', isValid: true),
        (minValue: 2, input: 'passWOrd123', isValid: true),
        (minValue: 4, input: 'PASSWOrd123', isValid: true),
        // Testing for non A-Z chars
        (minValue: 1, input: 'Ç', isValid: true),
        (minValue: 1, input: 'ç', isValid: false),
        (minValue: 1, input: '123!@#\$%¨&*()_+`{}[]´^~/?:', isValid: false),
        (minValue: 1, input: 'aÁ12', isValid: true),
        (minValue: 29, input: turkishUpper, isValid: true),
        (minValue: 30, input: turkishUpper, isValid: false),

        (minValue: 22, input: randomUppercase, isValid: true),
        (minValue: 23, input: randomUppercase, isValid: false),
        // Examples that does not work:
        // (minValue: 3, input: 'Ფ, Ꟶ, 𐓀', isValid: true),
      ];

      for (final (
            minValue: int? minValue,
            input: String input,
            isValid: bool isValid
          ) in testCases) {
        final String? expectedReturnValue = isValid
            ? null
            : FormBuilderLocalizations.current
                .containsUppercaseCharErrorText(minValue ?? 1);
        test(
            'Should return ${expectedReturnValue == null ? null : 'default error message'} with input "$input", min uppercase = ${minValue ?? 1}',
            () {
          expect(
            hasMinUppercaseChars(min: minValue ?? 1)(input),
            equals(expectedReturnValue),
          );
        });
      }
    });

    group('Validations with custom error message', () {
      test(
          'should return the custom error message when the value does not have any uppercase characters',
          () {
        // Arrange
        final Validator<String> validator = hasMinUppercaseChars(
            hasMinUppercaseCharsMsg: (_, __) => customErrorMessage);
        const String value = 'password123';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });

      test(
          'should return the custom error message when the value does not have enough uppercase characters',
          () {
        // Arrange
        final Validator<String> validator = hasMinUppercaseChars(
            min: 2, hasMinUppercaseCharsMsg: (_, __) => customErrorMessage);
        const String value = 'passwoRd';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('Should pass with custom counter that identifies # as uppercase', () {
      const String value = 'ABC#abc';
      expect(
          hasMinUppercaseChars(min: 4)(value),
          equals(FormBuilderLocalizations.current
              .containsUppercaseCharErrorText(4)));
      expect(
          hasMinUppercaseChars(
              min: 4,
              customUppercaseCounter: (String v) =>
                  RegExp('[A-Z#]').allMatches(v).length)(value),
          isNull);
    });
    test('Should throw assertion error when the min parameter is invalid', () {
      expect(() => hasMinUppercaseChars(min: -10), throwsAssertionError);
      expect(() => hasMinUppercaseChars(min: -1), throwsAssertionError);
      expect(() => hasMinUppercaseChars(min: 0), throwsAssertionError);
    });
  });
}
