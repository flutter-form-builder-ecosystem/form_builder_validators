import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Contains element -', () {
    test('should return null when the value contains the element', () {
      // Arrange
      const ContainsElementValidator validator =
          ContainsElementValidator(element: 'a');
      const List<String> value = <String>['a', 'b', 'c'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error message when the value does not contain the element',
        () {
      // Arrange
      final ContainsElementValidator validator =
          ContainsElementValidator(element: 'a', errorText: customErrorMessage);
      const List<String> value = <String>['b', 'c'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
