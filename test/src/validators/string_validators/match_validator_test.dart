import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/validators/validators.dart' as val;

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('MatchValidator -', () {
    test('should return null if the value matches the regex', () {
      // Arrange
      final Validator<String> validator = val.match(RegExp(r'^[a-zA-Z]+$'));
      const String value = 'abcdef';

      // Act
      final String? result = validator(value);

      // Assert
      expect(result, isNull);
    });

    test(
      'should return the default error message if the value does not match the regex',
      () {
        // Arrange
        final Validator<String> validator = val.match(RegExp(r'^[a-zA-Z]+$'));
        const String value = '12345';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(FormBuilderLocalizations.current.matchErrorText));
      },
    );

    test(
      'should return the custom error message if the value does not match the regex',
      () {
        // Arrange
        final Validator<String> validator = val.match(
          RegExp(r'^[a-zA-Z]+$'),
          matchMsg: (_) => customErrorMessage,
        );
        const String value = '12345';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return the default error message if the value is an empty string',
      () {
        // Arrange
        final Validator<String> validator = val.match(RegExp(r'^[a-zA-Z]+$'));
        const String value = '';

        // Act
        final String? result = validator(value);

        // Assert
        expect(result, equals(FormBuilderLocalizations.current.matchErrorText));
      },
    );
  });
}
