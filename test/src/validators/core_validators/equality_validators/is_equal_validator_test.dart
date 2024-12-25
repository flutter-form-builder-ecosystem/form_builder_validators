import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class _CustomClass {}

void main() {
  final _CustomClass myObject = _CustomClass();

  group('Validator: isEqual', () {
    final List<
        ({
          String description,
          bool testFails,
          Object? referenceValue,
          Object? userInput
        })> testCases = <({
      String description,
      Object? referenceValue,
      Object? userInput,
      bool testFails
    })>[
      // Edge cases
      (
        description: 'Should match the null',
        referenceValue: null,
        userInput: null,
        testFails: false
      ),
      (
        description: 'Should not match the null',
        referenceValue: null,
        userInput: 123,
        testFails: true
      ),
      (
        description: 'Should match the empty string',
        referenceValue: '',
        userInput: '',
        testFails: false
      ),
      (
        description: 'Should not match the empty string',
        referenceValue: '',
        userInput: ' ',
        testFails: true
      ),
      // Domain cases
      (
        description: 'Should match the integer 123',
        referenceValue: 123,
        userInput: 123,
        testFails: false
      ),
      (
        description: 'Should match the string "Hello, World!"',
        referenceValue: 'Hello, World!',
        userInput: 'Hello, World!',
        testFails: false
      ),
      (
        description: 'Should not match the string "Hello, World!"',
        referenceValue: 'Hello, World!',
        userInput: 'Hello, World!\n',
        testFails: true
      ),
      (
        description: 'Should match a custom class object',
        referenceValue: myObject,
        userInput: myObject,
        testFails: false
      ),
      (
        description: 'Should not match a custom class object',
        referenceValue: myObject,
        userInput: _CustomClass(),
        testFails: true
      ),
    ];

    for (final (
          description: String desc,
          referenceValue: Object? referenceValue,
          userInput: Object? userInput,
          testFails: bool testFails
        ) in testCases) {
      test(desc, () {
        final Validator<Object?> v = isEqual(referenceValue);

        expect(
            v(userInput),
            testFails
                ? equals(FormBuilderLocalizations.current
                    .equalErrorText(referenceValue.toString()))
                : isNull);
      });
    }

    test('Should return custom error message', () {
      const String ref = 'hello';
      const String customErrorMessage = 'custom error';
      final Validator<Object> v =
          isEqual(ref, isEqualMsg: (_, __) => customErrorMessage);

      // success
      expect(v(ref), isNull);

      // failure
      expect(v(123), customErrorMessage);
    });
  });
}
