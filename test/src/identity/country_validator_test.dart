import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> validCountries = <String>[
    'United States',
    'Canada',
    'Mexico',
    'Brazil',
    'Argentina',
  ];
  final List<String> blacklistedCountries = <String>['North Korea', 'Iran'];

  group('CountryValidator -', () {
    test('should return null for valid country strings', () {
      // Arrange
      final CountryValidator validator = CountryValidator(
        countryWhitelist: validCountries,
      );

      // Act & Assert
      expect(validator.validate('United States'), isNull);
      expect(validator.validate('Canada'), isNull);
    });

    test(
      'should return the default error message for invalid country strings',
      () {
        // Arrange
        final CountryValidator validator = CountryValidator(
          countryWhitelist: validCountries,
        );

        // Act & Assert
        expect(
          validator.validate('InvalidCountry'),
          equals(FormBuilderLocalizations.current.countryErrorText),
        );
      },
    );

    test(
      'should return the custom error message for invalid country strings',
      () {
        // Arrange
        final CountryValidator validator = CountryValidator(
          countryWhitelist: validCountries,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(
          validator.validate('InvalidCountry'),
          equals(customErrorMessage),
        );
      },
    );

    test(
      'should return the default error message for blacklisted country strings',
      () {
        // Arrange
        final CountryValidator validator = CountryValidator(
          countryWhitelist: validCountries,
          countryBlacklist: blacklistedCountries,
        );

        // Act & Assert
        expect(
          validator.validate('North Korea'),
          equals(FormBuilderLocalizations.current.countryErrorText),
        );
      },
    );

    test(
      'should return the custom error message for blacklisted country strings',
      () {
        // Arrange
        final CountryValidator validator = CountryValidator(
          countryWhitelist: validCountries,
          countryBlacklist: blacklistedCountries,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(validator.validate('Iran'), equals(customErrorMessage));
      },
    );

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        final CountryValidator validator = CountryValidator(
          countryWhitelist: validCountries,
          checkNullOrEmpty: false,
        );
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
        final CountryValidator validator = CountryValidator(
          countryWhitelist: validCountries,
          checkNullOrEmpty: false,
        );
        const String? value = null;

        // Act & Assert
        final String? result = validator.validate(value);
        expect(result, isNull);
      },
    );

    test(
      'should return null when both the value is in the validCountries and blacklistedCountries list',
      () {
        // Arrange
        final List<String> conflictingCountryList = <String>[
          'Country1',
          'Country2',
        ];
        final CountryValidator validator = CountryValidator(
          countryWhitelist: conflictingCountryList,
          countryBlacklist: conflictingCountryList,
        );

        // Act & Assert
        for (final String country in conflictingCountryList) {
          final String? result = validator.validate(country);
          expect(result, FormBuilderLocalizations.current.countryErrorText);
        }
      },
    );

    test('should return null when no arguments are set in the constructor', () {
      // Arrange
      final CountryValidator validator = CountryValidator();

      // Act & Assert
      expect(validator.validate('United States'), isNull);
      expect(validator.validate('Canada'), isNull);
      expect(validator.validate('InvalidCountry'), isNull);
    });
  });
}
