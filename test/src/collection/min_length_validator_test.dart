import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Min length -', () {
    test('should return null when the value has the minimum length', () {
      // Arrange
      const MinLengthValidator validator = MinLengthValidator(length: 3);
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value has more than the minimum length',
        () {
      // Arrange
      const MinLengthValidator validator = MinLengthValidator(length: 3);
      const String value = 'abcd';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error message when the value has less than the minimum length',
        () {
      // Arrange
      final MinLengthValidator validator =
          MinLengthValidator(length: 3, errorText: customErrorMessage);
      const String value = 'ab';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
