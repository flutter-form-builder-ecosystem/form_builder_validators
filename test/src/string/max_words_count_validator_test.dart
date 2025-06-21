import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MaxWordsCountValidator -', () {
    test(
      'should return null if the value has the exact maximum number of words',
      () {
        // Arrange
        const int maxWordsCount = 5;
        const MaxWordsCountValidator validator = MaxWordsCountValidator(
          maxWordsCount,
        );
        const String value = 'one two three four five';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return null if the value has fewer than the maximum number of words',
      () {
        // Arrange
        const int maxWordsCount = 5;
        const MaxWordsCountValidator validator = MaxWordsCountValidator(
          maxWordsCount,
        );
        const String value = 'one two three';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message if the value has more than the maximum number of words',
      () {
        // Arrange
        const int maxWordsCount = 5;
        const MaxWordsCountValidator validator = MaxWordsCountValidator(
          maxWordsCount,
        );
        const String value = 'one two three four five six';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.maxWordsCountErrorText(
              maxWordsCount,
            ),
          ),
        );
      },
    );

    test(
      'should return the custom error message if the value has more than the maximum number of words',
      () {
        // Arrange
        const int maxWordsCount = 5;
        final MaxWordsCountValidator validator = MaxWordsCountValidator(
          maxWordsCount,
          errorText: customErrorMessage,
        );
        const String value = 'one two three four five six';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return null if the value is null and null check is disabled',
      () {
        // Arrange
        const int maxWordsCount = 5;
        const MaxWordsCountValidator validator = MaxWordsCountValidator(
          maxWordsCount,
          checkNullOrEmpty: false,
        );
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test('should return the default error message if the value is null', () {
      // Arrange
      const int maxWordsCount = 5;
      const MaxWordsCountValidator validator = MaxWordsCountValidator(
        maxWordsCount,
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.maxWordsCountErrorText(
            maxWordsCount,
          ),
        ),
      );
    });

    test(
      'should return null if the value is an empty string and null check is disabled',
      () {
        // Arrange
        const int maxWordsCount = 5;
        const MaxWordsCountValidator validator = MaxWordsCountValidator(
          maxWordsCount,
          checkNullOrEmpty: false,
        );
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message if the value is an empty string',
      () {
        // Arrange
        const int maxWordsCount = 5;
        const MaxWordsCountValidator validator = MaxWordsCountValidator(
          maxWordsCount,
        );
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.maxWordsCountErrorText(
              maxWordsCount,
            ),
          ),
        );
      },
    );
  });
}
