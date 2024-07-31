import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/profanity/profanity_en.dart';

class ProfanityTest extends Profanity {
  ProfanityTest() : super('test');

  @override
  List<String> get profanityList =>
      <String>['badword1', 'badword2', 'badword3'];
}

void main() {
  Profanity.supportedLocales = <Profanity>[ProfanityEn(), ProfanityTest()];

  group('Profanity -', () {
    test('should return the correct locale name', () {
      // Arrange
      final Profanity profanity = ProfanityTest();

      // Act & Assert
      expect(profanity.localeName, equals('test'));
    });

    test('should return the correct profanity list for the given locale', () {
      // Arrange
      final Profanity profanity = ProfanityTest();

      // Act & Assert
      expect(profanity.profanityList,
          equals(<String>['badword1', 'badword2', 'badword3']));
    });

    test(
        'should return the default profanity list when locale is not supported',
        () {
      // Act
      final Profanity profanity = Profanity.of('unsupported_locale');

      // Assert
      expect(profanity.localeName, equals('en')); // Default to 'en'
      expect(profanity.profanityList,
          equals(ProfanityEn().profanityList)); // Default to 'en' list
    });

    test('should return the profanity list for all supported locales', () {
      // Act
      final List<String> profanityList = Profanity.profanityListAll();

      // Assert
      expect(profanityList,
          containsAll(<String>['badword1', 'badword2', 'badword3']));
    });

    test('should return the correct profanity lists for multiple locales', () {
      // Arrange
      final List<String> locales = <String>['en', 'unsupported_locale', 'test'];

      // Act
      final List<Profanity> profanities = Profanity.ofLocales(locales);
      final List<String> profanityList = Profanity.profanityListOf(profanities);

      // Assert
      expect(profanities.length, equals(3));
      expect(profanityList,
          containsAll(<String>['badword1', 'badword2', 'badword3']));
    });

    test('should return the correct profanity list for multiple locales', () {
      // Arrange
      final List<String> locales = <String>['test'];

      // Act
      final List<String> profanityList =
          Profanity.profanityListOfLocales(locales);

      // Assert
      expect(profanityList,
          containsAll(<String>['badword1', 'badword2', 'badword3']));
    });
  });
}
