import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('DUNSValidator -', () {
    test('should return null for valid DUNS number strings', () {
      // Arrange
      final DunsValidator validator = DunsValidator();

      // Act & Assert
      expect(validator.validate('123456789'), isNull);
      expect(validator.validate('987654321'), isNull);
    });

    test(
      'should return the default error message for invalid DUNS number strings',
      () {
        // Arrange
        final DunsValidator validator = DunsValidator();

        // Act & Assert
        expect(
          validator.validate('12345678'),
          equals(FormBuilderLocalizations.current.dunsErrorText),
        );
        expect(
          validator.validate('1234567890'),
          equals(FormBuilderLocalizations.current.dunsErrorText),
        );
        expect(
          validator.validate('12345678A'),
          equals(FormBuilderLocalizations.current.dunsErrorText),
        );
      },
    );

    test(
      'should return the custom error message for invalid DUNS number strings',
      () {
        // Arrange
        final DunsValidator validator = DunsValidator(
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(validator.validate('12345678'), equals(customErrorMessage));
        expect(validator.validate('1234567890'), equals(customErrorMessage));
        expect(validator.validate('12345678A'), equals(customErrorMessage));
      },
    );

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        final DunsValidator validator = DunsValidator(checkNullOrEmpty: false);
        const String value = '';

        // Act & Assert
        final String? result = validator.validate(value);
        expect(result, isNull);
      },
    );

    test(
      'should return null when the value is null and null check is disabled',
      () {
        // Arrange
        final DunsValidator validator = DunsValidator(checkNullOrEmpty: false);
        const String? value = null;

        // Act & Assert
        final String? result = validator.validate(value);
        expect(result, isNull);
      },
    );
  });
}
