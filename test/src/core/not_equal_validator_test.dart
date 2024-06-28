import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Not equal -', () {
    test('should return null when the value is not equal', () {
      // Arrange
      const NotEqualValidator validator = NotEqualValidator('a');
      const String value = 'b';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the error message when the value is equal', () {
      // Arrange
      final NotEqualValidator validator =
          NotEqualValidator('a', errorText: customErrorMessage);
      const String value = 'a';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
