import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Date past -', () {
    test('should return null when the value is not null', () {
      // Arrange
      const DatePastValidator validator = DatePastValidator();
      final DateTime value = DateTime.now();

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, isNull);
    });

    test('should return the error message when the value is null', () {
      // Arrange
      final DatePastValidator validator =
          DatePastValidator(errorText: customErrorMessage);
      final DateTime value = DateTime.now().add(const Duration(days: 1));

      // Act
      final String? result = validator.validate(value);

      // Assert
      expect(result, equals(customErrorMessage));
    });
  });
}
