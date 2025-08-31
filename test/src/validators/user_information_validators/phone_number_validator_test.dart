import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Validator: phoneNumber', () {
    test('should return null for valid phone numbers', () {
      // Arrange
      final Validator<String> validator = phoneNumber();
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
        expect(validator(value), isNull);
      }
    });

    test(
      'should return the default error message for invalid phone numbers',
      () {
        // Arrange
        final Validator<String> validator = phoneNumber();
        const List<String> invalidPhoneNumbers = <String>[
          'phone123',
          '123-abc-7890',
        ];

        // Act & Assert
        for (final String value in invalidPhoneNumbers) {
          final String? result = validator(value);
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
        final Validator<String> validator = phoneNumber(
          phoneNumberMsg: (_) => customErrorMessage,
        );
        const List<String> invalidPhoneNumbers = <String>[
          'phone123',
          '123-abc-7890',
        ];

        // Act & Assert
        for (final String value in invalidPhoneNumbers) {
          final String? result = validator(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );

    test(
      'should return the default error message when the phone number is an empty string',
      () {
        // Arrange
        final Validator<String> validator = phoneNumber();
        const String emptyPhoneNumber = '';

        // Act
        final String? result = validator(emptyPhoneNumber);

        // Assert
        expect(result, equals(FormBuilderLocalizations.current.phoneErrorText));
      },
    );
  });
}
