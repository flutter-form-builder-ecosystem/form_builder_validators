import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MacAddressValidator -', () {
    test('should return null for valid MAC addresses', () {
      // Arrange
      final MacAddressValidator validator = MacAddressValidator();
      const List<String> validMacAddresses = <String>[
        '00:1B:44:11:3A:B7',
        '00:1a:2b:3c:4d:5e',
        '00-1A-2B-3C-4D-5E',
        '00-1a-2b-3c-4d-5e',
      ];

      // Act & Assert
      for (final String value in validMacAddresses) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
      'should return the default error message for invalid MAC addresses',
      () {
        // Arrange
        final MacAddressValidator validator = MacAddressValidator();
        const List<String> invalidMacAddresses = <String>[
          '00:1A:2B:3C:4D',
          '00:1A:2B:3C:4D:5E:6F',
          '00:1A:2B:3C:4D:ZZ',
          '00-1A-2B-3C-4D',
          '001A2B3C4D5E',
          'G0:1A:2B:3C:4D:5E',
        ];

        // Act & Assert
        for (final String value in invalidMacAddresses) {
          final String? result = validator.validate(value);
          expect(result, isNotNull);
          expect(
            result,
            equals(FormBuilderLocalizations.current.macAddressErrorText),
          );
        }
      },
    );

    test(
      'should return the custom error message for invalid MAC addresses',
      () {
        // Arrange
        final MacAddressValidator validator = MacAddressValidator(
          errorText: customErrorMessage,
        );
        const List<String> invalidMacAddresses = <String>[
          '00:1A:2B:3C:4D',
          '00:1A:2B:3C:4D:5E:6F',
          '00:1A:2B:3C:4D:ZZ',
          '00-1A-2B-3C-4D',
          '001A2B3C4D5E',
          'G0:1A:2B:3C:4D:5E',
        ];

        // Act & Assert
        for (final String value in invalidMacAddresses) {
          final String? result = validator.validate(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );

    test(
      'should return null when the MAC address is null and null check is disabled',
      () {
        // Arrange
        final MacAddressValidator validator = MacAddressValidator(
          checkNullOrEmpty: false,
        );
        const String? nullMacAddress = null;

        // Act
        final String? result = validator.validate(nullMacAddress);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the MAC address is null',
      () {
        // Arrange
        final MacAddressValidator validator = MacAddressValidator();
        const String? nullMacAddress = null;

        // Act
        final String? result = validator.validate(nullMacAddress);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.macAddressErrorText),
        );
      },
    );

    test(
      'should return null when the MAC address is an empty string and null check is disabled',
      () {
        // Arrange
        final MacAddressValidator validator = MacAddressValidator(
          checkNullOrEmpty: false,
        );
        const String emptyMacAddress = '';

        // Act
        final String? result = validator.validate(emptyMacAddress);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the MAC address is an empty string',
      () {
        // Arrange
        final MacAddressValidator validator = MacAddressValidator();
        const String emptyMacAddress = '';

        // Act
        final String? result = validator.validate(emptyMacAddress);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.macAddressErrorText),
        );
      },
    );

    test('should return null for valid MAC addresses with custom regex', () {
      // Arrange
      final RegExp customRegex = RegExp(
        r'^[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}$',
      );
      final MacAddressValidator validator = MacAddressValidator(
        regex: customRegex,
      );
      const List<String> validMacAddresses = <String>[
        '00:1A:2B:3C:4D:5E',
        '00:1a:2b:3c:4d:5e',
        '00-1A-2B-3C-4D-5E',
        '00-1a-2b-3c-4d-5e',
      ];

      // Act & Assert
      for (final String value in validMacAddresses) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
      'should return the custom error message for invalid MAC addresses with custom regex',
      () {
        // Arrange
        final RegExp customRegex = RegExp(
          r'^[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}$',
        );
        final MacAddressValidator validator = MacAddressValidator(
          regex: customRegex,
          errorText: customErrorMessage,
        );
        const List<String> invalidMacAddresses = <String>[
          '00:1A:2B:3C:4D',
          '00:1A:2B:3C:4D:5E:6F',
          '00:1A:2B:3C:4D:ZZ',
          '00-1A-2B-3C-4D',
          '001A2B3C4D5E',
          'G0:1A:2B:3C:4D:5E',
        ];

        // Act & Assert
        for (final String value in invalidMacAddresses) {
          final String? result = validator.validate(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );
  });
}
