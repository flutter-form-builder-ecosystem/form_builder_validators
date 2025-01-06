import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  group('Validator: containsElement', () {
    group('Validations with default error message', () {
      test('Should return null when int 0 is provided', () {
        final Validator<int> validator = containsElement(<int>[0]);

        expect(validator(0), isNull);
        expect(validator(2),
            equals(FormBuilderLocalizations.current.containsElementErrorText));
      });
      test('Should return null when int 0 or String "2" is provided', () {
        final Validator<Object> validator = containsElement(<Object>[0, '2']);

        expect(validator(0), isNull);
        expect(validator('2'), isNull);
        expect(validator(2),
            equals(FormBuilderLocalizations.current.containsElementErrorText));
      });
      test('Should return null when int 0, int 2, or null is provided', () {
        final Validator<Object?> validator =
            containsElement(<Object?>[0, 2, null]);

        expect(validator(0), isNull);
        expect(validator(2), isNull);
        expect(validator(null), isNull);
        expect(validator('2'),
            equals(FormBuilderLocalizations.current.containsElementErrorText));
      });
    });

    test('Should throw assertionError when list input is empty', () {
      expect(() => containsElement(<Object>[]), throwsAssertionError);
    });

    test('Should return custom error message when invalid input is provided',
        () {
      const String customMessage = 'custom message';
      final Validator<int> validator = containsElement(<int>[1, 2, 3],
          containsElementMsg: (_, __) => customMessage);

      expect(validator(4), equals(customMessage));
    });
  });
}
