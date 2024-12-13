import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class _CustomClass {
  @override
  String toString() => 'this is a string';
}

void main() {
  group('Validator: debugPrintValidator', () {
    final List<({String objectDescription, Object? value})> testCases =
        <({String objectDescription, Object? value})>[
      (objectDescription: 'empty string', value: ''),
      (objectDescription: 'null', value: null),
      (objectDescription: 'custom class', value: _CustomClass()),
      (objectDescription: 'string \'input 1\'', value: 'input 1'),
    ];
    for (final (objectDescription: String dsc, value: Object? value)
        in testCases) {
      test('Should print the String representation for: $dsc', () {
        final Validator<Object?> v = debugPrintValidator();
        expect(() => v(value), prints(equals('$value\n')));
        expect(v(value), isNull);
      });
    }

    test(
        'Should print the String representation of the input with next validator',
        () {
      const String errorMsg = 'error msg';
      final Validator<Object?> v = debugPrintValidator(
          next: (Object? v) => v is int && v % 2 == 0 ? null : errorMsg);

      expect(() => v(13), prints(equals('13\n')),
          reason: 'check stdout when input is \'13\'');
      expect(v(13), errorMsg,
          reason: 'check return value when input is \'13\'');

      expect(() => v('not int'), prints(equals('not int\n')),
          reason: 'check stdout when input is \'not int\'');
      expect(v('not int'), errorMsg,
          reason: 'check return value when input is \'not int\'');

      expect(() => v(10), prints(equals('10\n')),
          reason: 'check stdout when input is \'10\'');
      expect(v(10), isNull, reason: 'check return value when input is \'10\'');
    });
    test('Should print the custom String representation of the input', () {
      String logOnInput(Object? v) {
        return 'Hello world $v';
      }

      final Validator<Object?> v = debugPrintValidator(logOnInput: logOnInput);

      expect(() => v(13), prints(equals('${logOnInput(13)}\n')),
          reason: 'check stdout when input is \'13\'');
      expect(v(13), isNull, reason: 'check return value when input is \'13\'');

      final _CustomClass c = _CustomClass();
      expect(() => v(c), prints(equals('${logOnInput(c)}\n')),
          reason: 'check stdout when input is a custom object');
      expect(v(c), isNull,
          reason: 'check return value when input is a custom object');
    });
  });
}
