import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/base_validator.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Compose -', () {
    test('should return null when all validators return null', () {
      // Arrange
      const ComposeValidator validator = ComposeValidator(
        validators: <BaseValidator>[
          EqualLengthValidator(length: 3),
          UniqueValidator(),
          IsFalseValidator(),
          IsTrueValidator(),
        ],
      );
      const List<String> value = <String>['a', 'b', 'c'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error message when one of the validators returns an error message',
        () {
      // Arrange
      final ComposeValidator validator = ComposeValidator(
        validators: <BaseValidator>[
          const EqualLengthValidator(length: 3),
          const UniqueValidator(),
          const IsFalseValidator(),
          const IsTrueValidator(),
        ],
        errorText: customErrorMessage,
      );
      const List<String> value = <String>['a', 'b', 'a'];

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
