import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as val;

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('Validator: notMatch', () {
    test('should return null if the value does not match the regex', () {
      // Arrange
      final Validator<String> validator = val.notMatch(RegExp(r'^[a-zA-Z]+$'));
      const String value = '123123';

      // Act
      final String? result = validator(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message if the value matches the regex',
      () {
        // Arrange
        final Validator<String> validator = val.notMatch(
          RegExp(r'^[a-zA-Z]+$'),
        );
        const String value = 'abcd';

        // Act
        final String? result = validator(value);

        // Assert
        expect(
          result,
          equals(FormBuilderLocalizations.current.notMatchErrorText),
        );
      },
    );

    test(
      'should return the custom error message if the value matches the regex',
      () {
        // Arrange
        final Validator<String> validator = val.notMatch(
          RegExp(r'^[a-zA-Z]+$'),
          notMatchMsg: (_) => customErrorMessage,
        );
        const String value = 'abcABC';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );
  });
}
