import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  group('Validator: isInThePast', () {
    test('Validation for the current time', () {
      final DateTime after10Years =
          DateTime.now().add(const Duration(days: 365));
      final DateTime after60Seconds =
          DateTime.now().add(const Duration(seconds: 60));
      final DateTime before1Year =
          DateTime.now().subtract(const Duration(days: 365));
      final DateTime before60Seconds =
          DateTime.now().subtract(const Duration(seconds: 60));
      final Validator<DateTime> v = isInThePast();
      final String errorMsg =
          FormBuilderLocalizations.current.dateMustBeInThePastErrorText;

      expect(
        v(after10Years),
        errorMsg,
        reason: 'Should return error against now + 10 years',
      );
      expect(
        v(after60Seconds),
        errorMsg,
        reason: 'Should return error against now + 60 seconds',
      );
      expect(
        v(before1Year),
        isNull,
        reason: 'Should return null against now - 1 year',
      );
      expect(
        v(before60Seconds),
        isNull,
        reason: 'Should return null against now - 60 seconds',
      );
    });

    test('Should return a custom message after validating', () {
      const String errorMsg = 'error msg';
      final Validator<DateTime> v =
          isInThePast(isInThePastMsg: (_) => errorMsg);

      expect(v(DateTime.now().add(const Duration(seconds: 1))), errorMsg);
    });
  });
}
