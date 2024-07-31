import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  final List<String> profanityList = <String>[
    'badword1',
    'badword2',
    'badword3',
  ];
  const String customErrorMessage =
      'This text contains inappropriate language.';

  group('ProfanityValidator -', () {
    test('should return null for strings without profanity', () {
      // Arrange
      final ProfanityValidator validator =
          ProfanityValidator(profanityList: profanityList);

      // Act & Assert
      expect(validator.validate('This is a clean sentence.'), isNull);
      expect(validator.validate('Nothing wrong here!'), isNull);
    });

    test('should return the default error message for strings with profanity',
        () {
      // Arrange
      final ProfanityValidator validator =
          ProfanityValidator(profanityList: profanityList);
      const String badSentence = 'This is badword1.';
      const String badSentence2 = 'Another badword2 example.';

      // Act & Assert
      expect(
        validator.validate(badSentence),
        equals(
          FormBuilderLocalizations.current.profanityErrorText(
              validator.profanityAllFound(badSentence).join(', ')),
        ),
      );
      expect(
        validator.validate(badSentence2),
        equals(
          FormBuilderLocalizations.current.profanityErrorText(
              validator.profanityAllFound(badSentence2).join(', ')),
        ),
      );
    });

    test('should return the custom error message for strings with profanity',
        () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator(
        profanityList: profanityList,
        errorText: customErrorMessage,
      );

      // Act & Assert
      expect(
          validator.validate('This is badword1.'), equals(customErrorMessage));
      expect(validator.validate('Another badword2 example.'),
          equals(customErrorMessage));
    });

    test(
        'should return null when the value is an empty string and null check is disabled',
        () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator(
        profanityList: profanityList,
        checkNullOrEmpty: false,
      );
      const String value = '';

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });

    test('should return null when the value is null and null check is disabled',
        () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator(
        profanityList: profanityList,
        checkNullOrEmpty: false,
      );
      const String? value = null;

      // Act & Assert
      final String? result = validator.validate(value);
      expect(result, isNull);
    });

    test('should return a list of profanity words found in the string', () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator(
        profanityList: profanityList,
      );

      // Act & Assert
      expect(validator.profanityAllFound('This is badword1 and badword3.'),
          equals(<String>['badword1', 'badword3']));
      expect(
          validator.profanityAllFound('Clean sentence.'), equals(<String>[]));
    });

    test('should return the string with profanity words censored', () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator(
        profanityList: profanityList,
      );

      // Act & Assert
      const String badword1 = 'badword1';
      const String badword2 = 'badword2';
      const String badword3 = 'badword3';
      expect(
          validator.profanityCensored('This is $badword1 and $badword3.'),
          equals(
              'This is ${'*' * badword1.length} and ${'*' * badword3.length}.'));
      expect(validator.profanityCensored('Another $badword2 example.'),
          equals('Another ${'*' * badword2.length} example.'));
    });

    test(
        'should return the string with profanity words replaced with a custom string',
        () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator(
        profanityList: profanityList,
      );

      // Act & Assert
      expect(
          validator.profanityCensored('This is badword1 and badword3.',
              replaceWith: '[censored]'),
          equals('This is [censored] and [censored].'));
      expect(
          validator.profanityCensored('Another badword2 example.',
              replaceWith: '[censored]'),
          equals('Another [censored] example.'));
    });

    test(
        'should use all locales for profanity check when useAllLocales is true',
        () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator(
        useAllLocales: true,
      );

      // Act & Assert
      expect(validator.validate('This is shit.'), isNotNull);
      expect(validator.validate('Another apeshit example.'), isNotNull);
    });

    test(
        'should initialize with empty constructor and use default profanity list',
        () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator();

      // Act & Assert
      expect(validator.validate('This is a clean sentence.'), isNull);
      expect(validator.validate('shit'), isNotNull);
    });

    test('should return translated error text', () {
      // Arrange
      final ProfanityValidator validator = ProfanityValidator(
        profanityList: profanityList,
      );

      // Act
      final String translatedError = validator.translatedErrorText;

      // Assert
      expect(
        translatedError,
        equals(FormBuilderLocalizations.current
            .profanityErrorText(profanityList.join(', '))),
      );
    });
  });
}
