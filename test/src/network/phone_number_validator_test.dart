import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('PhoneNumberValidator -', () {
    test('should return null for valid phone numbers', () {
      // Arrange
      final PhoneNumberValidator validator = PhoneNumberValidator();
      final List<String> validPhoneNumbers = <String>[
        '+1-800-555-5555',
        '1234567890',
        '+44 7911 123456',
        '07911 123456',
        '+91-9876543210',
        '9876543210',
        '123-456-7890',
        '123.456.7890',
        '+49 123 456 7890',
      ];

      // Act & Assert
      for (final String value in validPhoneNumbers) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
      'should return the default error message for invalid phone numbers',
      () {
        // Arrange
        final PhoneNumberValidator validator = PhoneNumberValidator();
        const List<String> invalidPhoneNumbers = <String>[
          'phone123',
          '123-abc-7890',
        ];

        // Act & Assert
        for (final String value in invalidPhoneNumbers) {
          final String? result = validator.validate(value);
          expect(result, isNotNull);
          expect(
            result,
            equals(FormBuilderLocalizations.current.phoneErrorText),
          );
        }
      },
    );

    test(
      'should return the custom error message for invalid phone numbers',
      () {
        // Arrange
        final PhoneNumberValidator validator = PhoneNumberValidator(
          errorText: customErrorMessage,
        );
        const List<String> invalidPhoneNumbers = <String>[
          'phone123',
          '123-abc-7890',
        ];

        // Act & Assert
        for (final String value in invalidPhoneNumbers) {
          final String? result = validator.validate(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );

    test(
      'should return null when the phone number is null and null check is disabled',
      () {
        // Arrange
        final PhoneNumberValidator validator = PhoneNumberValidator(
          checkNullOrEmpty: false,
        );
        const String? nullPhoneNumber = null;

        // Act
        final String? result = validator.validate(nullPhoneNumber);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the phone number is null',
      () {
        // Arrange
        final PhoneNumberValidator validator = PhoneNumberValidator();
        const String? nullPhoneNumber = null;

        // Act
        final String? result = validator.validate(nullPhoneNumber);

        // Assert
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.phoneErrorText));
      },
    );

    test(
      'should return null when the phone number is an empty string and null check is disabled',
      () {
        // Arrange
        final PhoneNumberValidator validator = PhoneNumberValidator(
          checkNullOrEmpty: false,
        );
        const String emptyPhoneNumber = '';

        // Act
        final String? result = validator.validate(emptyPhoneNumber);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the phone number is an empty string',
      () {
        // Arrange
        final PhoneNumberValidator validator = PhoneNumberValidator();
        const String emptyPhoneNumber = '';

        // Act
        final String? result = validator.validate(emptyPhoneNumber);

        // Assert
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.phoneErrorText));
      },
    );
  });
}
