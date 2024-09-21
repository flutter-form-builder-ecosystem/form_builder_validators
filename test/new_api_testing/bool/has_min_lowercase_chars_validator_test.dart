import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Validator: hasMinLowercaseChars', () {
    group('Validations with default error message', () {
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
            hasMinLowercaseCharsMessage: (_) => customErrorMessage);
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
            min: 2, hasMinLowercaseCharsMessage: (_) => customErrorMessage);
        const String value = 'PASSWOrD';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });
    });

    test('Should throw assertion error when the min parameter is invalid', () {
      expect(() => hasMinLowercaseChars(min: -1), throwsAssertionError);
      expect(() => hasMinLowercaseChars(min: 0), throwsAssertionError);
    });

    group('Custom Regex is provided', () {
      test(
          'should return the custom error message when using a custom regex and the value does not match',
          () {
        // Arrange
        final Validator<String> validator = hasMinLowercaseChars(
          // todo investigate the need for this argument.
          regex: RegExp('[a-z]'),
          hasMinLowercaseCharsMessage: (_) => customErrorMessage,
        );
        const String value = 'PASSWORD';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      });

      test('should return null when using a custom regex and the value matches',
          () {
        // Arrange
        final Validator<String> validator =
            hasMinLowercaseChars(regex: RegExp('[a-z]'));
        const String value = 'Password';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, isNull);
      });
    });
  });
}
