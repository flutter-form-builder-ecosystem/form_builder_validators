import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Has lowercase chars -', () {
    test('should return null when the value has at least 1 lowercase character',
        () {
      final HasLowercaseCharsValidator validator = HasLowercaseCharsValidator();
      final String? result = validator.validate('Password123');
      expect(result, isNull);
    });

    test(
        'should return null when the value has at least 3 lowercase characters',
        () {
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(atLeast: 3);
      final String? result = validator.validate('paSsword123');
      expect(result, isNull);
    });

    test(
        'should return the custom error message when the value does not have any lowercase characters',
        () {
      final HasLowercaseCharsValidator validator =
          HasLowercaseCharsValidator(errorText: customErrorMessage);
      final String? result = validator.validate('PASSWORD123');
      expect(result, equals(customErrorMessage));
    });

    test(
        'should return the default error message when the value does not have any lowercase characters',
        () {
      final HasLowercaseCharsValidator validator = HasLowercaseCharsValidator();
      final String? result = validator.validate('PASSWORD123');
      expect(
        result,
        equals(
          FormBuilderLocalizations.current.containsLowercaseCharErrorText(1),
        ),
      );
    });

    test(
      'should return null when the value has exactly 1 lowercase character',
      () {
        final HasLowercaseCharsValidator validator =
            HasLowercaseCharsValidator();
        final String? result = validator.validate('Password');
        expect(result, isNull);
      },
    );

    test(
      'should return the custom error message when the value does not have enough lowercase characters',
      () {
        final HasLowercaseCharsValidator validator = HasLowercaseCharsValidator(
          atLeast: 2,
          errorText: customErrorMessage,
        );
        final String? result = validator.validate('PASSWORD');
        expect(result, equals(customErrorMessage));
      },
    );

    test(
      'should return the default error message when the value does not have enough lowercase characters',
      () {
        final HasLowercaseCharsValidator validator =
            HasLowercaseCharsValidator(atLeast: 2);
        final String? result = validator.validate('PASSWORD');
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.containsLowercaseCharErrorText(2),
          ),
        );
      },
    );

    test(
      'should return the default error message when the value is an empty string',
      () {
        final HasLowercaseCharsValidator validator =
            HasLowercaseCharsValidator();
        final String? result = validator.validate('');
        expect(
          result,
          FormBuilderLocalizations.current.containsLowercaseCharErrorText(1),
        );
      },
    );

    test(
      'should return null when the value is an empty string',
      () {
        final HasLowercaseCharsValidator validator =
            HasLowercaseCharsValidator(checkNullOrEmpty: false);
        final String? result = validator.validate('');
        expect(result, isNull);
      },
    );

    test(
      'should return null when the value is null',
      () {
        final HasLowercaseCharsValidator validator =
            HasLowercaseCharsValidator(checkNullOrEmpty: false);
        final String? result = validator.validate(null);
        expect(result, isNull);
      },
    );
  });
}
