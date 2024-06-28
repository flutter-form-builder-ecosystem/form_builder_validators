import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Unique -', () {
    test('should return null when the value is unique', () {
      // Arrange
      const UniqueValidator validator = UniqueValidator();
      const List<String> value = <String>['a', 'b', 'c'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the error message when the value is not unique', () {
      // Arrange
      final UniqueValidator validator =
          UniqueValidator(errorText: customErrorMessage);
      const List<String> value = <String>['a', 'b', 'a'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
