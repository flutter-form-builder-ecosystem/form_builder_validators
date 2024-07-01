import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MinWordsCountValidator -', () {
    test(
        'should return null if the value has the exact minimum number of words',
        () {
      // Arrange
      const int minWordsCount = 3;
      const MinWordsCountValidator validator =
          MinWordsCountValidator(minWordsCount);
      const String value = 'one two three';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return null if the value has more than the minimum number of words',
        () {
      // Arrange
      const int minWordsCount = 3;
      const MinWordsCountValidator validator =
          MinWordsCountValidator(minWordsCount);
      const String value = 'one two three four';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value has fewer than the minimum number of words',
        () {
      // Arrange
      const int minWordsCount = 3;
      const MinWordsCountValidator validator =
          MinWordsCountValidator(minWordsCount);
      const String value = 'one two';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current
              .minWordsCountErrorText(minWordsCount),
        ),
      );
    });

    test(
        'should return the custom error message if the value has fewer than the minimum number of words',
        () {
      // Arrange
      const int minWordsCount = 3;
      final MinWordsCountValidator validator =
          MinWordsCountValidator(minWordsCount, errorText: customErrorMessage);
      const String value = 'one two';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });

    test('should return null if the value is null and null check is disabled',
        () {
      // Arrange
      const int minWordsCount = 3;
      const MinWordsCountValidator validator =
          MinWordsCountValidator(minWordsCount, checkNullOrEmpty: false);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the default error message if the value is null', () {
      // Arrange
      const int minWordsCount = 3;
      const MinWordsCountValidator validator =
          MinWordsCountValidator(minWordsCount);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current
              .minWordsCountErrorText(minWordsCount),
        ),
      );
    });

    test(
        'should return null if the value is an empty string and null check is disabled',
        () {
      // Arrange
      const int minWordsCount = 3;
      const MinWordsCountValidator validator =
          MinWordsCountValidator(minWordsCount, checkNullOrEmpty: false);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the default error message if the value is an empty string',
        () {
      // Arrange
      const int minWordsCount = 3;
      const MinWordsCountValidator validator =
          MinWordsCountValidator(minWordsCount);
      const String value = '';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current
              .minWordsCountErrorText(minWordsCount),
        ),
      );
    });
  });
}
