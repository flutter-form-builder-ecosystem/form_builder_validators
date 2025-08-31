import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  group('Validator: notInList', () {
    group('Validations with default error message', () {
      test('Should return null when int 0 is provided', () {
        final Validator<int> validator = notInList(<int>[2]);

        expect(validator(0), isNull);
        expect(
          validator(2),
          equals(
            FormBuilderLocalizations.current.doesNotContainElementErrorText,
          ),
        );
      });
      test('Should return null when int 0 or String "2" is provided', () {
        final Validator<Object> validator = notInList(<Object>['0', 2]);

        expect(validator(0), isNull);
        expect(validator('2'), isNull);
        expect(
          validator(2),
          equals(
            FormBuilderLocalizations.current.doesNotContainElementErrorText,
          ),
        );
      });
      test('Should return null when int 0, int 2, or null is provided', () {
        final Validator<Object?> validator = notInList(<Object?>['0', '2']);

        expect(validator(0), isNull);
        expect(validator(2), isNull);
        expect(validator(null), isNull);
        expect(
          validator('2'),
          equals(
            FormBuilderLocalizations.current.doesNotContainElementErrorText,
          ),
        );
      });
    });

    test('Should throw ArgumentError when list input is empty', () {
      expect(() => notInList(<Object>[]), throwsArgumentError);
    });

    test(
      'Should return custom error message when invalid input is provided',
      () {
        const String customMessage = 'custom message';
        final Validator<int> validator = notInList(<int>[
          1,
          2,
          3,
        ], notInListMsg: (_, _) => customMessage);

        expect(validator(1), equals(customMessage));
      },
    );

    test('should remain immutable when input elements change', () {
      final List<Object> elements = <Object>[12.02, 2, true];

      final Validator<Object> v = notInList(elements);

      expect(v(12), isNull);
      expect(v(15), isNull);
      expect(v('hi'), isNull);
      expect(
        v(12.02),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );
      expect(
        v(2),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );
      expect(
        v(true),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );

      elements.removeLast();
      expect(v(12), isNull);
      expect(v(15), isNull);
      expect(v('hi'), isNull);
      expect(
        v(12.02),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );
      expect(
        v(2),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );
      expect(
        v(true),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );

      elements.add(true);
      expect(v(12), isNull);
      expect(v(15), isNull);
      expect(v('hi'), isNull);
      expect(
        v(12.02),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );
      expect(
        v(2),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );
      expect(
        v(true),
        FormBuilderLocalizations.current.doesNotContainElementErrorText,
      );
    });
  });
}
