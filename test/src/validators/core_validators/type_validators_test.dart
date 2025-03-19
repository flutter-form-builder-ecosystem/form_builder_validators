import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  const String errorMsg = 'error msg';
  String? hasLengthGreaterThan3(String input) =>
      input.length > 3 ? null : errorMsg;
  String? isEven(int input) => input % 2 == 0 ? null : errorMsg;
  String? greaterThan9(num input) => input > 9 ? null : errorMsg;
  String? isT(bool input) => input ? null : errorMsg;
  String? isLaterThan1995(DateTime input) =>
      input.year > 1995 ? null : errorMsg;

  group('Validator: string', () {
    test('Should only check if the input is a String', () {
      final Validator<Object> v = string();

      expect(
          v(123), equals(FormBuilderLocalizations.current.isStringErrorText));
      expect(v('123'), isNull);
      expect(v('1'), isNull);
      expect(v(''), isNull);
    });
    test('Should check if the input is a String with length greater than 3',
        () {
      final Validator<Object> v = string(hasLengthGreaterThan3);

      expect(
          v(123), equals(FormBuilderLocalizations.current.isStringErrorText));
      expect(v('1234'), isNull);
      expect(v('12'), errorMsg);
      expect(v(''), errorMsg);
    });
    test('Should check if the input is a String with using custom error', () {
      const String customError = 'custom error';
      final Validator<Object> v = string(null, (_) => customError);

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
      final Validator<Object> v = isInt(null, (_) => customError);

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
      final Validator<Object> v = isNum(null, (_) => customError);

      expect(v('not num'), equals(customError));
      expect(v('23'), isNull);
      expect(v(-23.34), isNull);
    });
  });

  group('Validator: isDouble', () {
    test('Should only check if the input is a double/parsable to double', () {
      final Validator<Object> v = isDouble();

      expect(v('not an double'),
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
      expect(v(24.0), isNull);
      expect(v(-24.0), isNull);
      expect(v('-0'), isNull);
    });
    test('Should check if the input is a double greater than 9', () {
      final Validator<Object> v = isDouble(greaterThan9);

      expect(v('not an int'),
          equals(FormBuilderLocalizations.current.numericErrorText));
      expect(v('1234'), isNull);
      expect(v(10.0), isNull);
      expect(v(9.0), equals(errorMsg));
      expect(v(8.0), equals(errorMsg));
      expect(v(-4.0), equals(errorMsg));
      expect(v('-1234'), equals(errorMsg));
    });
    test('Should check if the input is a double using custom error', () {
      const String customError = 'custom error';
      final Validator<Object> v = isDouble(null, (_) => customError);

      expect(v('not double'), equals(customError));
      expect(v('23'), isNull);
      expect(v(-23.34), isNull);
    });
  });

  group('Validator: isBool', () {
    test('Should only check if the input is a bool/parsable to bool', () {
      // defaults to case insensitive and trim
      final Validator<Object> v = isBool();

      expect(v('not a bool'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v('T'), equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v('isTrue'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v('true.'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v('true true'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
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

      expect(v('not a bool'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v('T'), equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v('isTrue'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v('true.'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v(true), isNull);
      expect(v(1 > 2), isNull);
      expect(v(false), isNull);
      expect(
          v('True'), equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(
          v('TrUe'), equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v(' true'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v('true\n'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
    });
    test('Should check if the input is true', () {
      final Validator<Object> v = isBool(isT);

      expect(v('not a bool'),
          equals(FormBuilderLocalizations.current.booleanErrorText));
      expect(v(true), isNull);
      expect(v(1 > 2), equals(errorMsg));
      expect(v(false), equals(errorMsg));
      expect(v('False'), equals(errorMsg));
      expect(v('fAlSE   \n '), equals(errorMsg));
    });
    test('Should check if the input is a bool using custom error', () {
      const String customError = 'custom error';
      final Validator<Object> v = isBool(null, (_) => customError);

      expect(v('not num'), equals(customError));
      expect(v(true), isNull);
      expect(v(false), isNull);
    });
  });

  group('Validator: dateTime', () {
    test('Should only check if the input is an DateTime/parsable to DateTime',
        () {
      final Validator<Object> v = dateTime();

      expect(v('not an DateTime'),
          equals(FormBuilderLocalizations.current.dateTimeErrorText));
      expect(v('1/2.0/2023.0'),
          equals(FormBuilderLocalizations.current.dateTimeErrorText));
      expect(
          v(123.0), equals(FormBuilderLocalizations.current.dateTimeErrorText));

      expect(
        v('1992-04-20'),
        isNull,
        reason: 'Valid date in YYYY-MM-DD format (1992-04-20)',
      );
      expect(
        v('2012-02-27'),
        isNull,
        reason: 'Valid date in YYYY-MM-DD format (2012-02-27)',
      );
      expect(
        v('2012-02-27 13:27:00'),
        isNull,
        reason: 'Valid datetime with time in YYYY-MM-DD HH:MM:SS format',
      );
      expect(
        v('2012-02-27 13:27:00.123456789z'),
        isNull,
        reason: 'Valid datetime with fractional seconds and Z suffix',
      );
      expect(
        v('2012-02-27 13:27:00,123456789z'),
        isNull,
        reason:
            'Valid datetime with fractional seconds using comma and Z suffix',
      );
      expect(
        v('20120227 13:27:00'),
        isNull,
        reason: 'Valid compact date and time in YYYYMMDD HH:MM:SS format',
      );
      expect(
        v('20120227T132700'),
        isNull,
        reason:
            'Valid compact datetime with T separator in YYYYMMDDTHHMMSS format',
      );
      expect(
        v('20120227'),
        isNull,
        reason: 'Valid compact date in YYYYMMDD format',
      );
      expect(
        v('+20120227'),
        isNull,
        reason: 'Valid date with plus sign in +YYYYMMDD format',
      );
      expect(
        v('2012-02-27T14Z'),
        isNull,
        reason: 'Valid datetime with time and Z suffix',
      );
      expect(
        v('2012-02-27T14+00:00'),
        isNull,
        reason: 'Valid datetime with time and timezone offset +00:00',
      );
      expect(
        v('-123450101 00:00:00 Z'),
        isNull,
        reason: 'Valid historical date with negative year -12345 and Z suffix',
      );
      expect(
        v('2002-02-27T14:00:00-0500'),
        isNull,
        reason:
            'Valid datetime with timezone offset -0500, equivalent to "2002-02-27T19:00:00Z"',
      );
      expect(
        v(DateTime.now()),
        isNull,
        reason: 'Current DateTime object is valid',
      );
    });
    test('Should check if the input is a DateTime with year later than 1995',
        () {
      final Validator<Object> v = dateTime(isLaterThan1995);

      expect(v('not a datetime'),
          equals(FormBuilderLocalizations.current.dateTimeErrorText));
      expect(v('12330803'), equals(errorMsg));
    });

    test('Should check if the input is a DateTime using custom error', () {
      const String customError = 'custom error';
      final Validator<Object> v = dateTime(null, (_) => customError);

      expect(v('not datetime'), equals(customError));
      expect(v('1289-02-12'), isNull);
      expect(v(DateTime(1990)), isNull);
    });
  });
}
