import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('ColorCodeValidator -', () {
    test('should return null if the color code is a valid hex', () {
      // Arrange
      final ColorCodeValidator validator = ColorCodeValidator();
      const String validHex = '#1a2b3c';

      // Act
      final String? result = validator.validate(validHex);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the color code is a valid RGB', () {
      // Arrange
      final ColorCodeValidator validator = ColorCodeValidator();
      const String validRgb = 'rgb(255, 0, 0)';

      // Act
      final String? result = validator.validate(validRgb);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the color code is a valid HSL', () {
      // Arrange
      final ColorCodeValidator validator = ColorCodeValidator();
      const String validHsl = 'hsl(120, 100%, 50%)';

      // Act
      final String? result = validator.validate(validHsl);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the color code is invalid',
        () {
      // Arrange
      final ColorCodeValidator validator = ColorCodeValidator();
      const String invalidColor = 'invalid-color';

      // Act
      final String? result = validator.validate(invalidColor);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.colorCodeErrorText('hex, rgb, hsl'),
        ),
      );
    });

    test('should return the custom error message if the color code is invalid',
        () {
      // Arrange
      final ColorCodeValidator validator =
          ColorCodeValidator(errorText: customErrorMessage);
      const String invalidColor = 'invalid-color';

      // Act
      final String? result = validator.validate(invalidColor);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      final ColorCodeValidator validator =
          ColorCodeValidator(checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      final ColorCodeValidator validator = ColorCodeValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.colorCodeErrorText('hex, rgb, hsl'),
        ),
      );
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      final ColorCodeValidator validator =
          ColorCodeValidator(checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is an empty string',
        () {
      // Arrange
      final ColorCodeValidator validator = ColorCodeValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.colorCodeErrorText('hex, rgb, hsl'),
        ),
      );
    });

    test('should return null if the color code matches custom regex', () {
      // Arrange
      final ColorCodeValidator validator = ColorCodeValidator(
        regex: RegExp(r'^[A-Fa-f0-9]{6}$'),
        formats: <String>[],
      );
      const String validCustomColor = '1A2B3C';

      // Act
      final String? result = validator.validate(validCustomColor);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the custom error message if the color code does not match custom regex',
        () {
      // Arrange
      final ColorCodeValidator validator = ColorCodeValidator(
        regex: RegExp(r'^[A-Fa-f0-9]{6}$'),
        formats: <String>[],
        errorText: customErrorMessage,
      );
      const String invalidCustomColor = 'invalid';

      // Act
      final String? result = validator.validate(invalidCustomColor);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
