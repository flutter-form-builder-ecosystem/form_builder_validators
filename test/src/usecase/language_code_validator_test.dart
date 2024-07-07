import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> languageCodeWhitelist = <String>[
    'en',
    'fr',
    'es',
    'de',
    'it',
  ];
  final List<String> languageCodeBlacklist = <String>['xx', 'yy'];

  group('LanguageCodeValidator -', () {
    test('should return null for valid language code strings', () {
      // Arrange
      final LanguageCodeValidator validator =
          LanguageCodeValidator(languageCodeWhitelist: languageCodeWhitelist);

      // Act & Assert
      expect(validator.validate('en'), isNull);
      expect(validator.validate('fr'), isNull);
      expect(validator.validate('es'), isNull);
    });

    test(
        'should return the default error message for invalid language code strings',
        () {
      // Arrange
      final LanguageCodeValidator validator =
          LanguageCodeValidator(languageCodeWhitelist: languageCodeWhitelist);

      // Act & Assert
      expect(
        validator.validate('english'),
        equals(FormBuilderLocalizations.current.languageCodeErrorText),
      );
      expect(
        validator.validate('EN'),
        equals(FormBuilderLocalizations.current.languageCodeErrorText),
      );
      expect(
        validator.validate('123'),
        equals(validator.errorText),
      );
    });

    test(
        'should return the custom error message for invalid language code strings',
        () {
      // Arrange
      final LanguageCodeValidator validator = LanguageCodeValidator(
        languageCodeWhitelist: languageCodeWhitelist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('english'), equals(customErrorMessage));
      expect(validator.validate('EN'), equals(customErrorMessage));
      expect(validator.validate('123'), equals(customErrorMessage));
    });

    test(
        'should return the default error message for blacklisted language code strings',
        () {
      // Arrange
      final LanguageCodeValidator validator = LanguageCodeValidator(
        languageCodeWhitelist: languageCodeWhitelist,
        languageCodeBlacklist: languageCodeBlacklist,
      );

      // Act & Assert
      expect(
        validator.validate('xx'),
        equals(FormBuilderLocalizations.current.languageCodeErrorText),
      );
      expect(
        validator.validate('yy'),
        equals(FormBuilderLocalizations.current.languageCodeErrorText),
      );
    });

    test(
        'should return the custom error message for blacklisted language code strings',
        () {
      // Arrange
      final LanguageCodeValidator validator = LanguageCodeValidator(
        languageCodeWhitelist: languageCodeWhitelist,
        languageCodeBlacklist: languageCodeBlacklist,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('xx'), equals(customErrorMessage));
      expect(validator.validate('yy'), equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final LanguageCodeValidator validator = LanguageCodeValidator(
        languageCodeWhitelist: languageCodeWhitelist,
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
      final LanguageCodeValidator validator = LanguageCodeValidator(
        languageCodeWhitelist: languageCodeWhitelist,
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });
  });
}
