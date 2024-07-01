import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('BetweenValidator -', () {
    test('should return null if the value is exactly at the minimum boundary',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      const BetweenValidator validator = BetweenValidator(min, max);
      const num value = 5;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the value is exactly at the maximum boundary',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      const BetweenValidator validator = BetweenValidator(min, max);
      const num value = 10;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the value is within the range', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      const BetweenValidator validator = BetweenValidator(min, max);
      const num value = 7;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is below the minimum boundary',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      const BetweenValidator validator = BetweenValidator(min, max);
      const num value = 4;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.betweenErrorText(min, max),
        ),
      );
    });

    test(
        'should return the default error message if the value is above the maximum boundary',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      const BetweenValidator validator = BetweenValidator(min, max);
      const num value = 11;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.betweenErrorText(min, max),
        ),
      );
    });

    test(
        'should return the custom error message if the value is below the minimum boundary',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final BetweenValidator validator = BetweenValidator(
        min,
        max,
        errorText: customErrorMessage,
      );
      const num value = 4;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the custom error message if the value is above the maximum boundary',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      final BetweenValidator validator = BetweenValidator(
        min,
        max,
        errorText: customErrorMessage,
      );
      const num value = 11;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const num min = 5;
      const num max = 10;
      const BetweenValidator validator = BetweenValidator(
        min,
        max,
        checkNullOrEmpty: false,
      );
      const num? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const num min = 5;
      const num max = 10;
      const BetweenValidator validator = BetweenValidator(min, max);
      const num? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.betweenErrorText(min, max),
        ),
      );
    });
  });
}
