import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Date future -', () {
    test('should return null when the date is in the future', () {
      // Arrange
      const DateFutureValidator validator = DateFutureValidator();
      final DateTime futureDate = DateTime.now().add(const Duration(days: 1));
      final String value = futureDate.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message when the date is in the past',
      () {
        // Arrange
        const DateFutureValidator validator = DateFutureValidator();
        final DateTime pastDate = DateTime.now().subtract(
          const Duration(days: 1),
        );
        final String value = pastDate.toIso8601String();

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.dateMustBeInTheFutureErrorText,
          ),
        );
      },
    );

    test(
      'should return the custom error message when the date is in the past',
      () {
        // Arrange
        final DateFutureValidator validator = DateFutureValidator(
          errorText: customErrorMessage,
        );
        final DateTime pastDate = DateTime.now().subtract(
          const Duration(days: 1),
        );
        final String value = pastDate.toIso8601String();

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test('should return error when the date is today', () {
      // Arrange
      const DateFutureValidator validator = DateFutureValidator();
      final DateTime today = DateTime.now();
      final String value = today.toIso8601String();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNotNull);
    });

    test(
      'should return null when the value is null and null check is disabled',
      () {
        // Arrange
        const DateFutureValidator validator = DateFutureValidator(
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
      const DateFutureValidator validator = DateFutureValidator();
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(
        result,
        equals(FormBuilderLocalizations.current.dateMustBeInTheFutureErrorText),
      );
    });

    test(
      'should return null when the value is an empty string and null check is disabled',
      () {
        // Arrange
        const DateFutureValidator validator = DateFutureValidator(
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
        const DateFutureValidator validator = DateFutureValidator();
        const String value = '';

        // Act
        final String? result = validator.validate(value);

        // Assert
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.dateMustBeInTheFutureErrorText,
          ),
        );
      },
    );
  });
}
