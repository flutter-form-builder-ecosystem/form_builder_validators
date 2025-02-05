import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/constants.dart';
import 'package:form_builder_validators/src/validators/network_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('UrlValidator -', () {
    test('should return null for valid URLs with default protocols', () {
      // Arrange
      final Validator<String> validator = url();
      const List<String> validUrls = <String>[
        'http://example.com',
        'https://example.com',
        'ftp://example.com',
        'http://www.example.com',
        'https://www.example.com',
        'ftp://www.example.com',
        'http://subdomain.example.com',
        'https://subdomain.example.com',
        'ftp://subdomain.example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator(value), isNull);
      }
    });

    test('should return null for valid URLs with custom protocols', () {
      // Arrange
      final Validator<String> validator =
          url(protocols: <String>['http', 'https']);
      const List<String> validUrls = <String>[
        'http://example.com',
        'https://example.com',
        'http://www.example.com',
        'https://www.example.com',
        'http://subdomain.example.com',
        'https://subdomain.example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator(value), isNull);
      }
    });

    test('should return the default error message for invalid URLs', () {
      // Arrange
      final Validator<String> validator = url();
      const List<String> invalidUrls = <String>[
        'example',
        'http:/example.com',
        'http://example',
        'http://example..com',
        'http://example.com:99999',
        'http://-example.com',
        'http://example-.com',
        'http://example.com:port',
        'ftp://example.com:port',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
      }
    });

    test('should return the custom error message for invalid URLs', () {
      // Arrange
      final Validator<String> validator =
          url(urlMsg: (_) => customErrorMessage);
      const List<String> invalidUrls = <String>[
        'example',
        'http:/example.com',
        'http://example',
        'http://example..com',
        'http://example.com:99999',
        'http://-example.com',
        'http://example-.com',
        'http://example.com:port',
        'ftp://example.com:port',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test('should return null for valid URLs with custom regex', () {
      // Arrange
      final RegExp customRegex =
          RegExp(r'^(http|https)://[a-zA-Z0-9\-_]+\.[a-zA-Z]{2,}$');
      final Validator<String> validator = url(regex: customRegex);
      const List<String> validUrls = <String>[
        'http://example.com',
        'https://example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator(value), isNull);
      }
    });

    test(
        'should return the custom error message for invalid URLs with custom regex',
        () {
      // Arrange
      final RegExp customRegex =
          RegExp(r'^(http|https)://[a-zA-Z0-9\-_]+\.[a-zA-Z]{2,}$');
      final Validator<String> validator =
          url(regex: customRegex, urlMsg: (_) => customErrorMessage);
      const List<String> invalidUrls = <String>[
        'ftp://example.com',
        'http://example',
        'https://example',
        'http://example..com',
        'https://example..com',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test(
        'should return the default error message when the URL is an empty string',
        () {
      // Arrange
      final Validator<String> validator = url();
      const String emptyUrl = '';

      // Act
      final String? result = validator(emptyUrl);

      // Assert
      expect(result, isNotNull);
      expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
    });

    test('should return null for valid URLs with allowed underscore', () {
      // Arrange
      final Validator<String> validator = url(allowUnderscore: true);
      const List<String> validUrls = <String>[
        'http://example_com.com',
        'https://example_com.com',
        'ftp://example_com.com',
        'http://subdomain_example.com',
        'https://subdomain_example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator(value), isNull);
      }
    });

    test(
        'should return the default error message for invalid URLs with disallowed underscore',
        () {
      // Arrange
      final Validator<String> validator = url();
      const List<String> invalidUrls = <String>[
        'http://example_com.com',
        'https://example_com.com',
        'ftp://example_com.com',
        'http://subdomain_example.com',
        'https://subdomain_example.com',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
      }
    });

    test('should return null for valid URLs with host whitelist', () {
      // Arrange
      final Validator<String> validator = url(
        hostAllowList: <String>['example.com', 'subdomain.example.com'],
      );
      const List<String> validUrls = <String>[
        'http://example.com',
        'https://example.com',
        'http://subdomain.example.com',
        'https://subdomain.example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator(value), isNull);
      }
    });

    test(
        'should return the default error message for URLs not in the host whitelist',
        () {
      // Arrange
      final Validator<String> validator = url(
        hostAllowList: <String>['example.com', 'subdomain.example.com'],
      );
      const List<String> invalidUrls = <String>[
        'http://notexample.com',
        'https://notexample.com',
        'http://example.org',
        'https://example.org',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
      }
    });

    test('should return null for valid URLs not in the host blacklist', () {
      // Arrange
      final Validator<String> validator =
          url(hostBlockList: <String>['banned.com', 'blocked.com']);
      const List<String> validUrls = <String>[
        'http://example.com',
        'https://example.com',
        'http://subdomain.example.com',
        'https://subdomain.example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator(value), isNull);
      }
    });

    test(
        'should return the default error message for URLs in the host blacklist',
        () {
      // Arrange
      final Validator<String> validator =
          url(hostBlockList: <String>['banned.com', 'blocked.com']);
      const List<String> invalidUrls = <String>[
        'http://banned.com',
        'https://banned.com',
        'http://blocked.com',
        'https://blocked.com',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
      }
    });

    test('should return null for valid URLs with user authentication', () {
      // Arrange
      final Validator<String> validator = url();
      const List<String> validUrls = <String>[
        'http://user@example.com',
        'https://user:password@example.com',
        'ftp://user:password@example.com',
        'http://user@www.example.com',
        'https://user:password@www.example.com',
        'ftp://user:password@www.example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator(value), isNull);
      }
    });

    test(
        'should maintain validation rules when input lists are modified after creation',
        () {
      final v = url(protocols: []);
    });
  });
}
