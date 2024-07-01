import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('TransformValidator -', () {
    test('should return null if the transformed value is valid', () {
      // Arrange
      final TransformValidator<String> validator = TransformValidator<String>(
        (String? value) => value!.trim(),
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = '  valid  ';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the transformed value is invalid', () {
      // Arrange
      final TransformValidator<String> validator = TransformValidator<String>(
        (String? value) => value!.trim(),
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String value = '   ';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the transformed non-string value is valid', () {
      // Arrange
      final TransformValidator<int> validator = TransformValidator<int>(
        (int? value) => value! * 2,
        (int? value) => value != null && value > 10 ? null : customErrorMessage,
      );
      const int value = 6;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error if the transformed non-string value is invalid',
        () {
      // Arrange
      final TransformValidator<int> validator = TransformValidator<int>(
        (int? value) => value! * 2,
        (int? value) => value != null && value > 10 ? null : customErrorMessage,
      );
      const int value = 4;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return error if the value is null', () {
      // Arrange
      final TransformValidator<String?> validator = TransformValidator<String?>(
        (String? value) => value ?? '',
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      const String? value = null;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if the transformed value matches the condition',
        () {
      // Arrange
      final TransformValidator<String> validator = TransformValidator<String>(
        (String? value) => value!.toUpperCase(),
        FormBuilderValidators.equal('HELLO', errorText: customErrorMessage),
      );
      const String value = 'hello';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return error if the transformed value does not match the condition',
        () {
      // Arrange
      final TransformValidator<String> validator = TransformValidator<String>(
        (String? value) => value!.toUpperCase(),
        FormBuilderValidators.equal('HELLO', errorText: customErrorMessage),
      );
      const String value = 'world';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });
  });
}
