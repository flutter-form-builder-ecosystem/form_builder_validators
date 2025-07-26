import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('SingleLineValidator -', () {
    test('should return null if the value is a single line', () {
      // Arrange
      const SingleLineValidator validator = SingleLineValidator();
      const String value = 'This is a single line';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message if the value contains a newline character',
      () {
        // Arrange
        const SingleLineValidator validator = SingleLineValidator();
        const String value = 'This is a line\nThis is another line';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.singleLineErrorText),
        );
      },
    );

    test(
      'should return the default error message if the value contains a carriage return character',
      () {
        // Arrange
        const SingleLineValidator validator = SingleLineValidator();
        const String value = 'This is a line\rThis is another line';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.singleLineErrorText),
        );
      },
    );

    test(
      'should return the custom error message if the value contains a newline character',
      () {
        // Arrange
        final SingleLineValidator validator = SingleLineValidator(
          errorText: customErrorMessage,
        );
        const String value = 'This is a line\nThis is another line';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return the custom error message if the value contains a carriage return character',
      () {
        // Arrange
        final SingleLineValidator validator = SingleLineValidator(
          errorText: customErrorMessage,
        );
        const String value = 'This is a line\rThis is another line';

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
        const SingleLineValidator validator = SingleLineValidator(
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
      const SingleLineValidator validator = SingleLineValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.singleLineErrorText),
      );
    });

    test(
      'should return null if the value is an empty string and null check is disabled',
      () {
        // Arrange
        const SingleLineValidator validator = SingleLineValidator(
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
        const SingleLineValidator validator = SingleLineValidator();
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.singleLineErrorText),
        );
      },
    );
  });
}
