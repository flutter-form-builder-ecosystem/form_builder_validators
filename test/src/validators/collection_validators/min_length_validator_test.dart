import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  group('Validator: minLength', () {
    group('Validators with default error message', () {
      test('Should validate the input when it is expected to have minLength 0',
          () {
        final Validator<List<int>> v = minLength(0);
        final Validator<Object> v2 = minLength(0);

        expect(v(<int>[]), isNull);
        expect(v2(<int>[12]), isNull);
      });
      test('Should validate the input when it is expected to have minLength 1',
          () {
        final Validator<List<int>> v = minLength(1);
        final Validator<Object> v2 = minLength(1);

        expect(
            v(<int>[]), FormBuilderLocalizations.current.minLengthErrorText(1));
        expect(v(<int>[0]), isNull);
        expect(v(<int>[1, 2]), isNull);

        expect(v2(<String>[]),
            FormBuilderLocalizations.current.minLengthErrorText(1));
        expect(v2(<String>['0']), isNull);
        expect(v2(<Object>[1, '3']), isNull);
      });
      test('Should validate the input when it is expected to have minLength 4',
          () {
        final Validator<List<String>> v = minLength(4);
        final Validator<String> v2 = minLength(4);

        expect(v(<String>[]),
            FormBuilderLocalizations.current.minLengthErrorText(4));
        expect(v(<String>['1']),
            FormBuilderLocalizations.current.minLengthErrorText(4));
        expect(v(<String>['1', '2']),
            FormBuilderLocalizations.current.minLengthErrorText(4));
        expect(v(<String>['1', '2', '3']),
            FormBuilderLocalizations.current.minLengthErrorText(4));
        expect(v(<String>['1', '2', '3', '4']), isNull);
        expect(v(<String>['1', '2', '3', '4', '5']), isNull);
        expect(v(<String>['1', '2', '3', '4', '5', '6']), isNull);

        expect(v2(''), FormBuilderLocalizations.current.minLengthErrorText(4));
        expect(v2('1'), FormBuilderLocalizations.current.minLengthErrorText(4));
        expect(
            v2('12'), FormBuilderLocalizations.current.minLengthErrorText(4));
        expect(
            v2('123'), FormBuilderLocalizations.current.minLengthErrorText(4));
        expect(v2('1234'), isNull);
        expect(v2('12345'), isNull);
        expect(v2('123456'), isNull);
      });
    });

    test('Should validate input returning custom message error when invalid',
        () {
      const String customMsg = 'custom msg';
      final Validator<Object> v =
          minLength(3, minLengthMsg: (_, __) => customMsg);

      expect(v(<int, String>{1: '1', 2: '2'}), equals(customMsg));
      expect(v(<Object>[1, '2', 3, 4]), isNull);
    });
    test('Should throw ArgumentError when minLength is negative', () {
      expect(() => minLength(-2), throwsArgumentError);
    });
    test('Should throw ArgumentError when input is not collection', () {
      expect(() => minLength(2)(12.3), throwsArgumentError);
    });
  });
}
