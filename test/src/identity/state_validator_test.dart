import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> stateWhitelist = <String>[
    'California',
    'New York',
    'Texas',
    'Florida',
    'Illinois',
  ];
  final List<String> stateBlacklist = <String>['BadState', 'InvalidState'];

  group('StateValidator -', () {
    test('should return null for valid state strings', () {
      // Arrange
      final StateValidator validator =
          StateValidator(stateWhitelist: stateWhitelist);

      // Act & Assert
      expect(validator.validate('California'), isNull);
      expect(validator.validate('New York'), isNull);
    });

    test('should return the default error message for invalid state strings',
        () {
      // Arrange
      final StateValidator validator =
          StateValidator(stateWhitelist: stateWhitelist);

      // Act & Assert
      expect(
        validator.validate('california'),
        equals(FormBuilderLocalizations.current.stateErrorText),
      );
      expect(
        validator.validate('InvalidState123'),
        equals(FormBuilderLocalizations.current.stateErrorText),
      );
    });

    test('should return the custom error message for invalid state strings',
        () {
      // Arrange
      final StateValidator validator = StateValidator(
        stateWhitelist: stateWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('invalidstate'), equals(customErrorMessage));
      expect(validator.validate('12345'), equals(customErrorMessage));
    });

    test(
        'should return the default error message for blacklisted state strings',
        () {
      // Arrange
      final StateValidator validator = StateValidator(
        stateWhitelist: stateWhitelist,
        stateBlacklist: stateBlacklist,
      );

      // Act & Assert
      expect(
        validator.validate('BadState'),
        equals(FormBuilderLocalizations.current.stateErrorText),
      );
    });

    test('should return the custom error message for blacklisted state strings',
        () {
      // Arrange
      final StateValidator validator = StateValidator(
        stateWhitelist: stateWhitelist,
        stateBlacklist: stateBlacklist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('InvalidState'), equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final StateValidator validator = StateValidator(
        stateWhitelist: stateWhitelist,
        checkNullOrEmpty: false,
      );
      const String value = '';

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      final StateValidator validator = StateValidator(
        stateWhitelist: stateWhitelist,
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });
  });
}
