import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Or -', () {
    test('should return null when the value is valid for the first validator',
        () {
      // Arrange
      const OrValidator validator = OrValidator(<FormFieldValidator>[
        EqualValidator('a'),
        EqualValidator('b'),
      ]);
      const String value = 'a';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return null when the value is valid for the second validator',
        () {
      // Arrange
      const OrValidator validator = OrValidator(<FormFieldValidator>[
        EqualValidator('a'),
        EqualValidator('b'),
      ]);
      const String value = 'b';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test(
        'should return the error message when the value is not valid for any validator',
        () {
      // Arrange
      const OrValidator validator = OrValidator(<FormFieldValidator>[
        EqualValidator('a'),
        EqualValidator('b'),
      ]);
      const String value = 'c';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals('Invalid value'));
    });

    test(
        'should return the custom error message when the value is not valid for any validator',
        () {
      // Arrange
      final OrValidator validator = OrValidator(
        <FormFieldValidator>[
          const EqualValidator('a'),
          const EqualValidator('b'),
        ],
        errorText: customErrorMessage,
      );
      const String value = 'c';

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
