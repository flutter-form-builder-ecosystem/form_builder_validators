import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/constants.dart';
import 'package:form_builder_validators/src/validators/network_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  group('Validator: ip', () {
    group('Validate ipV4', () {
      final List<({String input, bool isValid})> testCases =
          <({String input, bool isValid})>[
        // Invalid cases
        (input: '', isValid: false),
        (input: '  ', isValid: false),
        (input: '123', isValid: false),
        (input: 'invalid', isValid: false),
        (input: '256.256.256.256', isValid: false),
        (input: '192.168.1.256', isValid: false),
        (input: '192.168.-1.256', isValid: false), // negative number
        (input: '192.168.1', isValid: false),
        (input: '192.168.1.1.1', isValid: false),
        (input: '192.168.1.a', isValid: false),
        (input: '::1', isValid: false),
        (input: '2001:0db8:85a3:0000:0000:8a2e:0370:7334', isValid: false),
        (input: '2001:db8:85a3:0:0:8a2e:370:7334', isValid: false),
        (input: '2001:db8:85a3::8a2e:370:7334', isValid: false),
        (input: '192.168..1', isValid: false), // Double dot
        (input: '.192.168.1.1', isValid: false), // Leading dot
        (input: '192.168.1.1.', isValid: false), // Trailing dot
        (input: ' 192.168.1.1', isValid: false), // Leading space
        (input: '192.168.1.1 ', isValid: false), // Trailing space
        (input: '192.168.1.1\n', isValid: false), // Newline
        (input: '192.168.1.1\t', isValid: false), // Tab
        (input: '192,168,1,1', isValid: false), // Wrong separator

        // Valid cases
        (input: faker.internet.ip(), isValid: true),
        (input: '0.0.0.0', isValid: true),
        (input: '192.168.1.1', isValid: true),
        (input: '10.0.0.1', isValid: true),
        (input: '172.16.0.1', isValid: true),
        (input: '255.255.255.255', isValid: true),
        (input: '127.0.0.1', isValid: true), // Localhost
        // Be aware of leading zeros: 09 may not be equal to 9 depending on the tool:
        // https://superuser.com/questions/857603/are-ip-addresses-with-and-without-leading-zeroes-the-same
        (input: '192.168.09.1', isValid: true), // Leading zeros
      ];

      final Validator<String> v = ip();
      for (final (input: String input, isValid: bool isValid) in testCases) {
        test(
            'should return ${isValid ? 'null' : 'error message for ipV4'} for input "$input"',
            () => expect(
                v(input),
                isValid
                    ? isNull
                    : equals(FormBuilderLocalizations.current.ipErrorText)));
      }
    });
    group('Validate ipV6', () {
      final List<({String input, bool isValid})> testCases =
          <({String input, bool isValid})>[
        // Invalid cases
        (input: '', isValid: false), // Empty string
        (input: '  ', isValid: false), // Whitespace only
        (input: '123', isValid: false), // Incomplete address
        (input: 'invalid', isValid: false), // Non-IP string
        (input: '256.256.256.256', isValid: false), // Invalid ipV4
        (input: '192.168.1.256', isValid: false), // Invalid ipV4
        (
          input: faker.internet.ip(),
          isValid: false
        ), // Valid ipV4 (but invalid ipV6)
        (input: '0.0.0.0', isValid: false), // Valid ipV4 (but invalid ipV6)
        (input: '127.0.0.1', isValid: false), // Valid ipV4 (but invalid ipV6)
        (input: '12345::', isValid: false), // Invalid short IPv6
        (
          input: 'GGGG:GGGG:GGGG:GGGG:GGGG:GGGG:GGGG:GGGG',
          isValid: false
        ), // Invalid hex
        (
          input: '2001:0db8:85a3::8a2e:037j:7334',
          isValid: false
        ), // Invalid hex 'j'
        (
          input: '2001:0db8:85a3::8a2e:037z:7334',
          isValid: false
        ), // Invalid hex 'z'
        (input: '::12345', isValid: false), // Invalid compressed IPv6
        (input: '1::1::1', isValid: false), // Multiple compression markers
        (input: '2001:db8::1::1', isValid: false), // Multiple compression
        (input: 'fe80:2030:31:24', isValid: false), // Incomplete IPv6
        (
          input: '1200:0000:AB00:1234:O000:2552:7777:1313',
          isValid: false
        ), // 'O' vs '0'

        // Valid cases
        (input: '::1', isValid: true), // IPv6 loopback
        (
          input: '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          isValid: true
        ), // Full IPv6
        (
          input: '2001:db8:85a3:0:0:8a2e:370:7334',
          isValid: true
        ), // IPv6 with zeros
        (
          input: '2001:db8:85a3::8a2e:370:7334',
          isValid: true
        ), // Compressed IPv6
        (input: 'fe80::1', isValid: true), // Link-local IPv6
        (input: '::ffff:192.0.2.128', isValid: true), // IPv4-mapped IPv6
        (input: '2001:db8::', isValid: true), // Network address
        (
          input: 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff',
          isValid: true
        ), // Max value
      ];

      final Validator<String> v = ip(version: IpVersion.iPv6);
      for (final (input: String input, isValid: bool isValid) in testCases) {
        test(
            'should return ${isValid ? 'null' : 'error message for ipV6'} for input "$input"',
            () => expect(
                v(input),
                isValid
                    ? isNull
                    : equals(FormBuilderLocalizations.current.ipErrorText)));
      }
    });
    group('Validate ipV4 or ipV6', () {
      final List<({String input, bool isValid})> testCases =
          <({String input, bool isValid})>[
        // Invalid cases
        (input: '', isValid: false),
        (input: '  ', isValid: false),
        (input: '123', isValid: false),
        (input: 'invalid', isValid: false),
        (input: '256.256.256.256', isValid: false),
        (input: '192.168.1.256', isValid: false),
        (input: '192.168.-1.256', isValid: false), // negative number
        (input: '192.168.1', isValid: false),
        (input: '192.168.1.1.1', isValid: false),
        (input: '192.168.1.a', isValid: false),
        (input: '192.168..1', isValid: false), // Double dot
        (input: '.192.168.1.1', isValid: false), // Leading dot
        (input: '192.168.1.1.', isValid: false), // Trailing dot
        (input: ' 192.168.1.1', isValid: false), // Leading space
        (input: '192.168.1.1 ', isValid: false), // Trailing space
        (input: '192.168.1.1\n', isValid: false), // Newline
        (input: '192.168.1.1\t', isValid: false), // Tab
        (input: '192,168,1,1', isValid: false), // Wrong separator
        (input: '12345::', isValid: false), // Invalid short IPv6
        (
          input: 'GGGG:GGGG:GGGG:GGGG:GGGG:GGGG:GGGG:GGGG',
          isValid: false
        ), // Invalid hex
        (
          input: '2001:0db8:85a3::8a2e:037j:7334',
          isValid: false
        ), // Invalid hex 'j'
        (
          input: '2001:0db8:85a3::8a2e:037z:7334',
          isValid: false
        ), // Invalid hex 'z'
        (input: '::12345', isValid: false), // Invalid compressed IPv6
        (input: '1::1::1', isValid: false), // Multiple compression markers
        (input: '2001:db8::1::1', isValid: false), // Multiple compression
        (input: 'fe80:2030:31:24', isValid: false), // Incomplete IPv6
        (
          input: '1200:0000:AB00:1234:O000:2552:7777:1313',
          isValid: false
        ), // 'O' vs '0'

        // Valid cases
        (input: faker.internet.ip(), isValid: true),
        (input: '0.0.0.0', isValid: true),
        (input: '192.168.1.1', isValid: true),
        (input: '10.0.0.1', isValid: true),
        (input: '172.16.0.1', isValid: true),
        (input: '255.255.255.255', isValid: true),
        (input: '127.0.0.1', isValid: true), // Localhost
        // Be aware of leading zeros: 09 may not be equal to 9 depending on the tool:
        // https://superuser.com/questions/857603/are-ip-addresses-with-and-without-leading-zeroes-the-same
        (input: '192.168.09.1', isValid: true), // Leading zeros
        (input: '::1', isValid: true), // IPv6 loopback
        (
          input: '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          isValid: true
        ), // Full IPv6
        (
          input: '2001:db8:85a3:0:0:8a2e:370:7334',
          isValid: true
        ), // IPv6 with zeros
        (
          input: '2001:db8:85a3::8a2e:370:7334',
          isValid: true
        ), // Compressed IPv6
        (input: 'fe80::1', isValid: true), // Link-local IPv6
        (input: '::ffff:192.0.2.128', isValid: true), // IPv4-mapped IPv6
        (input: '2001:db8::', isValid: true), // Network address
        (
          input: 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff',
          isValid: true
        ), // Max value
      ];

      final Validator<String> v = ip(version: IpVersion.any);
      for (final (input: String input, isValid: bool isValid) in testCases) {
        test(
            'should return ${isValid ? 'null' : 'error message for ipV4/6'} for input "$input"',
            () => expect(
                v(input),
                isValid
                    ? isNull
                    : equals(FormBuilderLocalizations.current.ipErrorText)));
      }
    });

    test('should return custom message', () {
      final errorMessage = 'error Msg';
      final validator = ip(ipMsg: (_) => errorMessage);

      expect(validator('1.2.3.4'), isNull);
      expect(validator('1.2.3.256'), errorMessage);
    });

    test('should validate with custom regex', () {
      final validator =
          ip(version: IpVersion.any, regex: RegExp('this is valid'));

      expect(
          validator('1.2.3.4'), FormBuilderLocalizations.current.ipErrorText);
      expect(validator('this is valid'), isNull);
    });
  });
}
