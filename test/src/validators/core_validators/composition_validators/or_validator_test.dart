import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

const String errorGt = 'error gt';
Validator<num> gt(num target) {
  return (num v) {
    return v > target ? null : errorGt;
  };
}

const String errorLtE = 'error lte';
Validator<num> ltE(num target) {
  return (num v) {
    return v <= target ? null : errorLtE;
  };
}

const String errorIsEven = 'error is even';
Validator<num> isEven() {
  return (num v) {
    if (v is int && v % 2 == 0) {
      return null;
    }
    return errorIsEven;
  };
}

void main() {
  group('Composition: or', () {
    test('Should validate using only one validator', () {
      final Validator<num> v = or(<Validator<num>>[gt(10)]);

      expect(v(9), errorGt);
      expect(v(10), errorGt);
      expect(v(11), isNull);
    });

    test('Should validate using two validators', () {
      final Validator<num> v1 = or(<Validator<num>>[gt(100), ltE(19)]);
      final Validator<num> v2 = or(<Validator<num>>[ltE(19), gt(100)]);

      expect(v1(9), isNull);
      expect(v1(23),
          '$errorGt${FormBuilderLocalizations.current.orSeparator}$errorLtE');
      expect(v1(1002), isNull);

      expect(v2(19), isNull);
      expect(v2(100),
          '$errorLtE${FormBuilderLocalizations.current.orSeparator}$errorGt');
      expect(v2(101), isNull);
    });

    test(
        'Should validate if the input is even or a number greater than 10.4 or less than or equal to 9.0',
        () {
      final Validator<num> v1 =
          or(<Validator<num>>[isEven(), gt(10.4), ltE(9.0)]);
      final Validator<num> v2 =
          or(<Validator<num>>[ltE(9.0), gt(10.4), isEven()]);

      expect(v1(3), isNull);
      expect(v1(10), isNull);
      expect(v1(10.1),
          '$errorIsEven${FormBuilderLocalizations.current.orSeparator}$errorGt${FormBuilderLocalizations.current.orSeparator}$errorLtE');
      expect(v1(13), isNull);

      expect(v2(3), isNull);
      expect(v2(10), isNull);
      expect(v2(10.1),
          '$errorLtE${FormBuilderLocalizations.current.orSeparator}$errorGt${FormBuilderLocalizations.current.orSeparator}$errorIsEven');
      expect(v2(13), isNull);
    });

    test(
        'Should validate if the input is even or greater than 5 or divisible by 37 with custom prefix, suffix and separator.',
        () {
      const String prefix = 'prefix';
      const String suffix = 'suffix';
      const String separator = ' oR ';
      const String errorDivBy37 = 'not divisible by 37';
      final Validator<int> v = or(
        <Validator<int>>[
          isEven(),
          gt(5),
          (int v) => v % 37 == 0 ? null : errorDivBy37
        ],
        prefix: prefix,
        suffix: suffix,
        separator: separator,
      );

      expect(
          v(1),
          equals('$prefix${<String>[
            errorIsEven,
            errorGt,
            errorDivBy37
          ].join(separator)}$suffix'));
      expect(v(2), isNull);
      expect(v(7), isNull);
      expect(v(74), isNull);
    });
    test('Should throw AssertionError when the validators input is empty', () {
      expect(() => or(<Validator<Object?>>[]), throwsAssertionError);
    });
  });
}
