import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Timezone -', () {
    test('should return null for valid timezone strings', () {
      // Arrange
      final TimeZoneValidator validator = TimeZoneValidator();

      // Act & Assert
      expect(validator.validate('UTC'), isNull);
      expect(validator.validate('GMT'), isNull);
      expect(validator.validate('EST'), isNull);
      expect(validator.validate('PST'), isNull);
    });

    test('should return the default error message for invalid timezone strings',
        () {
      // Arrange
      final TimeZoneValidator validator = TimeZoneValidator();

      // Act & Assert
      expect(
        validator.validate('Invalid/Timezone'),
        equals(FormBuilderLocalizations.current.timezoneErrorText),
      );
      expect(
        validator.validate('XYZ'),
        equals(FormBuilderLocalizations.current.timezoneErrorText),
      );
      expect(
        validator.validate(null),
        equals(FormBuilderLocalizations.current.timezoneErrorText),
      );
      expect(
        validator.validate(''),
        equals(FormBuilderLocalizations.current.timezoneErrorText),
      );
    });

    test('should return the custom error message for invalid timezone strings',
        () {
      // Arrange
      final TimeZoneValidator validator =
          TimeZoneValidator(errorText: customErrorMessage);

      // Act & Assert
      expect(
        validator.validate('Invalid/Timezone'),
        equals(customErrorMessage),
      );
      expect(validator.validate('XYZ'), equals(customErrorMessage));
      expect(validator.validate(null), equals(customErrorMessage));
      expect(validator.validate(''), equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final TimeZoneValidator validator =
          TimeZoneValidator(checkNullOrEmpty: false);
      const String value = '';

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      final TimeZoneValidator validator =
          TimeZoneValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });
  });
}
