import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  group('Validator: betweenLength', () {
    group('Validators with default error message', () {
      test(
          'Should validate the input when it is expected to have minLength equals to maxLength',
          () {
        final Validator<List<int>> v = betweenLength(0, 0);
        final Validator<Object> v2 = betweenLength(3, 3);

        expect(v(<int>[]), isNull);
        expect(
            v(<int>[12]), betweenLengthTemporaryErrorMessage(min: 0, max: 0));
        expect(v2(<int>[12, 23, 456]), isNull);
        expect(v2(12), betweenLengthTemporaryErrorMessage(min: 3, max: 3));
      });
      test(
          'Should validate the input when it is expected to have minLength 1 and maxLength 5',
          () {
        final Validator<List<int>> v = betweenLength(1, 5);
        final Validator<Object> v2 = betweenLength(1, 5);

        expect(v(<int>[]), betweenLengthTemporaryErrorMessage(min: 1, max: 5));
        expect(v(<int>[0]), isNull);
        expect(v(<int>[0, 1]), isNull);
        expect(v(<int>[0, 2, 3]), isNull);
        expect(v(<int>[23, 432, 52, 65, 1]), isNull);
        expect(v(<int>[1, 2, 3, 4, 5, 6]),
            betweenLengthTemporaryErrorMessage(min: 1, max: 5));
        expect(v(<int>[1, 2, 3, 4, 5, 6, 7]),
            betweenLengthTemporaryErrorMessage(min: 1, max: 5));

        expect(v2(<int>[]), betweenLengthTemporaryErrorMessage(min: 1, max: 5));
        expect(v2(''), betweenLengthTemporaryErrorMessage(min: 1, max: 5));
        expect(v2(<String>['0']), isNull);
        expect(v2(0), isNull);
        expect(v2(<Object>[1, '3']), isNull);
        expect(v2('hi '), isNull);
        expect(
            v2('      '), betweenLengthTemporaryErrorMessage(min: 1, max: 5));
      });
    });

    test('Should validate input returning custom message error when invalid',
        () {
      const String customMsg = 'custom msg';
      final Validator<Object> v = betweenLength(3, 4,
          betweenLengthMsg: ({required int min, required int max}) =>
              customMsg);

      expect(v(89), equals(customMsg));
      expect(v(<Object>[1, '2', 3, 4]), isNull);
      expect(v('   '), isNull);
    });
    group('Throws assertion error', () {
      test('Should throw AssertionError when minLength is negative', () {
        expect(() => betweenLength(-2, 3), throwsAssertionError);
        expect(() => betweenLength(-2, -3), throwsAssertionError);
      });
      test('Should throw AssertionError when maxLength is less than minLength',
          () {
        expect(() => betweenLength(3, 2), throwsAssertionError);
        expect(() => betweenLength(3, -2), throwsAssertionError);
      });
    });
  });
}
