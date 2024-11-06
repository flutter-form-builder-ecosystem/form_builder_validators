import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String errorMsg = 'error msg';
  String? hasLengthGreaterThan3(String input) =>
      input.length > 3 ? null : errorMsg;
  String? isEven(int input) => input % 2 == 0 ? null : errorMsg;

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

  group('Validator: isInt', () {
    test('Should only check if the input is an int/parsable to int', () {
      final Validator<Object> v = isInt();

      expect(v('not an int'),
          equals(FormBuilderLocalizations.current.integerErrorText));
      expect(
          v('1-3'), equals(FormBuilderLocalizations.current.integerErrorText));
      expect(v('123.0'),
          equals(FormBuilderLocalizations.current.integerErrorText));
      expect(
          v(123.0), equals(FormBuilderLocalizations.current.integerErrorText));
      expect(v('123'), isNull);
      expect(v('1'), isNull);
      expect(v(24), isNull);
      expect(v(-24), isNull);
      expect(v('-0'), isNull);
    });
    test('Should check if the input is an even integer', () {
      final Validator<Object> v = isInt(isEven);

      expect(v('not an int'),
          equals(FormBuilderLocalizations.current.integerErrorText));
      expect(v('1234'), isNull);
      expect(v(-4), isNull);
      expect(v('1233'), equals(errorMsg));
    });
    test('Should check if the input is an int using custom error', () {
      const String customError = 'custom error';
      final Validator<Object> v = isInt(null, customError);

      expect(v('not int'), equals(customError));
      expect(v('23'), isNull);
      expect(v(23), isNull);
    });
  });
}
