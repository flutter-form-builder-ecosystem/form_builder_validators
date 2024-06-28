import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Has special chars -', () {
    test('should return null when the value has at least 1 special character',
        () {
      // Arrange
      final HasSpecialCharsValidator validator = HasSpecialCharsValidator();
      const String value = 'abc!@#';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value has at least 3 special characters',
        () {
      // Arrange
      final HasSpecialCharsValidator validator =
          HasSpecialCharsValidator(atLeast: 3);
      const String value = 'a!b@c#';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error message when the value has no special characters',
        () {
      // Arrange
      final HasSpecialCharsValidator validator =
          HasSpecialCharsValidator(errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the error message when the value has less than 3 special characters',
        () {
      // Arrange
      final HasSpecialCharsValidator validator =
          HasSpecialCharsValidator(atLeast: 3, errorText: customErrorMessage);
      const String value = 'a!b';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
