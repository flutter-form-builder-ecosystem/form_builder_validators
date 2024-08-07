import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> lastNameWhitelist = <String>[
    'Smith',
    'Johnson',
    'Brown',
    'Taylor',
    'Anderson',
  ];
  final List<String> lastNameBlacklist = <String>['BadLastName', 'NoLastName'];

  group('LastNameValidator -', () {
    test('should return null for valid last name strings', () {
      // Arrange
      final LastNameValidator validator =
          LastNameValidator(lastNameWhitelist: lastNameWhitelist);

      // Act & Assert
      expect(validator.validate('Smith'), isNull);
      expect(validator.validate('Johnson'), isNull);
    });

    test(
        'should return the default error message for invalid last name strings',
        () {
      // Arrange
      final LastNameValidator validator =
          LastNameValidator(lastNameWhitelist: lastNameWhitelist);

      // Act & Assert
      expect(
        validator.validate('smith'),
        equals(FormBuilderLocalizations.current.lastNameErrorText),
      );
      expect(
        validator.validate('InvalidLastName123'),
        equals(FormBuilderLocalizations.current.lastNameErrorText),
      );
    });

    test('should return the custom error message for invalid last name strings',
        () {
      // Arrange
      final LastNameValidator validator = LastNameValidator(
        lastNameWhitelist: lastNameWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('invalidlastname'), equals(customErrorMessage));
      expect(validator.validate('123'), equals(customErrorMessage));
    });

    test(
        'should return the default error message for blacklisted last name strings',
        () {
      // Arrange
      final LastNameValidator validator = LastNameValidator(
        lastNameWhitelist: lastNameWhitelist,
        lastNameBlacklist: lastNameBlacklist,
      );

      // Act & Assert
      expect(
        validator.validate('BadLastName'),
        equals(FormBuilderLocalizations.current.lastNameErrorText),
      );
    });

    test(
        'should return the custom error message for blacklisted last name strings',
        () {
      // Arrange
      final LastNameValidator validator = LastNameValidator(
        lastNameWhitelist: lastNameWhitelist,
        lastNameBlacklist: lastNameBlacklist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('NoLastName'), equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final LastNameValidator validator = LastNameValidator(
        lastNameWhitelist: lastNameWhitelist,
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
      final LastNameValidator validator = LastNameValidator(
        lastNameWhitelist: lastNameWhitelist,
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });

    test('should return the default error message for non-whitelisted name',
        () {
      // Arrange
      final LastNameValidator validator = LastNameValidator(
        lastNameWhitelist: lastNameWhitelist,
      );

      // Act & Assert
      expect(
        validator.validate('NonWhitelistedName'),
        equals(FormBuilderLocalizations.current.lastNameErrorText),
      );
    });

    test('should return the custom error message for non-whitelisted name', () {
      // Arrange
      final LastNameValidator validator = LastNameValidator(
        lastNameWhitelist: lastNameWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(
        validator.validate('NonWhitelistedName'),
        equals(customErrorMessage),
      );
    });
  });
}
