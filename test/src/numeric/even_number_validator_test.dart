import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Even number -', () {
    test('should return null when the value is not null', () {
      // Arrange
      final EvenNumberValidator validator = EvenNumberValidator();
      const int value = 2;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the error message when the value is null', () {
      // Arrange
      final EvenNumberValidator validator =
          EvenNumberValidator(errorText: customErrorMessage);
      const int? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
