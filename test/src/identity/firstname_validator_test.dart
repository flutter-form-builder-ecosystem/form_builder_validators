import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> firstNameWhitelist = <String>[
    'John',
    'Alice',
    'Bob',
    'Carol',
    'David',
  ];
  final List<String> firstNameBlacklist = <String>['BadName', 'NoName'];

  group('FirstNameValidator -', () {
    test('should return null for valid first name strings', () {
      // Arrange
      final FirstNameValidator validator =
          FirstNameValidator(firstNameWhitelist: firstNameWhitelist);

      // Act & Assert
      expect(validator.validate('John'), isNull);
      expect(validator.validate('Alice'), isNull);
    });

    test(
        'should return the default error message for invalid first name strings',
        () {
      // Arrange
      final FirstNameValidator validator =
          FirstNameValidator(firstNameWhitelist: firstNameWhitelist);

      // Act & Assert
      expect(
        validator.validate('john'),
        equals(FormBuilderLocalizations.current.firstNameErrorText),
      );
      expect(
        validator.validate('InvalidName123'),
        equals(FormBuilderLocalizations.current.firstNameErrorText),
      );
    });

    test(
        'should return the custom error message for invalid first name strings',
        () {
      // Arrange
      final FirstNameValidator validator = FirstNameValidator(
        firstNameWhitelist: firstNameWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('invalidname'), equals(customErrorMessage));
      expect(validator.validate('123'), equals(customErrorMessage));
    });

    test(
        'should return the default error message for blacklisted first name strings',
        () {
      // Arrange
      final FirstNameValidator validator = FirstNameValidator(
        firstNameWhitelist: firstNameWhitelist,
        firstNameBlacklist: firstNameBlacklist,
      );

      // Act & Assert
      expect(
        validator.validate('BadName'),
        equals(FormBuilderLocalizations.current.firstNameErrorText),
      );
    });

    test(
        'should return the custom error message for blacklisted first name strings',
        () {
      // Arrange
      final FirstNameValidator validator = FirstNameValidator(
        firstNameWhitelist: firstNameWhitelist,
        firstNameBlacklist: firstNameBlacklist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('NoName'), equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final FirstNameValidator validator = FirstNameValidator(
        firstNameWhitelist: firstNameWhitelist,
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
      final FirstNameValidator validator = FirstNameValidator(
        firstNameWhitelist: firstNameWhitelist,
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });
  });
}
