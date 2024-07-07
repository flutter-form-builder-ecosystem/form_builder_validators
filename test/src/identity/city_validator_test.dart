import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> citiesWhitelist = <String>[
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
  ];
  final List<String> citiesBlacklist = <String>['Gotham', 'Metropolis'];

  group('City -', () {
    test('should return null for valid city strings', () {
      // Arrange
      final CityValidator validator =
          CityValidator(citiesWhitelist: citiesWhitelist);

      // Act & Assert
      expect(validator.validate('New York'), isNull);
      expect(validator.validate('Los Angeles'), isNull);
    });

    test('should return the default error message for invalid city strings',
        () {
      // Arrange
      final CityValidator validator =
          CityValidator(citiesWhitelist: citiesWhitelist);

      // Act & Assert
      expect(
        validator.validate('InvalidCity'),
        equals(FormBuilderLocalizations.current.cityErrorText),
      );
    });

    test('should return the custom error message for invalid city strings', () {
      // Arrange
      final CityValidator validator = CityValidator(
        citiesWhitelist: citiesWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('InvalidCity'), equals(customErrorMessage));
    });

    test('should return the default error message for blacklisted city strings',
        () {
      // Arrange
      final CityValidator validator = CityValidator(
        citiesWhitelist: citiesWhitelist,
        citiesBlacklist: citiesBlacklist,
      );

      // Act & Assert
      expect(
        validator.validate('Gotham'),
        equals(FormBuilderLocalizations.current.cityErrorText),
      );
    });

    test('should return the custom error message for blacklisted city strings',
        () {
      // Arrange
      final CityValidator validator = CityValidator(
        citiesWhitelist: citiesWhitelist,
        citiesBlacklist: citiesBlacklist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('Metropolis'), equals(customErrorMessage));
    });

    test('should return null for valid city strings matching the regex', () {
      // Arrange
      final CityValidator validator = CityValidator(
        citiesWhitelist: citiesWhitelist,
      );

      // Act & Assert
      expect(validator.validate('New York'), isNull);
      expect(validator.validate('Los Angeles'), isNull);
    });

    test(
        'should return the default error message for invalid city strings not matching the regex',
        () {
      // Arrange
      final CityValidator validator = CityValidator(
        citiesWhitelist: citiesWhitelist,
      );

      // Act & Assert
      expect(
        validator.validate('new york'),
        equals(FormBuilderLocalizations.current.cityErrorText),
      );
    });

    test(
        'should return the custom error message for invalid city strings not matching the regex',
        () {
      // Arrange
      final CityValidator validator = CityValidator(
        citiesWhitelist: citiesWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('new york'), equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final CityValidator validator = CityValidator(
        citiesWhitelist: citiesWhitelist,
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
      final CityValidator validator = CityValidator(
        citiesWhitelist: citiesWhitelist,
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });
  });
}
