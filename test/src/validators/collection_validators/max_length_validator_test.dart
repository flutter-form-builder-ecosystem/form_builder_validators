import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  group('Validator: maxLength', () {
    group('Validators with default error message', () {
      test('Should validate the input when it is expected to have maxLength 0',
          () {
        final Validator<List<int>> v = maxLength(0);
        final Validator<Object> v2 = maxLength(0);

        expect(v(<int>[]), isNull);
        expect(v2(<int>[12]),
            FormBuilderLocalizations.current.maxLengthErrorText(0));
        expect(v2(12), FormBuilderLocalizations.current.maxLengthErrorText(0));
      });
      test('Should validate the input when it is expected to have maxLength 1',
          () {
        final Validator<List<int>> v = maxLength(1);
        final Validator<Object> v2 = maxLength(1);

        expect(v(<int>[]), isNull);
        expect(v(<int>[0]), isNull);
        expect(v2(<String>['0']), isNull);
        expect(v2(0), isNull);
        expect(v(<int>[1, 2]),
            FormBuilderLocalizations.current.maxLengthErrorText(1));
        expect(v2(<Object>[1, '3']),
            FormBuilderLocalizations.current.maxLengthErrorText(1));
      });
      test('Should validate the input when it is expected to have maxLength 4',
          () {
        final Validator<List<String>> v = maxLength(4);
        final Validator<String> v2 = maxLength(4);

        expect(v(<String>[]), isNull);
        expect(v(<String>['1']), isNull);
        expect(v(<String>['1', '2']), isNull);
        expect(v(<String>['1', '2', '3']), isNull);
        expect(v(<String>['1', '2', '3', '4']), isNull);

        expect(v2(''), isNull);
        expect(v2('1'), isNull);
        expect(v2('12'), isNull);
        expect(v2('123'), isNull);
        expect(v2('1234'), isNull);
      });
    });

    test('Should validate input returning custom message error when invalid',
        () {
      const String customMsg = 'custom msg';
      final Validator<Object> v = maxLength(3, maxLengthMsg: (_) => customMsg);

      expect(v('hey'), isNull);
      expect(v(<Object>[1, '2', 3, 4]), equals(customMsg));
    });
    test('Should throw AssertionError when maxLength is negative', () {
      expect(() => maxLength(-2), throwsAssertionError);
    });
  });
}
