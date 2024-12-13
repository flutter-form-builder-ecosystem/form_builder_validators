import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  group('Validator: isDateTimeBetween', () {
    test('Validation for the range 1994 and 1997', () {
      final DateTime leftReference = DateTime(1994);
      final DateTime rightReference = DateTime(1997);
      final DateTime leftEq = leftReference.copyWith();
      final DateTime rightEq = rightReference.copyWith();
      final DateTime afterRight = DateTime(1998);
      final DateTime afterRight1Second =
          rightReference.add(const Duration(seconds: 1));
      final DateTime beforeRight1Second =
          rightReference.subtract(const Duration(seconds: 1));
      final DateTime between = DateTime(1995);
      final DateTime beforeLeft = DateTime(199);
      final DateTime afterLeft1Micro =
          leftReference.add(const Duration(microseconds: 1));
      final DateTime beforeLeft1Micro =
          leftReference.subtract(const Duration(microseconds: 1));
      final Validator<DateTime> v =
          isDateTimeBetween(leftReference, rightReference);
      final String errorMsg =
          tmpIsDateTimeBetweenErrorMsg(leftReference, rightReference);

      expect(
        v(leftEq),
        errorMsg,
        reason: 'Should return error against 1994',
      );
      expect(
        v(rightEq),
        errorMsg,
        reason: 'Should return error against 1997',
      );
      expect(
        v(afterRight),
        errorMsg,
        reason: 'Should return error against 1998',
      );
      expect(
        v(beforeLeft),
        errorMsg,
        reason: 'Should return error against 199',
      );
      expect(
        v(afterRight1Second),
        errorMsg,
        reason: 'Should return error against 1997 + 1 s',
      );
      expect(
        v(beforeRight1Second),
        isNull,
        reason: 'Should return null against 1997 - 1 s',
      );
      expect(
        v(between),
        isNull,
        reason: 'Should return null against 1995',
      );
      expect(
        v(afterLeft1Micro),
        isNull,
        reason: 'Should return null against 1994 + 1 us',
      );
      expect(
        v(beforeLeft1Micro),
        errorMsg,
        reason: 'Should return error against 1994 - 1 us',
      );
    });
    test(
        'Left inclusive validation for left reference 2089, month 3, day 23, h 3, min 46, s 12, 233 ms and right reference 2089, month 3, day 23, h 7',
        () {
      final DateTime leftReference = DateTime(2089, 3, 23, 3, 46, 12, 233);
      final DateTime rightReference = DateTime(2089, 3, 23, 7);
      final DateTime between =
          leftReference.add(Duration(hours: 2, seconds: 10));
      final DateTime leftEq = leftReference.copyWith();
      final DateTime rightEq = rightReference.copyWith();
      final DateTime afterRight = rightReference.copyWith(year: 2099);
      final DateTime after1Ms =
          rightReference.add(const Duration(milliseconds: 1));
      final DateTime before1Year = leftReference.copyWith(year: 2088);
      final DateTime before1Sec =
          leftReference.subtract(const Duration(seconds: 1));
      final Validator<DateTime> v =
          isDateTimeBetween(leftReference, rightReference, leftInclusive: true);
      final String errorMsg =
          tmpIsDateTimeBetweenErrorMsg(leftReference, rightReference);

      expect(
        v(leftEq),
        isNull,
        reason: 'Should return null against the same left datetime',
      );
      expect(
        v(between),
        isNull,
        reason: 'Should return null against a datetime between the references',
      );
      expect(
        v(rightEq),
        errorMsg,
        reason: 'Should return errorMsg against the same right datetime',
      );
      expect(
        v(afterRight),
        errorMsg,
        reason:
            'Should return error against the right reference shifted +10 years',
      );
      expect(
        v(after1Ms),
        errorMsg,
        reason:
            'Should return error against the right reference shifted +1 millisecond',
      );
      expect(
        v(after1Ms),
        errorMsg,
        reason: 'Should return error against the reference shifted +1 ms',
      );
      expect(
        v(before1Year),
        errorMsg,
        reason:
            'Should return error against a datetime 1 year before the left reference',
      );
      expect(
        v(before1Sec),
        errorMsg,
        reason:
            'Should return error against a datetime 1 sec before the left reference',
      );
    });

    test('Should return a custom message after validating', () {
      const String errorMsg = 'error msg';
      final DateTime leftReference = DateTime(2);
      final DateTime rightReference = DateTime(5);
      final Validator<DateTime> v = isDateTimeBetween(
          leftReference, rightReference,
          isDateTimeBetweenMsg: (_, __) => errorMsg);

      expect(
        v(rightReference.copyWith()),
        errorMsg,
        reason:
            'Should return custom message when input is equal to the reference',
      );
      expect(
        v(rightReference.subtract(const Duration(microseconds: 1))),
        isNull,
        reason:
            'Should return null when input is before the  right reference for 1 s',
      );
      expect(
        v(rightReference.add(const Duration(days: 1))),
        errorMsg,
        reason:
            'Should return custom message when the input is after the right reference',
      );
    });

    test(
        'Should throw AssertionError when the right reference is not after left reference',
        () {
      expect(
          () => isDateTimeBetween(
              DateTime(1990, 12, 23, 20), DateTime(1990, 12, 22, 20)),
          throwsAssertionError);
    });
  });
}
