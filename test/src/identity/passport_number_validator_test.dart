import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  final List<String> passportNumberWhitelist = <String>[
    'A1234567',
    '123456789',
    'AB123456',
  ];
  final List<String> passportNumberBlacklist = <String>['BAD123', 'INVALID456'];

  group('PassportNumberValidator -', () {
    test('should return null for valid passport number strings', () {
      // Arrange
      final PassportNumberValidator validator = PassportNumberValidator(
        passportNumberWhitelist: passportNumberWhitelist,
      );

      // Act & Assert
      expect(validator.validate('A1234567'), isNull);
      expect(validator.validate('123456789'), isNull);
      expect(validator.validate('AB123456'), isNull);
    });

    test(
      'should return the default error message for invalid passport number strings',
      () {
        // Arrange
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
        );

        // Act & Assert
        expect(
          validator.validate('12345'),
          equals(FormBuilderLocalizations.current.passportNumberErrorText),
        );
        expect(
          validator.validate('Invalid12345!'),
          equals(FormBuilderLocalizations.current.passportNumberErrorText),
        );
      },
    );

    test(
      'should return the custom error message for invalid passport number strings',
      () {
        // Arrange
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(validator.validate('InvalidNumber'), equals(customErrorMessage));
        expect(validator.validate('12345!'), equals(customErrorMessage));
      },
    );

    test(
      'should return the default error message for blacklisted passport number strings',
      () {
        // Arrange
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
          passportNumberBlacklist: passportNumberBlacklist,
        );

        // Act & Assert
        expect(
          validator.validate('BAD123'),
          equals(FormBuilderLocalizations.current.passportNumberErrorText),
        );
        expect(
          validator.validate('INVALID456'),
          equals(FormBuilderLocalizations.current.passportNumberErrorText),
        );
      },
    );

    test(
      'should return the custom error message for blacklisted passport number strings',
      () {
        // Arrange
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
          passportNumberBlacklist: passportNumberBlacklist,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(validator.validate('BAD123'), equals(customErrorMessage));
        expect(validator.validate('INVALID456'), equals(customErrorMessage));
      },
    );

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
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
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
          checkNullOrEmpty: false,
        );
        const String? value = null;

        // Act & Assert
        final String? result = validator.validate(value);
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message for non-whitelisted passport number',
      () {
        // Arrange
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
        );

        // Act & Assert
        expect(
          validator.validate('NonWhitelisted123'),
          equals(FormBuilderLocalizations.current.passportNumberErrorText),
        );
      },
    );

    test(
      'should return the custom error message for non-whitelisted passport number',
      () {
        // Arrange
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(
          validator.validate('NonWhitelisted123'),
          equals(customErrorMessage),
        );
      },
    );

    test(
      'should return the error message when the value does not match the regex and is not in whitelist or blacklist',
      () {
        // Arrange
        final PassportNumberValidator validator = PassportNumberValidator(
          passportNumberWhitelist: passportNumberWhitelist,
          passportNumberBlacklist: passportNumberBlacklist,
        );

        // Act & Assert
        expect(
          validator.validate('NotInWhitelistOrBlacklist'),
          equals(validator.errorText),
        );
      },
    );
  });
}
