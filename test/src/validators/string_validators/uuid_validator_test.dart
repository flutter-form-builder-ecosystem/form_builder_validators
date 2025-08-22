import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/src/validators/validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Validator: uuid', () {
    test('should return null if the UUID is valid', () {
      // Arrange
      final Validator<String> validator = uuid(
        uuidMsg: (_) => customErrorMessage,
      );
      const String validUuid = '123e4567-e89b-12d3-a456-426614174000';

      // Act
      final String? result = validator(validUuid);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the UUID is invalid', () {
      // Arrange
      final Validator<String> validator = uuid(
        uuidMsg: (_) => customErrorMessage,
      );
      const String invalidUuid = 'invalid-uuid';

      // Act
      final String? result = validator(invalidUuid);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the UUID is too short', () {
      // Arrange
      final Validator<String> validator = uuid(
        uuidMsg: (_) => customErrorMessage,
      );
      const String shortUuid = '123e4567-e89b-12d3-a456-426614174';

      // Act
      final String? result = validator(shortUuid);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the UUID is too long', () {
      // Arrange
      final Validator<String> validator = uuid(
        uuidMsg: (_) => customErrorMessage,
      );
      const String longUuid = '123e4567-e89b-12d3-a456-4266141740000000';

      // Act
      final String? result = validator(longUuid);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the UUID has incorrect format', () {
      // Arrange
      final Validator<String> validator = uuid(
        uuidMsg: (_) => customErrorMessage,
      );
      const String invalidFormatUuid = '123e4567-e89b-12d3-456-426614174000';

      // Act
      final String? result = validator(invalidFormatUuid);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the value is empty', () {
      // Arrange
      final Validator<String> validator = uuid(
        uuidMsg: (_) => customErrorMessage,
      );
      const String value = '';

      // Act
      final String? result = validator(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test(
      'should return the default error message if no custom message is set',
      () {
        // Arrange
        final Validator<String> validator = uuid();
        const String invalidUuid = 'invalid-uuid';

        // Act
        final String? result = validator(invalidUuid);

        // Assert
        expect(result, equals(FormBuilderLocalizations.current.uuidErrorText));
      },
    );
  });
}
