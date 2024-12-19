import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';

void main() {
  group('Validator: isInTheFuture', () {
    test('Validation for the current time', () {
      final DateTime after10Years =
          DateTime.now().add(const Duration(days: 365));
      final DateTime after60Seconds =
          DateTime.now().add(const Duration(seconds: 60));
      final DateTime before1Year =
          DateTime.now().subtract(const Duration(days: 365));
      final DateTime before60Seconds =
          DateTime.now().subtract(const Duration(seconds: 60));
      final Validator<DateTime> v = isInTheFuture();
      final String errorMsg =
          FormBuilderLocalizations.current.dateMustBeInTheFutureErrorText;

      expect(
        v(after10Years),
        isNull,
        reason: 'Should return null against now + 10 years',
      );
      expect(
        v(after60Seconds),
        isNull,
        reason: 'Should return null against now + 60 seconds',
      );
      expect(
        v(before1Year),
        errorMsg,
        reason: 'Should return errorMsg against now - 1 year',
      );
      expect(
        v(before60Seconds),
        errorMsg,
        reason: 'Should return errorMsg against now - 60 seconds',
      );
    });

    test('Should return a custom message after validating', () {
      const String errorMsg = 'error msg';
      final Validator<DateTime> v = isInTheFuture(isInTheFutureMsg: errorMsg);

      expect(v(DateTime.now().subtract(const Duration(seconds: 1))), errorMsg);
    });
  });
}
