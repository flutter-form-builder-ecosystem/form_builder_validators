import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  const String suffix = 'end';

  group('EndsWithValidator -', () {
    test('should return null if the value ends with the suffix', () {
      // Arrange
      const EndsWithValidator validator = EndsWithValidator(suffix);
      const String value = 'This is the end';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value does not end with the suffix',
        () {
      // Arrange
      const EndsWithValidator validator = EndsWithValidator(suffix);
      const String value = 'This is the start';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.endsWithErrorText(suffix)),
      );
    });

    test(
        'should return the custom error message if the value does not end with the suffix',
        () {
      // Arrange
      final EndsWithValidator validator =
          EndsWithValidator(suffix, errorText: customErrorMessage);
      const String value = 'This is the start';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const EndsWithValidator validator =
          EndsWithValidator(suffix, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const EndsWithValidator validator = EndsWithValidator(suffix);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.endsWithErrorText(suffix)),
      );
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      const EndsWithValidator validator =
          EndsWithValidator(suffix, checkNullOrEmpty: false);
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
      const EndsWithValidator validator = EndsWithValidator(suffix);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.endsWithErrorText(suffix)),
      );
    });
  });
}
