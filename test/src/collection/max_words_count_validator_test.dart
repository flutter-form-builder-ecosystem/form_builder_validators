import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Max words count -', () {
    test(
        'should return null when the value has the same number of words as the target',
        () {
      // Arrange
      const MaxWordsCountValidator validator =
          MaxWordsCountValidator(maxWordsCount: 3);
      const String value = 'abc def ghi';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null when the value has a smaller number of words than the target',
        () {
      // Arrange
      const MaxWordsCountValidator validator =
          MaxWordsCountValidator(maxWordsCount: 3);
      const String value = 'ab cd';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error message when the value has a greater number of words',
        () {
      // Arrange
      final MaxWordsCountValidator validator = MaxWordsCountValidator(
          maxWordsCount: 3, errorText: customErrorMessage,);
      const String value = 'abcd efgh ijkl';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
