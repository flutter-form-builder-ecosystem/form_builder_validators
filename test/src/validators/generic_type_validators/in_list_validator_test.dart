import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  group('Validator: isInList', () {
    group('Validations with default error message', () {
      test('Should return null when int 0 is provided', () {
        final Validator<int> validator = inList(<int>[0]);

        expect(validator(0), isNull);
        expect(
          validator(2),
          equals(FormBuilderLocalizations.current.containsElementErrorText),
        );
      });
      test('Should return null when int 0 or String "2" is provided', () {
        final Validator<Object> validator = inList(<Object>[0, '2']);

        expect(validator(0), isNull);
        expect(validator('2'), isNull);
        expect(
          validator(2),
          equals(FormBuilderLocalizations.current.containsElementErrorText),
        );
      });
      test('Should return null when int 0, int 2, or null is provided', () {
        final Validator<Object?> validator = inList(<Object?>[0, 2, null]);

        expect(validator(0), isNull);
        expect(validator(2), isNull);
        expect(validator(null), isNull);
        expect(
          validator('2'),
          equals(FormBuilderLocalizations.current.containsElementErrorText),
        );
      });
    });

    test('Should throw ArgumentError when list input is empty', () {
      expect(() => inList(<Object>[]), throwsArgumentError);
    });

    test(
      'Should return custom error message when invalid input is provided',
      () {
        const String customMessage = 'custom message';
        final Validator<int> validator = inList(<int>[
          1,
          2,
          3,
        ], inListMsg: (_, _) => customMessage);

        expect(validator(4), equals(customMessage));
      },
    );

    test('should remain immutable when input elements change', () {
      final List<Object> elements = <Object>[12, 15, 'hi'];

      final Validator<Object> v = inList(elements);

      expect(v(12), isNull);
      expect(v(15), isNull);
      expect(v('hi'), isNull);
      expect(
        v(12.02),
        FormBuilderLocalizations.current.containsElementErrorText,
      );
      expect(v(2), FormBuilderLocalizations.current.containsElementErrorText);
      expect(
        v(true),
        FormBuilderLocalizations.current.containsElementErrorText,
      );

      elements.removeLast();
      expect(v(12), isNull);
      expect(v(15), isNull);
      expect(v('hi'), isNull);
      expect(
        v(12.02),
        FormBuilderLocalizations.current.containsElementErrorText,
      );
      expect(v(2), FormBuilderLocalizations.current.containsElementErrorText);
      expect(
        v(true),
        FormBuilderLocalizations.current.containsElementErrorText,
      );

      elements.add(true);
      expect(v(12), isNull);
      expect(v(15), isNull);
      expect(v('hi'), isNull);
      expect(
        v(12.02),
        FormBuilderLocalizations.current.containsElementErrorText,
      );
      expect(v(2), FormBuilderLocalizations.current.containsElementErrorText);
      expect(
        v(true),
        FormBuilderLocalizations.current.containsElementErrorText,
      );
    });
  });
}
