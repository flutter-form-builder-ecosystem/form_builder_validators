import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();

  group('PortNumberValidator -', () {
    test(
      'should return null for valid port numbers within the default range',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator();
        const List<String> validPortNumbers = <String>[
          '0',
          '80',
          '443',
          '1024',
          '49152',
          '65535',
        ];

        // Act & Assert
        for (final String value in validPortNumbers) {
          expect(validator.validate(value), isNull);
        }
      },
    );

    test('should return null for valid port numbers within a custom range', () {
      // Arrange
      final PortNumberValidator validator = PortNumberValidator(
        min: 1000,
        max: 5000,
      );
      const List<String> validPortNumbers = <String>[
        '1000',
        '2000',
        '3000',
        '4000',
        '5000',
      ];

      // Act & Assert
      for (final String value in validPortNumbers) {
        expect(validator.validate(value), isNull);
      }
    });

    test(
      'should return the default error message for port numbers outside the default range',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator();
        const List<String> invalidPortNumbers = <String>[
          '-1',
          '65536',
          '70000',
          'abc',
          '',
        ];

        // Act & Assert
        for (final String value in invalidPortNumbers) {
          final String? result = validator.validate(value);
          expect(result, isNotNull);
          expect(
            result,
            equals(
              FormBuilderLocalizations.current.portNumberErrorText(0, 65535),
            ),
          );
        }
      },
    );

    test(
      'should return the custom error message for port numbers outside the default range',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator(
          errorText: customErrorMessage,
        );
        const List<String> invalidPortNumbers = <String>[
          '-1',
          '65536',
          '70000',
          'abc',
          '',
        ];

        // Act & Assert
        for (final String value in invalidPortNumbers) {
          final String? result = validator.validate(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );

    test(
      'should return the default error message for port numbers outside a custom range',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator(
          min: 1000,
          max: 5000,
        );
        const List<String> invalidPortNumbers = <String>[
          '999',
          '5001',
          '6000',
          'abc',
          '',
        ];

        // Act & Assert
        for (final String value in invalidPortNumbers) {
          final String? result = validator.validate(value);
          expect(result, isNotNull);
          expect(
            result,
            equals(
              FormBuilderLocalizations.current.portNumberErrorText(1000, 5000),
            ),
          );
        }
      },
    );

    test(
      'should return the custom error message for port numbers outside a custom range',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator(
          min: 1000,
          max: 5000,
          errorText: customErrorMessage,
        );
        const List<String> invalidPortNumbers = <String>[
          '999',
          '5001',
          '6000',
          'abc',
          '',
        ];

        // Act & Assert
        for (final String value in invalidPortNumbers) {
          final String? result = validator.validate(value);
          expect(result, equals(customErrorMessage));
        }
      },
    );

    test(
      'should return null when the port number is null and null check is disabled',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator(
          checkNullOrEmpty: false,
        );
        const String? nullPortNumber = null;

        // Act
        final String? result = validator.validate(nullPortNumber);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the port number is null',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator();
        const String? nullPortNumber = null;

        // Act
        final String? result = validator.validate(nullPortNumber);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.portNumberErrorText(0, 65535),
          ),
        );
      },
    );

    test(
      'should return null when the port number is an empty string and null check is disabled',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator(
          checkNullOrEmpty: false,
        );
        const String emptyPortNumber = '';

        // Act
        final String? result = validator.validate(emptyPortNumber);

        // Assert
        expect(result, isNull);
      },
    );

    test(
      'should return the default error message when the port number is an empty string',
      () {
        // Arrange
        final PortNumberValidator validator = PortNumberValidator();
        const String emptyPortNumber = '';

        // Act
        final String? result = validator.validate(emptyPortNumber);

        // Assert
        expect(result, isNotNull);
        expect(
          result,
          equals(
            FormBuilderLocalizations.current.portNumberErrorText(0, 65535),
          ),
        );
      },
    );
  });
}
