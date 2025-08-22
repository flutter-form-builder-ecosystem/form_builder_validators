import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('IpValidator -', () {
    test('should return null for valid IPv4 addresses', () {
      // Arrange
      final IpValidator validator = IpValidator();
      final String validIPv4 = faker.internet.ip();
      final List<String> validIPv4s = <String>[
        validIPv4,
        '192.168.1.1',
        '10.0.0.1',
        '172.16.0.1',
        '255.255.255.255',
        '0.0.0.0',
      ];

      // Act & Assert
      for (final String value in validIPv4s) {
        expect(validator.validate(value), isNull);
      }
    });

    test('should return null for valid IPv6 addresses', () {
      // Arrange
      final IpValidator validator = IpValidator(version: 6);
      const List<String> validIPv6s = <String>[
        '::1',
        '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
        '2001:db8:85a3:0:0:8a2e:370:7334',
        '2001:db8:85a3::8a2e:370:7334',
      ];

      // Act & Assert
      for (final String value in validIPv6s) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
      'should return the default error message for invalid IPv4 addresses',
      () {
        // Arrange
        final IpValidator validator = IpValidator();
        const List<String> invalidIPv4s = <String>[
          '256.256.256.256',
          '192.168.1.256',
          '192.168.1',
          '192.168.1.1.1',
          '192.168.1.a',
        ];

        // Act & Assert
        for (final String value in invalidIPv4s) {
          final String? result = validator.validate(value);
          expect(result, isNotNull);
          expect(result, equals(FormBuilderLocalizations.current.ipErrorText));
        }
      },
    );

    test('should return the default error message for invalid IPv6 addresses', () {
      // Arrange
      final IpValidator validator = IpValidator(version: 6);
      const List<String> invalidIPv6s = <String>[
        '12345::', // Invalid because it's too short and contains an invalid number
        'GGGG:GGGG:GGGG:GGGG:GGGG:GGGG:GGGG:GGGG', // Invalid because it contains non-hexadecimal characters
        '2001:0db8:85a3::8a2e:037j:7334', // Invalid because it contains a non-hexadecimal character 'j'
        '2001:0db8:85a3::8a2e:037z:7334', // Invalid because it contains a non-hexadecimal character 'z'
        '::12345', // Invalid because it's too long
        '1::1::1', // Invalid because it has more than one '::'
      ];

      // Act & Assert
      for (final String value in invalidIPv6s) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.ipErrorText));
      }
    });

    test('should return the custom error message for invalid IP addresses', () {
      // Arrange
      final IpValidator validator = IpValidator(errorText: customErrorMessage);
      const List<String> invalidIPs = <String>[
        '256.256.256.256',
        '192.168.1.256',
        '192.168.1',
        '192.168.1.1.1',
        '192.168.1.a',
      ];

      // Act & Assert
      for (final String value in invalidIPs) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test(
      'should return null for valid IP addresses according to custom regex',
      () {
        // Arrange
        final RegExp customRegex = RegExp(r'^192\.168\.1\.\d{1,3}$');
        final IpValidator validator = IpValidator(regex: customRegex);
        const List<String> validIPs = <String>[
          '192.168.1.1',
          '192.168.1.255',
          '192.168.1.100',
        ];

        // Act & Assert
        for (final String value in validIPs) {
          expect(validator.validate(value), isNull);
        }
      },
    );

    test(
      'should return the default error message for invalid IP addresses according to custom regex',
      () {
        // Arrange
        final RegExp customRegex = RegExp(r'^192\.168\.1\.\d{1,3}$');
        final IpValidator validator = IpValidator(regex: customRegex);
        const List<String> invalidIPs = <String>[
          '192.168.2.1',
          '10.0.0.1',
          '172.16.0.1',
          '255.255.255.255',
          '0.0.0.0',
        ];

        // Act & Assert
        for (final String value in invalidIPs) {
          final String? result = validator.validate(value);
          expect(result, isNotNull);
          expect(result, equals(FormBuilderLocalizations.current.ipErrorText));
        }
      },
    );

    test(
      'should return the custom error message for invalid IP addresses according to custom regex',
      () {
        // Arrange
        final RegExp customRegex = RegExp(r'^192\.168\.1\.\d{1,3}$');
        final IpValidator validator = IpValidator(
          regex: customRegex,
          errorText: customErrorMessage,
        );
        const List<String> invalidIPs = <String>[
          '192.168.2.1',
          '10.0.0.1',
          '172.16.0.1',
          '255.255.255.255',
          '0.0.0.0',
        ];

        // Act & Assert
        for (final String value in invalidIPs) {
          final String? result = validator.validate(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );

    test(
      'should return null when the IP address is null and null check is disabled',
      () {
        // Arrange
        final IpValidator validator = IpValidator(checkNullOrEmpty: false);
        const String? nullIp = null;

        // Act
        final String? result = validator.validate(nullIp);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the IP address is null',
      () {
        // Arrange
        final IpValidator validator = IpValidator();
        const String? nullIp = null;

        // Act
        final String? result = validator.validate(nullIp);

        // Assert
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.ipErrorText));
      },
    );

    test(
      'should return null when the IP address is an empty string and null check is disabled',
      () {
        // Arrange
        final IpValidator validator = IpValidator(checkNullOrEmpty: false);
        const String emptyIp = '';

        // Act
        final String? result = validator.validate(emptyIp);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the IP address is an empty string',
      () {
        // Arrange
        final IpValidator validator = IpValidator();
        const String emptyIp = '';

        // Act
        final String? result = validator.validate(emptyIp);

        // Assert
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.ipErrorText));
      },
    );
  });
}
