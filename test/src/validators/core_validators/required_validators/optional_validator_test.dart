import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

const String errorMultBy6 = 'error';
String? isMultipleBy6(int value) {
  return value % 6 == 0 ? null : errorMultBy6;
}

void main() {
  final String defaultError =
      FormBuilderLocalizations.current.isOptionalErrorText(errorMultBy6);

  group('Validator: optional', () {
    test('Should make the input optional', () {
      final Validator<Object?> v = optional();

      expect(v(null), isNull);
      expect(v(''), isNull);
      expect(v(<String>[]), isNull);
      expect(v(<int, String>{}), isNull);
      expect(v(123), isNull);
      expect(v(' '), isNull);
      expect(v('hello'), isNull);
    });

    test('Should make the input optional with composed validator `v`', () {
      final Validator<int?> v = optional(isMultipleBy6);

      expect(v(null), isNull);
      expect(v(0), isNull);
      expect(v(1), equals(defaultError));
      expect(v(5), equals(defaultError));
      expect(v(6), isNull);
    });

    test('Should return custom message for invalid input', () {
      const String customMsg = 'custom error message ';
      final Validator<Object?> v = optional(null, (_, __) => customMsg);
      final Validator<int?> v1 = optional(isMultipleBy6, (_, __) => customMsg);

      expect(v(null), isNull);
      expect(v(''), isNull);
      expect(v1(null), isNull);
      expect(v(0), isNull);
      expect(v1(1), customMsg);
      expect(v1(6), isNull);
    });
  });
}
