import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Has uppercase chars -', () {
    test('should return null when the value has at least 1 uppercase character',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator = HasUppercaseCharsValidator();
      const String value = 'abcA';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the value has at least 3 uppercase characters',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(atLeast: 3);
      const String value = 'aAbBcC';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error message when the value has no uppercase characters',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(errorText: customErrorMessage);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the error message when the value has less than 3 uppercase characters',
        () {
      // Arrange
      final HasUppercaseCharsValidator validator =
          HasUppercaseCharsValidator(atLeast: 3, errorText: customErrorMessage);
      const String value = 'aA';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
