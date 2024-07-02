import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('OrValidator -', () {
    test('should return null if at least one validator passes', () {
      // Arrange
      final OrValidator<String> validator =
          OrValidator<String>(<FormFieldValidator<String>>[
        FormBuilderValidators.minLength(5, errorText: 'Min length error'),
        FormBuilderValidators.email(errorText: 'Email error'),
      ]);
      const String value = 'test@example.com';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error if all validators fail', () {
      // Arrange
      final OrValidator<String> validator = OrValidator<String>(
        <FormFieldValidator<String>>[
          FormBuilderValidators.minLength(5, errorText: 'Min length error'),
          FormBuilderValidators.email(errorText: customErrorMessage),
        ],
      );
      const String value = 'abc';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if at least one custom validator passes', () {
      // Arrange
      final OrValidator<String> validator =
          OrValidator<String>(<FormFieldValidator<String>>[
        (String? value) => value != null && value.contains('test')
            ? null
            : 'Contains "test" error',
        (String? value) => value != null && value.length > 10
            ? null
            : 'Length greater than 10 error',
      ]);
      const String value = 'test_value';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return error if all custom validators fail', () {
      // Arrange
      final OrValidator<String> validator = OrValidator<String>(
        <FormFieldValidator<String>>[
          (String? value) => value != null && value.contains('test')
              ? null
              : 'Contains "test" error',
          (String? value) =>
              value != null && value.length > 10 ? null : customErrorMessage,
        ],
      );
      const String value = 'value';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, customErrorMessage);
    });

    test('should return null if at least one integer validator passes', () {
      // Arrange
      final OrValidator<int> validator =
          OrValidator<int>(<FormFieldValidator<int>>[
        FormBuilderValidators.min(5, errorText: 'Min error'),
        FormBuilderValidators.max(10, errorText: 'Max error'),
      ]);
      const int value = 7;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null if at least one double validator passes', () {
      // Arrange
      final OrValidator<double> validator =
          OrValidator<double>(<FormFieldValidator<double>>[
        FormBuilderValidators.min(5.0, errorText: 'Min error'),
        FormBuilderValidators.max(10.0, errorText: 'Max error'),
      ]);
      const double value = 7;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });
  });
}
