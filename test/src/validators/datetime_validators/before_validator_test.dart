import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en', null);
  });
  group('Validator: before', () {
    test('Validation for the year 1994', () {
      final DateTime reference = DateTime(1994);
      final DateTime eq = reference.copyWith();
      final DateTime after10Years = DateTime(2004);
      final DateTime after1Ms = reference.add(const Duration(milliseconds: 1));
      final DateTime before1Year = DateTime(1993);
      final DateTime before1Sec = reference.subtract(
        const Duration(seconds: 1),
      );
      final Validator<DateTime> v = before(reference);
      final String errorMsg = FormBuilderLocalizations.current
          .dateMustBeBeforeErrorText(reference);

      expect(v(eq), errorMsg, reason: 'Should return error against 1994');
      expect(
        v(after10Years),
        errorMsg,
        reason: 'Should return error against 2004',
      );
      expect(
        v(after1Ms),
        errorMsg,
        reason: 'Should return error against 1994 + 1ms',
      );
      expect(v(before1Year), isNull, reason: 'Should return null against 1993');
      expect(
        v(before1Sec),
        isNull,
        reason: 'Should return null against 1994 - 1s',
      );
    });
    test(
      'Inclusive validation for datetime 2089, month 3, day 23, h 3, min 46, s 12, 233 ms',
      () {
        final DateTime reference = DateTime(2089, 3, 23, 3, 46, 12, 233);
        final DateTime eq = reference.copyWith();
        final DateTime after10Years = reference.copyWith(year: 2099);
        final DateTime after1Ms = reference.add(
          const Duration(milliseconds: 1),
        );
        final DateTime before1Year = reference.copyWith(year: 2088);
        final DateTime before1Sec = reference.subtract(
          const Duration(seconds: 1),
        );
        final Validator<DateTime> v = before(reference, inclusive: true);
        final String errorMsg = FormBuilderLocalizations.current
            .dateMustBeBeforeErrorText(reference);

        expect(
          v(eq),
          isNull,
          reason: 'Should return null against the same datetime',
        );
        expect(
          v(after10Years),
          errorMsg,
          reason: 'Should return error against the reference shifted +10 years',
        );
        expect(
          v(after1Ms),
          errorMsg,
          reason: 'Should return error against the reference shifted +1 ms',
        );
        expect(
          v(before1Year),
          isNull,
          reason:
              'Should return null against a datetime 1 year before the reference',
        );
        expect(
          v(before1Sec),
          isNull,
          reason:
              'Should return null against a datetime 1 sec before the reference',
        );
      },
    );

    test('Should return a custom message after validating', () {
      const String errorMsg = 'error msg';
      final DateTime reference = DateTime(2);
      final Validator<DateTime> v = before(
        reference,
        beforeMsg: (_, _) => errorMsg,
      );

      expect(
        v(reference.copyWith()),
        errorMsg,
        reason:
            'Should return custom message when input is equal to the reference',
      );
      expect(
        v(reference.subtract(const Duration(microseconds: 1))),
        isNull,
        reason: 'Should return null when input is before the reference',
      );
      expect(
        v(reference.add(const Duration(days: 1))),
        errorMsg,
        reason:
            'Should return custom message when the input is after the reference',
      );
    });
  });
}
