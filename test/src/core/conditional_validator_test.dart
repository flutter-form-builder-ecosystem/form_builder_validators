import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Conditional -', () {
    test('should return null when the condition is true', () {
      // Arrange
      final ConditionalValidator validator = ConditionalValidator(
        condition: () => true,
        errorText: customErrorMessage,
      );
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the error message when the condition is false', () {
      // Arrange
      final ConditionalValidator validator = ConditionalValidator(
        condition: () => false,
        errorText: customErrorMessage,
      );
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
