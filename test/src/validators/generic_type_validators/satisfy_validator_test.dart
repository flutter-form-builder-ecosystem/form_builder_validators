import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as v;

void main() {
  group('Validator: satisfy', () {
    test('Should validate always true condition', () {
      expect(v.satisfy((Object? i) => true)('input'), isNull);
    });
    test('Should validate always false condition', () {
      expect(v.satisfy((Object? i) => false)('input'),
          equals(FormBuilderLocalizations.current.satisfyErrorText));
    });
    test('Should validate if it is a positive even integer', () {
      final Validator<Object> validator = v.satisfy<Object>((Object input) {
        if (input is! int) {
          return false;
        }
        if (input > 0 && input % 2 == 0) {
          return true;
        }
        return false;
      });
      expect(validator('input'),
          equals(FormBuilderLocalizations.current.satisfyErrorText));
      expect(validator('12'),
          equals(FormBuilderLocalizations.current.satisfyErrorText));
      expect(validator(-12),
          equals(FormBuilderLocalizations.current.satisfyErrorText));
      expect(validator(0),
          equals(FormBuilderLocalizations.current.satisfyErrorText));
      expect(validator(3),
          equals(FormBuilderLocalizations.current.satisfyErrorText));
      expect(validator(2), isNull);
      expect(validator(10000), isNull);
    });

    test('Should validate with custom message', () {
      const String errorMsg = 'error message';
      final Validator<double> validator = v.satisfy<double>(
          (double i) => i > 23.4 && i <= 56.0,
          satisfyMsg: (_) => errorMsg);

      expect(validator(12), equals(errorMsg));
      expect(validator(23.4), equals(errorMsg));
      expect(validator(23.5), isNull);
      expect(validator(28.0099), isNull);
      expect(validator(56.0), isNull);
      expect(validator(56.1), equals(errorMsg));
      expect(validator(1000), equals(errorMsg));
    });
  });
}
