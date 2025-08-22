import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/network_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MacAddressValidator -', () {
    test('should return null for valid MAC addresses', () {
      // Arrange
      final Validator<String> validator = macAddress();
      const List<String> validMacAddresses = <String>[
        '00:1B:44:11:3A:B7',
        '00:1a:2b:3c:4d:5e',
        '00-1A-2B-3C-4D-5E',
        '00-1a-2b-3c-4d-5e',
      ];

      // Act & Assert
      for (final String value in validMacAddresses) {
        expect(validator(value), isNull);
      }
    });

    test(
      'should return the default error message for invalid MAC addresses',
      () {
        // Arrange
        final Validator<String> validator = macAddress();
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
          final String? result = validator(value);
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
        final Validator<String> validator = macAddress(
          macAddressMsg: (_) => customErrorMessage,
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
          final String? result = validator(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );

    test(
      'should return the default error message when the MAC address is an empty string',
      () {
        // Arrange
        final Validator<String> validator = macAddress();
        const String emptyMacAddress = '';

        // Act
        final String? result = validator(emptyMacAddress);

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
      final Validator<String> validator = macAddress(
        isMacAddress: (String i) => customRegex.hasMatch(i),
      );
      const List<String> validMacAddresses = <String>[
        '00:1A:2B:3C:4D:5E',
        '00:1a:2b:3c:4d:5e',
        '00-1A-2B-3C-4D-5E',
        '00-1a-2b-3c-4d-5e',
      ];

      // Act & Assert
      for (final String value in validMacAddresses) {
        expect(validator(value), isNull);
      }
    });

    test(
      'should return the custom error message for invalid MAC addresses with custom regex',
      () {
        // Arrange
        final RegExp customRegex = RegExp(
          r'^[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}[:-]{1}[0-9A-Fa-f]{2}$',
        );
        final Validator<String> validator = macAddress(
          isMacAddress: (String i) => customRegex.hasMatch(i),
          macAddressMsg: (_) => customErrorMessage,
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
          final String? result = validator(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );
  });
}
