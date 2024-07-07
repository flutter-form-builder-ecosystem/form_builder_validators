import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('StartsWithValidator -', () {
    test('should return null if the value starts with the given prefix', () {
      // Arrange
      const String prefix = 'start';
      const StartsWithValidator validator = StartsWithValidator(prefix);
      const String value = 'startOfString';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value does not start with the given prefix',
        () {
      // Arrange
      const String prefix = 'start';
      const StartsWithValidator validator = StartsWithValidator(prefix);
      const String value = 'endOfString';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.startsWithErrorText(prefix)),
      );
    });

    test(
        'should return the custom error message if the value does not start with the given prefix',
        () {
      // Arrange
      const String prefix = 'start';
      final StartsWithValidator validator =
          StartsWithValidator(prefix, errorText: customErrorMessage);
      const String value = 'endOfString';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const String prefix = 'start';
      const StartsWithValidator validator =
          StartsWithValidator(prefix, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const String prefix = 'start';
      const StartsWithValidator validator = StartsWithValidator(prefix);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.startsWithErrorText(prefix)),
      );
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      const String prefix = 'start';
      const StartsWithValidator validator =
          StartsWithValidator(prefix, checkNullOrEmpty: false);
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
      const String prefix = 'start';
      const StartsWithValidator validator = StartsWithValidator(prefix);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.startsWithErrorText(prefix)),
      );
    });
  });
}
