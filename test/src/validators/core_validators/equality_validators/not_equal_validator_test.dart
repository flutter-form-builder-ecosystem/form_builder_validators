import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

class _CustomClass {}

void main() {
  final _CustomClass myObject = _CustomClass();

  group('Validator: notEqual', () {
    final List<
      ({
        String description,
        bool testFails,
        Object? referenceValue,
        Object? userInput,
      })
    >
    testCases =
        <
          ({
            String description,
            Object? referenceValue,
            Object? userInput,
            bool testFails,
          })
        >[
          // Edge cases
          (
            description: 'Should pass when the input is not null',
            referenceValue: null,
            userInput: 123,
            testFails: false,
          ),
          (
            description: 'Should fail when the value is null',
            referenceValue: null,
            userInput: null,
            testFails: true,
          ),
          (
            description: 'Should pass when the input is not the empty string',
            referenceValue: '',
            userInput: '\t',
            testFails: false,
          ),
          (
            description: 'Should fail when the value is the empty string',
            referenceValue: '',
            userInput: '',
            testFails: true,
          ),
          // Domain cases
          (
            description: 'Should pass when the input is not the integer 123',
            referenceValue: 123,
            userInput: 122,
            testFails: false,
          ),
          (
            description:
                'Should pass when the input is not the string "Hello, World!"',
            referenceValue: 'Hello, World!',
            userInput: 'Hello, World',
            testFails: false,
          ),
          (
            description: 'Should fail when the input is "Hello, World!"',
            referenceValue: 'Hello, World!',
            userInput: 'Hello, World!',
            testFails: true,
          ),
          (
            description:
                'Should pass when the input is not the same as a custom object',
            referenceValue: myObject,
            userInput: _CustomClass(),
            testFails: false,
          ),
          (
            description:
                'Should fail when the input is the same as a custom class object',
            referenceValue: myObject,
            userInput: myObject,
            testFails: true,
          ),
        ];

    for (final (
          description: String desc,
          referenceValue: Object? referenceValue,
          userInput: Object? userInput,
          testFails: bool testFails,
        )
        in testCases) {
      test(desc, () {
        final Validator<Object?> v = notEqual(referenceValue);

        expect(
          v(userInput),
          testFails
              ? equals(
                  FormBuilderLocalizations.current.notEqualErrorText(
                    referenceValue.toString(),
                  ),
                )
              : isNull,
        );
      });
    }

    test('Should return custom error message', () {
      const String ref = 'hello';
      const String customErrorMessage = 'custom error';
      final Validator<Object> v = notEqual(
        ref,
        notEqualMsg: (_, _) => customErrorMessage,
      );

      // success
      expect(v(123), isNull);

      // failure
      expect(v(ref), customErrorMessage);
    });
  });
}
