import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

const String errorMultBy6 = 'error';
String? isMultipleBy6(int value) {
  return value % 6 == 0 ? null : errorMultBy6;
}

void main() {
  final String defaultError =
      FormBuilderLocalizations.current.requiredErrorText;

  group('Validator: isRequired', () {
    test('Should check if the input value is not null/empty', () {
      final Validator<Object?> v = isRequired();

      expect(v(null), defaultError);
      expect(v(''), defaultError);
      expect(v(<String>[]), defaultError);
      expect(v(<int, String>{}), defaultError);
      expect(v(123), isNull);
      expect(v(' '), defaultError);
      expect(v('hello'), isNull);
    });

    test(
        'Should check if the input value is not null/empty with composed validator `v`',
        () {
      final Validator<int?> v = isRequired(isMultipleBy6);

      expect(v(null), equals(defaultError));
      expect(v(0), isNull);
      expect(v(1), equals(errorMultBy6));
      expect(v(5), equals(errorMultBy6));
      expect(v(6), isNull);
    });

    test('Should return custom message for null input', () {
      const String customMsg = 'custom error message ';
      final Validator<Object?> v = isRequired(null, customMsg);
      final Validator<int?> v1 = isRequired(isMultipleBy6, customMsg);

      expect(v(null), equals(customMsg));
      expect(v(''), equals(customMsg));
      expect(v1(null), equals(customMsg));
      expect(v(0), isNull);
      expect(v1(1), equals(errorMultBy6));
      expect(v1(6), isNull);
    });
  });
}
