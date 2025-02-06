import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

const String errorMultBy6 = 'error';
String? isMultipleBy6(int value) {
  return value % 6 == 0 ? null : errorMultBy6;
}

void main() {
  group('Validator: validateWithDefault', () {
    test('Should validate with valid default', () {
      final Validator<int?> v = validateWithDefault(0, isMultipleBy6);
      final Validator<int?> v1 = validateWithDefault(12, isMultipleBy6);

      expect(v(null), isNull);
      expect(v1(null), isNull);

      expect(v(6), isNull);
      expect(v1(18), isNull);

      expect(v(2), equals(errorMultBy6));
      expect(v1(14), equals(errorMultBy6));
    });
    test('Should validate with invalid default', () {
      final Validator<int?> v = validateWithDefault(1, isMultipleBy6);
      final Validator<int?> v1 = validateWithDefault(15, isMultipleBy6);

      expect(v(null), equals(errorMultBy6));
      expect(v1(null), equals(errorMultBy6));

      expect(v(6), isNull);
      expect(v1(18), isNull);

      expect(v(2), equals(errorMultBy6));
      expect(v1(14), equals(errorMultBy6));
    });
  });
}
