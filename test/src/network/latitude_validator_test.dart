import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('LatitudeValidator -', () {
    test('should return null for valid latitude values', () {
      // Arrange
      const LatitudeValidator validator = LatitudeValidator();
      const List<String> validLatitudes = <String>[
        '0',
        '45',
        '90',
        '-45',
        '-90',
        '23.4567',
        '-23.4567',
        '45.678',
        '-45.678',
        '90.0000',
        '-90.0000',
      ];

      // Act & Assert
      for (final String value in validLatitudes) {
        expect(validator.validate(value), isNull);
      }
    });

    test('should return the default error message for invalid latitude values',
        () {
      // Arrange
      const LatitudeValidator validator = LatitudeValidator();
      const List<String> invalidLatitudes = <String>[
        '91',
        '-91',
        '100',
        '-100',
        '123.456',
        '-123.456',
        'abc',
        '45.678,',
      ];

      // Act & Assert
      for (final String value in invalidLatitudes) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.longitudeErrorText),
        );
      }
    });

    test('should return the custom error message for invalid latitude values',
        () {
      // Arrange
      final LatitudeValidator validator =
          LatitudeValidator(errorText: customErrorMessage);
      const List<String> invalidLatitudes = <String>[
        '91',
        '-91',
        '100',
        '-100',
        '123.456',
        '-123.456',
        'abc',
        '45.678,',
      ];

      // Act & Assert
      for (final String value in invalidLatitudes) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test(
        'should return null when the latitude is null and null check is disabled',
        () {
      // Arrange
      const LatitudeValidator validator =
          LatitudeValidator(checkNullOrEmpty: false);
      const String? nullLatitude = null;

      // Act
      final String? result = validator.validate(nullLatitude);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the latitude is null',
        () {
      // Arrange
      const LatitudeValidator validator = LatitudeValidator();
      const String? nullLatitude = null;

      // Act
      final String? result = validator.validate(nullLatitude);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.longitudeErrorText),
      );
    });

    test(
        'should return null when the latitude is an empty string and null check is disabled',
        () {
      // Arrange
      const LatitudeValidator validator =
          LatitudeValidator(checkNullOrEmpty: false);
      const String emptyLatitude = '';

      // Act
      final String? result = validator.validate(emptyLatitude);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the latitude is an empty string',
        () {
      // Arrange
      const LatitudeValidator validator = LatitudeValidator();
      const String emptyLatitude = '';

      // Act
      final String? result = validator.validate(emptyLatitude);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.longitudeErrorText),
      );
    });
  });
}
