import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('LogValidator -', () {
    test('should log the valueCandidate if log function is null', () {
      // Arrange
      const LogValidator<String> validator = LogValidator<String>();
      const String value = 'test';

      // Act & Assert
      expect(() => validator.validate(value), prints('test\n'));
    });

    test('should log the custom message from log function', () {
      // Arrange
      final LogValidator<String> validator = LogValidator<String>(
        log: (String? value) => 'Custom log: $value',
      );
      const String value = 'test';

      // Act & Assert
      expect(() => validator.validate(value), prints('Custom log: test\n'));
    });

    test('should log the errorText if valueCandidate is null', () {
      // Arrange
      final LogValidator<String> validator = LogValidator<String>(
        errorText: customErrorMessage,
      );
      const String? value = null;

      // Act & Assert
      expect(() => validator.validate(value), prints('$customErrorMessage\n'));
    });

    test(
        'should log valueCandidate.toString() if log function is null and valueCandidate is not null',
        () {
      // Arrange
      const LogValidator<int> validator = LogValidator<int>();
      const int value = 123;

      // Act & Assert
      expect(() => validator.validate(value), prints('123\n'));
    });

    test('should log the custom message from log function with integer value',
        () {
      // Arrange
      final LogValidator<int> validator = LogValidator<int>(
        log: (int? value) => 'Custom log: $value',
      );
      const int value = 123;

      // Act & Assert
      expect(() => validator.validate(value), prints('Custom log: 123\n'));
    });

    test(
        'should log the errorText if valueCandidate is null with integer value',
        () {
      // Arrange
      final LogValidator<int> validator = LogValidator<int>(
        errorText: customErrorMessage,
      );
      const int? value = null;

      // Act & Assert
      expect(() => validator.validate(value), prints('$customErrorMessage\n'));
    });

    // Additional test to cover debugPrint(errorText);
    test(
        'should log the default errorText if valueCandidate is null and errorText is not provided',
        () {
      // Arrange
      const LogValidator<String> validator = LogValidator<String>();
      const String? value = null;

      // Act & Assert
      expect(() => validator.validate(value),
          prints('${FormBuilderLocalizations.current.requiredErrorText}\n'));
    });

    test(
        'should log the custom errorText if valueCandidate is null and errorText is provided',
        () {
      // Arrange
      final LogValidator<String> validator = LogValidator<String>(
        errorText: customErrorMessage,
      );
      const String? value = null;

      // Act & Assert
      expect(() => validator.validate(value), prints('$customErrorMessage\n'));
    });
  });
}
