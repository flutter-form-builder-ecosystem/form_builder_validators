import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> licensePlateWhitelist = <String>[
    'ABC123',
    '123ABC',
    'XYZ-7890',
  ];
  final List<String> licensePlateBlacklist = <String>['INVALID1', 'BAD-PLATE'];

  group('LicensePlateValidator -', () {
    test('should return null for valid license plate strings', () {
      // Arrange
      final LicensePlateValidator validator =
          LicensePlateValidator(licensePlateWhitelist: licensePlateWhitelist);

      // Act & Assert
      expect(validator.validate('ABC123'), isNull);
      expect(validator.validate('123ABC'), isNull);
      expect(validator.validate('XYZ-7890'), isNull);
    });

    test(
        'should return the default error message for invalid license plate strings',
        () {
      // Arrange
      final LicensePlateValidator validator =
          LicensePlateValidator(licensePlateWhitelist: licensePlateWhitelist);

      // Act & Assert
      expect(
        validator.validate('1234#567'),
        equals(FormBuilderLocalizations.current.licensePlateErrorText),
      );
      expect(
        validator.validate('INVALID PLATE'),
        equals(FormBuilderLocalizations.current.licensePlateErrorText),
      );
    });

    test(
        'should return the custom error message for invalid license plate strings',
        () {
      // Arrange
      final LicensePlateValidator validator = LicensePlateValidator(
        licensePlateWhitelist: licensePlateWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('1234#567'), equals(customErrorMessage));
      expect(validator.validate('INVALID PLATE'), equals(customErrorMessage));
    });

    test(
        'should return the default error message for blacklisted license plate strings',
        () {
      // Arrange
      final LicensePlateValidator validator = LicensePlateValidator(
        licensePlateWhitelist: licensePlateWhitelist,
        licensePlateBlacklist: licensePlateBlacklist,
      );

      // Act & Assert
      expect(
        validator.validate('INVALID1'),
        equals(FormBuilderLocalizations.current.licensePlateErrorText),
      );
      expect(
        validator.validate('BAD-PLATE'),
        equals(FormBuilderLocalizations.current.licensePlateErrorText),
      );
    });

    test(
        'should return the custom error message for blacklisted license plate strings',
        () {
      // Arrange
      final LicensePlateValidator validator = LicensePlateValidator(
        licensePlateWhitelist: licensePlateWhitelist,
        licensePlateBlacklist: licensePlateBlacklist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('INVALID1'), equals(customErrorMessage));
      expect(validator.validate('BAD-PLATE'), equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final LicensePlateValidator validator = LicensePlateValidator(
        licensePlateWhitelist: licensePlateWhitelist,
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
      final LicensePlateValidator validator = LicensePlateValidator(
        licensePlateWhitelist: licensePlateWhitelist,
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });
  });
}
