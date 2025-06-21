import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('UppercaseValidator -', () {
    test('should return null if the value is in uppercase', () {
      // Arrange
      const UppercaseValidator validator = UppercaseValidator();
      const String value = 'UPPERCASE';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message if the value is not in uppercase',
      () {
        // Arrange
        const UppercaseValidator validator = UppercaseValidator();
        const String value = 'lowercase';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.uppercaseErrorText),
        );
      },
    );

    test(
      'should return the custom error message if the value is not in uppercase',
      () {
        // Arrange
        final UppercaseValidator validator = UppercaseValidator(
          errorText: customErrorMessage,
        );
        const String value = 'lowercase';

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
        const UppercaseValidator validator = UppercaseValidator(
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
      const UppercaseValidator validator = UppercaseValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.uppercaseErrorText),
      );
    });

    test(
      'should return null if the value is an empty string and null check is disabled',
      () {
        // Arrange
        const UppercaseValidator validator = UppercaseValidator(
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
        const UppercaseValidator validator = UppercaseValidator();
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.uppercaseErrorText),
        );
      },
    );

    test(
      'should return null if the value is a mixed case string converted to uppercase',
      () {
        // Arrange
        const UppercaseValidator validator = UppercaseValidator();
        final String value = 'MixedCase'.toUpperCase();

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, isNull);
      },
    );
  });
}
