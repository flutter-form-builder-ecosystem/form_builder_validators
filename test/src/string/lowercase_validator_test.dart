import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('LowercaseValidator -', () {
    test('should return null if the value is in lowercase', () {
      // Arrange
      const LowercaseValidator validator = LowercaseValidator();
      const String value = 'this is lowercase';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message if the value is not in lowercase',
      () {
        // Arrange
        const LowercaseValidator validator = LowercaseValidator();
        const String value = 'This is Not Lowercase';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.lowercaseErrorText),
        );
      },
    );

    test(
      'should return the custom error message if the value is not in lowercase',
      () {
        // Arrange
        final LowercaseValidator validator = LowercaseValidator(
          errorText: customErrorMessage,
        );
        const String value = 'This is Not Lowercase';

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
        const LowercaseValidator validator = LowercaseValidator(
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
      const LowercaseValidator validator = LowercaseValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.lowercaseErrorText),
      );
    });

    test(
      'should return null if the value is an empty string and null check is disabled',
      () {
        // Arrange
        const LowercaseValidator validator = LowercaseValidator(
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
        const LowercaseValidator validator = LowercaseValidator();
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.lowercaseErrorText),
        );
      },
    );
  });
}
