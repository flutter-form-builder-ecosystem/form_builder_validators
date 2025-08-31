import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  group('Validator: equalLength', () {
    group('Validations with default error message', () {
      test(
        'Should validate the input when it is expected to have length 0',
        () {
          final Validator<List<int>> v = equalLength(0);
          final Validator<Object> v2 = equalLength(0);

          expect(v(<int>[]), isNull);
          expect(
            v2(<int>[12]),
            FormBuilderLocalizations.current.equalLengthErrorText(0),
          );
          expect(
            v2(<int>{12}),
            FormBuilderLocalizations.current.equalLengthErrorText(0),
          );
        },
      );

      test(
        'Should validate the input when it is expected to have length 1',
        () {
          final Validator<List<int>> v = equalLength(1);
          final Validator<Object> v2 = equalLength(1);

          expect(v(<int>[0]), isNull);
          expect(v2(<String>['0']), isNull);
          expect(v2('0'), isNull);
          expect(
            v(<int>[]),
            FormBuilderLocalizations.current.equalLengthErrorText(1),
          );
          expect(
            v2(<int>[]),
            FormBuilderLocalizations.current.equalLengthErrorText(1),
          );
          expect(
            v(<int>[1, 2]),
            FormBuilderLocalizations.current.equalLengthErrorText(1),
          );
          expect(
            v2(<Object>[1, '3']),
            FormBuilderLocalizations.current.equalLengthErrorText(1),
          );
        },
      );
      test(
        'Should validate the input when it is expected to have length 4',
        () {
          final Validator<List<String>> v = equalLength(4);
          final Validator<String> v2 = equalLength(4);

          expect(v(<String>['1', '2', '3', '4']), isNull);
          expect(
            v(<String>[]),
            FormBuilderLocalizations.current.equalLengthErrorText(4),
          );
          expect(
            v(<String>['2', '3', '4']),
            FormBuilderLocalizations.current.equalLengthErrorText(4),
          );

          expect(v2('1234'), isNull);
          expect(
            v2(''),
            FormBuilderLocalizations.current.equalLengthErrorText(4),
          );
          expect(
            v2('123'),
            FormBuilderLocalizations.current.equalLengthErrorText(4),
          );
        },
      );
    });

    test(
      'Should validate input returning custom message error when invalid',
      () {
        const String customMsg = 'custom msg';
        final Validator<Object> v = equalLength(
          3,
          equalLengthMsg: (_, _) => customMsg,
        );

        expect(v('hey'), isNull);
        expect(v(<Object>[1, '2', 3, 4]), equals(customMsg));
      },
    );
    test('Should throw ArgumentError when length is negative', () {
      expect(() => equalLength(-2), throwsArgumentError);
    });
    test('Should throw ArgumentError when input is not a collection', () {
      expect(
        () => equalLength(2)(() => 'I am a function'),
        throwsArgumentError,
      );
    });
  });
}
