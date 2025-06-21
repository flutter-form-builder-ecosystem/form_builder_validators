import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  const String substring = 'test';

  group('ContainsValidator -', () {
    test(
      'should return null if the value contains the substring (case sensitive)',
      () {
        // Arrange
        const ContainsValidator validator = ContainsValidator(substring);
        const String value = 'This is a test string.';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message if the value does not contain the substring (case sensitive)',
      () {
        // Arrange
        const ContainsValidator validator = ContainsValidator(substring);
        const String value = 'This is a Test string.';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.containsErrorText(substring)),
        );
      },
    );

    test(
      'should return null if the value contains the substring (case insensitive)',
      () {
        // Arrange
        const ContainsValidator validator = ContainsValidator(
          substring,
          caseSensitive: false,
        );
        const String value = 'This is a Test string.';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message if the value does not contain the substring (case insensitive)',
      () {
        // Arrange
        const ContainsValidator validator = ContainsValidator(
          substring,
          caseSensitive: false,
        );
        const String value = 'This is a string.';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.containsErrorText(substring)),
        );
      },
    );

    test(
      'should return the custom error message if the value does not contain the substring (case sensitive)',
      () {
        // Arrange
        final ContainsValidator validator = ContainsValidator(
          substring,
          errorText: customErrorMessage,
        );
        const String value = 'This is a Test string.';

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
        const ContainsValidator validator = ContainsValidator(
          substring,
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
      const ContainsValidator validator = ContainsValidator(substring);
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.containsErrorText(substring)),
      );
    });

    test(
      'should return null if the value is an empty string and null check is disabled',
      () {
        // Arrange
        const ContainsValidator validator = ContainsValidator(
          substring,
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
        const ContainsValidator validator = ContainsValidator(substring);
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.containsErrorText(substring)),
        );
      },
    );

    test(
      'should return the error message if the substring is an empty string',
      () {
        // Arrange
        const ContainsValidator validator = ContainsValidator('');
        const String value = 'test';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(validator.errorText));
      },
    );
  });
}
