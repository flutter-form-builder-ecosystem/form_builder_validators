import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

const String errorGt = 'error gt';
Validator<num> gt(num target) {
  return (num v) {
    return v > target ? null : errorGt;
  };
}

void main() {
  group('Validator: skipIf', () {
    test('Should check if a number is greater than 10 if it is an even int',
        () {
      // Only even integers will be validated: ... 0, 2, 4 ...
      final Validator<num> v =
          skipIf((num v) => v is! int || v % 2 != 0, gt(10));

      expect(v(2.3), isNull);

      expect(v(8), errorGt);
      expect(v(10), errorGt);
      expect(v(12), isNull); // This is null because it is valid
      expect(v(13), isNull); // This is null because it was not validated.
    });
  });
}
