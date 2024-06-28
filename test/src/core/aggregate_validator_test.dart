import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/base_validator.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Aggregate -', () {
    test('should return null when all validators return null', () {
      // Arrange
      const AggregateValidator validator = AggregateValidator(validators: <IsTrueValidator>[
        IsTrueValidator(),
        IsTrueValidator(),
      ],);
      const bool value = true;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the error message when one validator returns an error',
        () {
      // Arrange
      final AggregateValidator validator = AggregateValidator(
        validators: <BaseValidator<bool>>[
          const IsTrueValidator(),
          IsFalseValidator(errorText: customErrorMessage),
        ],
      );
      const bool value = true;

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
