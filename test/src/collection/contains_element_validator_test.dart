import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Contains element -', () {
    test('should return error when the value is an empty list', () {
      // Arrange
      const List<String> list = <String>[];
      const ContainsElementValidator<String> validator =
          ContainsElementValidator<String>(list);

      // Act
      final String? result = validator.validate('a');

      // Assert
      expect(result, isNotNull);
    });

    test('should return null when the value is in the list', () {
      // Arrange
      const List<String> list = <String>['a', 'b', 'c'];
      const ContainsElementValidator<String> validator =
          ContainsElementValidator<String>(list);

      // Act
      final String? result = validator.validate('b');

      // Assert
      expect(result, isNull);
    });

    test(
      'should return custom error message when the value is not in the list',
      () {
        // Arrange
        const List<String> list = <String>['a', 'b', 'c'];
        final ContainsElementValidator<String> validator =
            ContainsElementValidator<String>(
              list,
              errorText: customErrorMessage,
            );

        // Act
        final String? result = validator.validate('d');

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return null when the value is null and null check is disabled',
      () {
        // Arrange
        const List<String> list = <String>['a', 'b', 'c'];
        const ContainsElementValidator<String> validator =
            ContainsElementValidator<String>(list, checkNullOrEmpty: false);

        // Act
        final String? result = validator.validate(null);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return default error message when the value is not in the list',
      () {
        // Arrange
        const List<String> list = <String>['a', 'b', 'c'];
        const ContainsElementValidator<String> validator =
            ContainsElementValidator<String>(list);

        // Act
        final String? result = validator.validate('d');

        // Assert
        expect(result, isNotNull);
      },
    );
  });
}
