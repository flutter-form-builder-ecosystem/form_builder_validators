import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  const String defaultMsg = 'default error msg';
  String? isEvenGreaterThan56(int input) {
    return input > 56 && (input % 2 == 0) ? null : defaultMsg;
  }

  group('Validator: transformAndValidate', () {
    test('Should check if the String input is integer, transforming it', () {
      final Validator<String> v = transformAndValidate(int.parse);

      expect(v('12'), isNull);
      expect(v('not integer'),
          FormBuilderLocalizations.current.transformAndValidateErrorTextV1);
    });
    test('Should transform and apply a next validator', () {
      final Validator<String> v =
          transformAndValidate(int.parse, next: isEvenGreaterThan56);

      expect(v('12'), defaultMsg);
      expect(v('56'), defaultMsg);
      expect(v('59'), defaultMsg);
      expect(v('60'), isNull);
      expect(v('not integer'),
          FormBuilderLocalizations.current.transformAndValidateErrorTextV1);
    });
    test('Should return a custom transformation error message', () {
      const String customErrorMsg = 'custom error msg';
      final Validator<String> v = transformAndValidate(
        int.parse,
        next: isEvenGreaterThan56,
        transformAndValidateMsg: (_) => customErrorMsg,
      );

      expect(v('12'), defaultMsg);
      expect(v('56'), defaultMsg);
      expect(v('59'), defaultMsg);
      expect(v('60'), isNull);
      expect(v('not integer'), customErrorMsg);
    });
    test(
        'Should return an error message with transformed result type description',
        () {
      const String t = 'integer';
      final Validator<String> v = transformAndValidate(
        int.parse,
        next: isEvenGreaterThan56,
        transformedResultTypeDescription: t,
      );

      expect(v('12'), defaultMsg);
      expect(v('56'), defaultMsg);
      expect(v('59'), defaultMsg);
      expect(v('60'), isNull);
      expect(v('not integer'),
          FormBuilderLocalizations.current.transformAndValidateErrorTextV2(t));
    });
  });
}
