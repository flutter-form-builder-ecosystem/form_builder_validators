import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Min words count -', () {
    test('should return null when the value has the minimum words count', () {
      // Arrange
      const MinWordsCountValidator validator = MinWordsCountValidator(count: 3);
      const String value = 'a b c';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the value has more than the minimum words count',
        () {
      // Arrange
      const MinWordsCountValidator validator = MinWordsCountValidator(count: 3);
      const String value = 'a b c d';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error message when the value has less than the minimum words count',
        () {
      // Arrange
      final MinWordsCountValidator validator =
          MinWordsCountValidator(count: 3, errorText: customErrorMessage);
      const String value = 'a b';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
