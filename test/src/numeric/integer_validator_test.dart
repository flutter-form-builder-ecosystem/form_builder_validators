import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('IntegerValidator -', () {
    test('should return null if the value is a valid integer', () {
      // Arrange
      const IntegerValidator validator = IntegerValidator();
      const String value = '123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the value is a valid integer with radix 16',
        () {
      // Arrange
      const IntegerValidator validator = IntegerValidator(radix: 16);
      const String value = '7B';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is not an integer',
        () {
      // Arrange
      const IntegerValidator validator = IntegerValidator();
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.integerErrorText,
        ),
      );
    });

    test(
        'should return the custom error message if the value is not an integer',
        () {
      // Arrange
      final IntegerValidator validator = IntegerValidator(
        errorText: customErrorMessage,
      );
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      const IntegerValidator validator = IntegerValidator(
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message when the value is null', () {
      // Arrange
      const IntegerValidator validator = IntegerValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.integerErrorText,
        ),
      );
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      const IntegerValidator validator = IntegerValidator(
        checkNullOrEmpty: false,
      );
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message when the value is an empty string',
        () {
      // Arrange
      const IntegerValidator validator = IntegerValidator();
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.integerErrorText,
        ),
      );
    });

    test('should return null if the value is a valid negative integer', () {
      // Arrange
      const IntegerValidator validator = IntegerValidator();
      const String value = '-123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null if the value is a valid integer with leading zeros',
        () {
      // Arrange
      const IntegerValidator validator = IntegerValidator();
      const String value = '00123';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
