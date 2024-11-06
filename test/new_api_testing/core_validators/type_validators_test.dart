import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String errorMsg = 'error msg';
  String? hasLengthGreaterThan3(String input) =>
      input.length > 3 ? null : errorMsg;

  group('Validator: isString', () {
    test('Should only check if the input is a String', () {
      final Validator<Object> v = isString();

      expect(v(123), equals(tmpIsStringMsg));
      expect(v('123'), isNull);
      expect(v('1'), isNull);
      expect(v(''), isNull);
    });
    test('Should check if the input is a String with length greater than 3',
        () {
      final Validator<Object> v = isString(hasLengthGreaterThan3);

      expect(v(123), equals(tmpIsStringMsg));
      expect(v('1234'), isNull);
      expect(v('12'), errorMsg);
      expect(v(''), errorMsg);
    });
    test('Should check if the input is a String with using custom error', () {
      const String customError = 'custom error';
      final Validator<Object> v = isString(null, customError);

      expect(v(123), equals(customError));
      expect(v('1234'), isNull);
      expect(v('12'), isNull);
    });
  });
}
