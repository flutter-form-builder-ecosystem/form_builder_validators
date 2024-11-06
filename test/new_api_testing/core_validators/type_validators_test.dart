import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String errorMsg = 'error msg';
  String? hasLengthGreaterThan3(String input) =>
      input.length > 3 ? null : errorMsg;
  String? isEven(int input) => input % 2 == 0 ? null : errorMsg;
  String? greaterThan9(num input) => input > 9 ? null : errorMsg;
  String? isT(bool input) => input ? null : errorMsg;

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
      expect(v(1 + 1), isNull);
      expect(v(1 ~/ 1), isNull);
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

  group('Validator: isNum', () {
    test('Should only check if the input is a num/parsable to num', () {
      final Validator<Object> v = isNum();

      expect(v('not an num'),
          equals(FormBuilderLocalizations.current.numericErrorText));
      expect(
          v('1-3'), equals(FormBuilderLocalizations.current.numericErrorText));
      expect(
          v(true), equals(FormBuilderLocalizations.current.numericErrorText));
      expect(v('123.0'), isNull);
      expect(v('123'), isNull);
      expect(v('1'), isNull);
      expect(v('1e3'), isNull);
      expect(v(24 / 3), isNull);
      expect(v(24), isNull);
      expect(v(-24), isNull);
      expect(v('-0'), isNull);
    });
    test('Should check if the input is an numeric greater than 9', () {
      final Validator<Object> v = isNum(greaterThan9);

      expect(v('not an int'),
          equals(FormBuilderLocalizations.current.numericErrorText));
      expect(v('1234'), isNull);
      expect(v(10), isNull);
      expect(v(9), equals(errorMsg));
      expect(v(8), equals(errorMsg));
      expect(v(-4), equals(errorMsg));
      expect(v('-1234'), equals(errorMsg));
    });
    test('Should check if the input is a num using custom error', () {
      const String customError = 'custom error';
      final Validator<Object> v = isNum(null, customError);

      expect(v('not num'), equals(customError));
      expect(v('23'), isNull);
      expect(v(-23.34), isNull);
    });
  });

  group('Validator: isBool', () {
    test('Should only check if the input is a bool/parsable to bool', () {
      // defaults to case insensitive and trim
      final Validator<Object> v = isBool();

      expect(v('not a bool'), equals(tmpIsBoolMsg));
      expect(v('T'), equals(tmpIsBoolMsg));
      expect(v('isTrue'), equals(tmpIsBoolMsg));
      expect(v('true.'), equals(tmpIsBoolMsg));
      expect(v('true true'), equals(tmpIsBoolMsg));
      expect(v(true), isNull);
      expect(v(1 > 2), isNull);
      expect(v(false), isNull);
      expect(v('True'), isNull);
      expect(v('TrUe'), isNull);
      expect(v(' true'), isNull);
      expect(v('true\n'), isNull);
    });
    test(
        'Should only check if the input is a bool/parsable to bool without trim and with case sensitiveness',
        () {
      final Validator<Object> v = isBool(null, null, true, false);

      expect(v('not a bool'), equals(tmpIsBoolMsg));
      expect(v('T'), equals(tmpIsBoolMsg));
      expect(v('isTrue'), equals(tmpIsBoolMsg));
      expect(v('true.'), equals(tmpIsBoolMsg));
      expect(v(true), isNull);
      expect(v(1 > 2), isNull);
      expect(v(false), isNull);
      expect(v('True'), equals(tmpIsBoolMsg));
      expect(v('TrUe'), equals(tmpIsBoolMsg));
      expect(v(' true'), equals(tmpIsBoolMsg));
      expect(v('true\n'), equals(tmpIsBoolMsg));
    });
    test('Should check if the input is true', () {
      final Validator<Object> v = isBool(isT);

      expect(v('not a bool'), equals(tmpIsBoolMsg));
      expect(v(true), isNull);
      expect(v(1 > 2), equals(errorMsg));
      expect(v(false), equals(errorMsg));
      expect(v('False'), equals(errorMsg));
      expect(v('fAlSE   \n '), equals(errorMsg));
    });
    test('Should check if the input is a bool using custom error', () {
      const String customError = 'custom error';
      final Validator<Object> v = isBool(null, customError);

      expect(v('not num'), equals(customError));
      expect(v(true), isNull);
      expect(v(false), isNull);
    });
  });
}
