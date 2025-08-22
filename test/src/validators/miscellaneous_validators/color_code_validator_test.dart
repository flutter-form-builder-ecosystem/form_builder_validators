import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('ColorCodeValidator -', () {
    test('should return null if the color code is a valid hex', () {
      // Arrange
      final Validator<String> validator = colorCode();
      const String validHex = '#1a2b3c';

      // Act
      final String? result = validator(validHex);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the color code is a valid RGB', () {
      // Arrange
      final Validator<String> validator = colorCode();
      const String validRgb = 'rgb(255, 0, 0)';

      // Act
      final String? result = validator(validRgb);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the color code is a valid HSL', () {
      // Arrange
      final Validator<String> validator = colorCode();
      const String validHsl = 'hsl(120, 100%, 50%)';

      // Act
      final String? result = validator(validHsl);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message if the color code is invalid',
      () {
        // Arrange
        final Validator<String> validator = colorCode();
        const String invalidColor = 'invalid-color';

        // Act
        final String? result = validator(invalidColor);

        // Assert
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.colorCodeErrorText(
              'HEX, RGB, HSL',
            ),
          ),
        );
      },
    );

    test(
      'should return the custom error message if the color code is invalid',
      () {
        // Arrange
        final Validator<String> validator = colorCode(
          colorCodeMsg: (_) => customErrorMessage,
        );
        const String invalidColor = 'invalid-color';

        // Act
        final String? result = validator(invalidColor);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test('should return null if the color code matches custom regex', () {
      // Arrange
      final Validator<String> validator = colorCode(
        customColorCode: (String input) =>
            RegExp(r'^[A-Fa-f0-9]{6}$').hasMatch(input),
      );
      const String validCustomColor = '1A2B3C';

      // Act
      final String? result = validator(validCustomColor);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the custom error message if the color code does not match custom regex',
      () {
        // Arrang
        final Validator<String> validator = colorCode(
          customColorCode: (String input) =>
              RegExp(r'^[A-Fa-f0-9]{6}$').hasMatch(input),
          colorCodeMsg: (_) => customErrorMessage,
        );

        const String invalidCustomColor = 'invalid';

        // Act
        final String? result = validator(invalidCustomColor);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );
  });
}
