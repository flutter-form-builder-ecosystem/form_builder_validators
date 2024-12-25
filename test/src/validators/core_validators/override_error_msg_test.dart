import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  const String errorMsg = 'error msg';
  String? isEvenInteger(Object? input) =>
      input is int && input % 2 == 0 ? null : errorMsg;

  group('Validator: overrideErrorMsg', () {
    test('Should return null when the input is valid for the inner validator',
        () {
      const String newMsg = 'new error msg';
      final Validator<Object?> v =
          overrideErrorMsg((_) => newMsg, isEvenInteger);

      // sanity check
      expect(isEvenInteger(12), isNull);
      // test check
      expect(v(12), isNull);
    });
    test(
        'Should return new error message when the input is not valid for the inner validator',
        () {
      const String newMsg = 'new error msg';
      final Validator<Object?> v =
          overrideErrorMsg((_) => newMsg, isEvenInteger);

      // sanity check
      expect(isEvenInteger(null), errorMsg);
      // test check
      expect(v(13), newMsg);
      expect(v(null), newMsg);
    });
  });
}
