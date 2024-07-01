import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('UrlValidator -', () {
    test('should return null for valid URLs with default protocols', () {
      // Arrange
      final UrlValidator validator = UrlValidator();
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
        expect(validator.validate(value), isNull);
      }
    });

    test('should return null for valid URLs with custom protocols', () {
      // Arrange
      final UrlValidator validator =
          UrlValidator(protocols: <String>['http', 'https']);
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
        expect(validator.validate(value), isNull);
      }
    });

    test('should return the default error message for invalid URLs', () {
      // Arrange
      final UrlValidator validator = UrlValidator();
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
        'example.com',
        'www.example.com',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
      }
    });

    test('should return the custom error message for invalid URLs', () {
      // Arrange
      final UrlValidator validator =
          UrlValidator(errorText: customErrorMessage);
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
        'example.com',
        'www.example.com',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test('should return null for valid URLs with custom regex', () {
      // Arrange
      final RegExp customRegex =
          RegExp(r'^(http|https):\/\/[a-zA-Z0-9\-_]+\.[a-zA-Z]{2,}$');
      final UrlValidator validator = UrlValidator(regex: customRegex);
      const List<String> validUrls = <String>[
        'http://example.com',
        'https://example.com',
        'http://subdomain.example.com',
        'https://subdomain.example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
        'should return the custom error message for invalid URLs with custom regex',
        () {
      // Arrange
      final RegExp customRegex =
          RegExp(r'^(http|https):\/\/[a-zA-Z0-9\-_]+\.[a-zA-Z]{2,}$');
      final UrlValidator validator =
          UrlValidator(regex: customRegex, errorText: customErrorMessage);
      const List<String> invalidUrls = <String>[
        'ftp://example.com',
        'http://example',
        'https://example',
        'http://example..com',
        'https://example..com',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test('should return null when the URL is null and null check is disabled',
        () {
      // Arrange
      final UrlValidator validator = UrlValidator(checkNullOrEmpty: false);
      const String? nullUrl = null;

      // Act
      final String? result = validator.validate(nullUrl);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the URL is null', () {
      // Arrange
      final UrlValidator validator = UrlValidator();
      const String? nullUrl = null;

      // Act
      final String? result = validator.validate(nullUrl);

      // Assert
      expect(result, isNotNull);
      expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
    });

    test(
        'should return null when the URL is an empty string and null check is disabled',
        () {
      // Arrange
      final UrlValidator validator = UrlValidator(checkNullOrEmpty: false);
      const String emptyUrl = '';

      // Act
      final String? result = validator.validate(emptyUrl);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the URL is an empty string',
        () {
      // Arrange
      final UrlValidator validator = UrlValidator();
      const String emptyUrl = '';

      // Act
      final String? result = validator.validate(emptyUrl);

      // Assert
      expect(result, isNotNull);
      expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
    });

    test('should return null for valid URLs with allowed underscore', () {
      // Arrange
      final UrlValidator validator = UrlValidator(allowUnderscore: true);
      const List<String> validUrls = <String>[
        'http://example_com.com',
        'https://example_com.com',
        'ftp://example_com.com',
        'http://subdomain_example.com',
        'https://subdomain_example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
        'should return the default error message for invalid URLs with disallowed underscore',
        () {
      // Arrange
      final UrlValidator validator = UrlValidator();
      const List<String> invalidUrls = <String>[
        'http://example_com.com',
        'https://example_com.com',
        'ftp://example_com.com',
        'http://subdomain_example.com',
        'https://subdomain_example.com',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
      }
    });

    test('should return null for valid URLs with host whitelist', () {
      // Arrange
      final UrlValidator validator = UrlValidator(
        hostWhitelist: <String>['example.com', 'subdomain.example.com'],
      );
      const List<String> validUrls = <String>[
        'http://example.com',
        'https://example.com',
        'http://subdomain.example.com',
        'https://subdomain.example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
        'should return the default error message for URLs not in the host whitelist',
        () {
      // Arrange
      final UrlValidator validator = UrlValidator(
        hostWhitelist: <String>['example.com', 'subdomain.example.com'],
      );
      const List<String> invalidUrls = <String>[
        'http://notexample.com',
        'https://notexample.com',
        'http://example.org',
        'https://example.org',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
      }
    });

    test('should return null for valid URLs not in the host blacklist', () {
      // Arrange
      final UrlValidator validator =
          UrlValidator(hostBlacklist: <String>['banned.com', 'blocked.com']);
      const List<String> validUrls = <String>[
        'http://example.com',
        'https://example.com',
        'http://subdomain.example.com',
        'https://subdomain.example.com',
      ];

      // Act & Assert
      for (final String value in validUrls) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
        'should return the default error message for URLs in the host blacklist',
        () {
      // Arrange
      final UrlValidator validator =
          UrlValidator(hostBlacklist: <String>['banned.com', 'blocked.com']);
      const List<String> invalidUrls = <String>[
        'http://banned.com',
        'https://banned.com',
        'http://blocked.com',
        'https://blocked.com',
      ];

      // Act & Assert
      for (final String value in invalidUrls) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(result, equals(FormBuilderLocalizations.current.urlErrorText));
      }
    });
  });
}
