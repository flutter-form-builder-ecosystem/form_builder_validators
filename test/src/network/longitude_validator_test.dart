import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('LongitudeValidator -', () {
    test('should return null for valid longitude values', () {
      // Arrange
      const LongitudeValidator validator = LongitudeValidator();
      const List<String> validLongitudes = <String>[
        '0',
        '45',
        '180',
        '-45',
        '-180',
        '23.4567',
        '-23.4567',
        '45.678',
        '-45.678',
        '180.0000',
        '-180.0000',
      ];

      // Act & Assert
      for (final String value in validLongitudes) {
        expect(validator.validate(value), isNull);
      }
    });

    test('should return the default error message for invalid longitude values',
        () {
      // Arrange
      const LongitudeValidator validator = LongitudeValidator();
      const List<String> invalidLongitudes = <String>[
        '181',
        '-181',
        '200',
        '-200',
        'abc',
        '45.678,',
      ];

      // Act & Assert
      for (final String value in invalidLongitudes) {
        final String? result = validator.validate(value);
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.longitudeErrorText),
        );
      }
    });

    test('should return the custom error message for invalid longitude values',
        () {
      // Arrange
      final LongitudeValidator validator =
          LongitudeValidator(errorText: customErrorMessage);
      const List<String> invalidLongitudes = <String>[
        '181',
        '-181',
        '200',
        '-200',
        'abc',
        '45.678,',
      ];

      // Act & Assert
      for (final String value in invalidLongitudes) {
        final String? result = validator.validate(value);
        expect(result, equals(customErrorMessage));
      }
    });

    test(
        'should return null when the longitude is null and null check is disabled',
        () {
      // Arrange
      const LongitudeValidator validator =
          LongitudeValidator(checkNullOrEmpty: false);
      const String? nullLongitude = null;

      // Act
      final String? result = validator.validate(nullLongitude);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the longitude is null',
        () {
      // Arrange
      const LongitudeValidator validator = LongitudeValidator();
      const String? nullLongitude = null;

      // Act
      final String? result = validator.validate(nullLongitude);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.longitudeErrorText),
      );
    });

    test(
        'should return null when the longitude is an empty string and null check is disabled',
        () {
      // Arrange
      const LongitudeValidator validator =
          LongitudeValidator(checkNullOrEmpty: false);
      const String emptyLongitude = '';

      // Act
      final String? result = validator.validate(emptyLongitude);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the longitude is an empty string',
        () {
      // Arrange
      const LongitudeValidator validator = LongitudeValidator();
      const String emptyLongitude = '';

      // Act
      final String? result = validator.validate(emptyLongitude);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.longitudeErrorText),
      );
    });
  });
}
