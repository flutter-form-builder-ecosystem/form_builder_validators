import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> vinWhitelist = <String>[
    '1HGCM82633A123456',
    'JH4KA8260MC000000',
    '1FTFW1EF1EFB12345',
  ];
  final List<String> vinBlacklist = <String>[
    '1HGCM82633A111111',
    'JH4KA8260MC222222',
  ];

  group('VinValidator -', () {
    test('should return null for valid VIN strings', () {
      // Arrange
      final VinValidator validator = VinValidator(vinWhitelist: vinWhitelist);

      // Act & Assert
      expect(validator.validate('1HGCM82633A123456'), isNull);
      expect(validator.validate('JH4KA8260MC000000'), isNull);
      expect(validator.validate('1FTFW1EF1EFB12345'), isNull);
    });

    test('should return the default error message for invalid VIN strings', () {
      // Arrange
      final VinValidator validator = VinValidator(vinWhitelist: vinWhitelist);

      // Act & Assert
      expect(
        validator.validate('1HGCM82633A12345'), // less than 17 characters
        equals(FormBuilderLocalizations.current.vinErrorText),
      );
      expect(
        validator.validate('JH4KA8260MC0000000'), // more than 17 characters
        equals(FormBuilderLocalizations.current.vinErrorText),
      );
      expect(
        validator.validate('1HGCM82633A1O3456'), // contains invalid character O
        equals(FormBuilderLocalizations.current.vinErrorText),
      );
      expect(
        validator.validate('1HGCM82633A123453'), // contains invalid character O
        equals(validator.errorText),
      );
    });

    test('should return the custom error message for invalid VIN strings', () {
      // Arrange
      final VinValidator validator = VinValidator(
        vinWhitelist: vinWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(
        validator.validate('1HGCM82633A12345'),
        equals(customErrorMessage),
      );
      expect(
        validator.validate('JH4KA8260MC0000000'),
        equals(customErrorMessage),
      );
      expect(
        validator.validate('1HGCM82633A1O3456'),
        equals(customErrorMessage),
      );
    });

    test(
      'should return the default error message for blacklisted VIN strings',
      () {
        // Arrange
        final VinValidator validator = VinValidator(
          vinWhitelist: vinWhitelist,
          vinBlacklist: vinBlacklist,
        );

        // Act & Assert
        expect(
          validator.validate('1HGCM82633A111111'),
          equals(FormBuilderLocalizations.current.vinErrorText),
        );
        expect(
          validator.validate('JH4KA8260MC222222'),
          equals(FormBuilderLocalizations.current.vinErrorText),
        );
      },
    );

    test(
      'should return the custom error message for blacklisted VIN strings',
      () {
        // Arrange
        final VinValidator validator = VinValidator(
          vinWhitelist: vinWhitelist,
          vinBlacklist: vinBlacklist,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(
          validator.validate('1HGCM82633A111111'),
          equals(customErrorMessage),
        );
        expect(
          validator.validate('JH4KA8260MC222222'),
          equals(customErrorMessage),
        );
      },
    );

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        final VinValidator validator = VinValidator(
          vinWhitelist: vinWhitelist,
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
        final VinValidator validator = VinValidator(
          vinWhitelist: vinWhitelist,
          checkNullOrEmpty: false,
        );
        const String? value = null;

        // Act & Assert
        final String? result = validator.validate(value);
        expect(result, isNull);
      },
    );
  });
}
