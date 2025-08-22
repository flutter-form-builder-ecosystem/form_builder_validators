import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> streetWhitelist = <String>[
    '123 Main St',
    'Elm Street',
    '456 Oak Ave',
  ];
  final List<String> streetBlacklist = <String>['Fake Street', 'NoName Ave'];

  group('StreetValidator -', () {
    test('should return null for valid street strings', () {
      // Arrange
      final StreetValidator validator = StreetValidator(
        streetWhitelist: streetWhitelist,
      );

      // Act & Assert
      expect(validator.validate('123 Main St'), isNull);
      expect(validator.validate('Elm Street'), isNull);
    });

    test(
      'should return the default error message for invalid street strings',
      () {
        // Arrange
        final StreetValidator validator = StreetValidator(
          streetWhitelist: streetWhitelist,
        );

        // Act & Assert
        expect(
          validator.validate('1234 main st'),
          equals(FormBuilderLocalizations.current.streetErrorText),
        );
        expect(
          validator.validate('InvalidStreetName!'),
          equals(FormBuilderLocalizations.current.streetErrorText),
        );
      },
    );

    test(
      'should return the custom error message for invalid street strings',
      () {
        // Arrange
        final StreetValidator validator = StreetValidator(
          streetWhitelist: streetWhitelist,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(
          validator.validate('invalidstreetname'),
          equals(customErrorMessage),
        );
        expect(validator.validate('12345!'), equals(customErrorMessage));
      },
    );

    test(
      'should return the default error message for blacklisted street strings',
      () {
        // Arrange
        final StreetValidator validator = StreetValidator(
          streetWhitelist: streetWhitelist,
          streetBlacklist: streetBlacklist,
        );

        // Act & Assert
        expect(
          validator.validate('Fake Street'),
          equals(FormBuilderLocalizations.current.streetErrorText),
        );
      },
    );

    test(
      'should return the custom error message for blacklisted street strings',
      () {
        // Arrange
        final StreetValidator validator = StreetValidator(
          streetWhitelist: streetWhitelist,
          streetBlacklist: streetBlacklist,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(validator.validate('NoName Ave'), equals(customErrorMessage));
      },
    );

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        final StreetValidator validator = StreetValidator(
          streetWhitelist: streetWhitelist,
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
        final StreetValidator validator = StreetValidator(
          streetWhitelist: streetWhitelist,
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
