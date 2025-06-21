import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Time -', () {
    test('should return null for valid 24-hour time strings', () {
      // Arrange
      final TimeValidator validator = TimeValidator();

      // Act & Assert
      expect(validator.validate('23:59'), isNull);
      expect(validator.validate('04:04'), isNull);
    });

    test('should return null for valid 12-hour time strings with AM/PM', () {
      // Arrange
      final TimeValidator validator = TimeValidator();

      // Act & Assert
      expect(validator.validate('12:00 AM'), isNull);
      expect(validator.validate('12:00 PM'), isNull);
      expect(validator.validate('11:59 PM'), isNull);
    });

    test('should return null for valid time strings with seconds', () {
      // Arrange
      final TimeValidator validator = TimeValidator();

      // Act & Assert
      expect(validator.validate('4:59:59'), isNull);
      expect(validator.validate('4:4:59'), isNull);
      expect(validator.validate('4:4:4'), isNull);
      expect(validator.validate('11:59:59'), isNull);
      expect(validator.validate('04:04:59'), isNull);
      expect(validator.validate('04:04:04'), isNull);
      expect(validator.validate('4:00:00 AM'), isNull);
      expect(validator.validate('12:00:00 PM'), isNull);
      expect(validator.validate('11:59:59 PM'), isNull);
      expect(validator.validate('01:01:01 AM'), isNull);
      expect(validator.validate('10:10:10 PM'), isNull);
      expect(validator.validate('12:34:56 AM'), isNull);
    });

    test('should return null for valid single-digit hour times', () {
      // Arrange
      final TimeValidator validator = TimeValidator();

      // Act & Assert
      expect(validator.validate('4:00'), isNull);
      expect(validator.validate('12:00'), isNull);
    });

    test(
      'should return the default error message for invalid time strings',
      () {
        // Arrange
        final TimeValidator validator = TimeValidator();

        // Act & Assert
        expect(
          validator.validate('13:00 AM'),
          equals(FormBuilderLocalizations.current.timeErrorText),
        );
        expect(
          validator.validate('25:00'),
          equals(FormBuilderLocalizations.current.timeErrorText),
        );
        expect(
          validator.validate('invalid-time'),
          equals(FormBuilderLocalizations.current.timeErrorText),
        );
        expect(
          validator.validate(null),
          equals(FormBuilderLocalizations.current.timeErrorText),
        );
        expect(
          validator.validate(''),
          equals(FormBuilderLocalizations.current.timeErrorText),
        );
      },
    );

    test('should return the custom error message for invalid time strings', () {
      // Arrange
      final TimeValidator validator = TimeValidator(
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(validator.validate('25:00'), equals(customErrorMessage));
      expect(validator.validate('invalid-time'), equals(customErrorMessage));
      expect(validator.validate(null), equals(customErrorMessage));
      expect(validator.validate(''), equals(customErrorMessage));
    });

    test('should return null for valid DateTime strings', () {
      // Arrange
      final TimeValidator validator = TimeValidator();
      final DateTime now = DateTime.now();
      final String value = now.toIso8601String();

      // Act & Assert
      expect(validator.validate(value), isNull);
    });

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        final TimeValidator validator = TimeValidator(checkNullOrEmpty: false);
        const String value = '';

        // Act & Assert
        final String? result = validator.validate(value);
        expect(result, isNull);
      },
    );

    test(
      'should return null when the value is null and null check is disabled',
      () {
        // Arrange
        final TimeValidator validator = TimeValidator(checkNullOrEmpty: false);
        const String? value = null;

        // Act & Assert
        final String? result = validator.validate(value);
        expect(result, isNull);
      },
    );

    test(
      'should use custom regex and return null for valid custom time strings',
      () {
        // Arrange
        final RegExp customRegex = RegExp(r'^\d{1,2}:\d{2}$');
        final TimeValidator validator = TimeValidator(regex: customRegex);

        // Act & Assert
        expect(validator.validate('9:30'), isNull);
        expect(validator.validate('15:45'), isNull);
      },
    );

    test(
      'should use custom regex and return the default error message for invalid custom time strings',
      () {
        // Arrange
        final RegExp customRegex = RegExp(r'^\d{1,2}:\d{2}$');
        final TimeValidator validator = TimeValidator(regex: customRegex);

        // Act & Assert
        expect(
          validator.validate('9:30 AM'),
          equals(FormBuilderLocalizations.current.timeErrorText),
        );
        expect(
          validator.validate('invalid-time'),
          equals(FormBuilderLocalizations.current.timeErrorText),
        );
      },
    );

    test(
      'should use custom regex and return the custom error message for invalid custom time strings',
      () {
        // Arrange
        final RegExp customRegex = RegExp(r'^\d{1,2}:\d{2}$');
        final TimeValidator validator = TimeValidator(
          regex: customRegex,
          errorText: customErrorMessage,
        );

        // Act & Assert
        expect(validator.validate('9:30 AM'), equals(customErrorMessage));
        expect(validator.validate('invalid-time'), equals(customErrorMessage));
      },
    );
  });
}
