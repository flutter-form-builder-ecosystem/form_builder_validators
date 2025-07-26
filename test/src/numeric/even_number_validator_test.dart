import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('EvenNumberValidator -', () {
    test('should return null if the value is an even number', () {
      // Arrange
      const EvenNumberValidator validator = EvenNumberValidator();
      const String value = '2';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if the value is zero', () {
      // Arrange
      const EvenNumberValidator validator = EvenNumberValidator();
      const String value = '0';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message if the value is an odd number',
      () {
        // Arrange
        const EvenNumberValidator validator = EvenNumberValidator();
        const String value = '3';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.evenNumberErrorText),
        );
      },
    );

    test(
      'should return the custom error message if the value is an odd number',
      () {
        // Arrange
        final EvenNumberValidator validator = EvenNumberValidator(
          errorText: customErrorMessage,
        );
        const String value = '3';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return null when the value is null and null check is disabled',
      () {
        // Arrange
        const EvenNumberValidator validator = EvenNumberValidator(
          checkNullOrEmpty: false,
        );
        const String? value = null;

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );

    test('should return the default error message when the value is null', () {
      // Arrange
      const EvenNumberValidator validator = EvenNumberValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        equals(FormBuilderLocalizations.current.evenNumberErrorText),
      );
    });

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        const EvenNumberValidator validator = EvenNumberValidator(
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
      'should return the default error message when the value is an empty string',
      () {
        // Arrange
        const EvenNumberValidator validator = EvenNumberValidator();
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.evenNumberErrorText),
        );
      },
    );

    test(
      'should return the default error message if the value is not a number',
      () {
        // Arrange
        const EvenNumberValidator validator = EvenNumberValidator();
        const String value = 'abc';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(FormBuilderLocalizations.current.evenNumberErrorText),
        );
      },
    );
  });
}
