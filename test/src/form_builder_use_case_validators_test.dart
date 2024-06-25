import 'dart:io';

import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../tests_helper.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  testWidgets(
    'FormBuilderValidators.ip',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator = FormBuilderValidators.ip();
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('192.168.0.1'), isNull);
      // Fail
      expect(validator('256.168.0.1'), isNotNull);
      expect(validator('256.168.0.'), isNotNull);
      expect(validator('255.168.0.'), isNotNull);

      final FormFieldValidator<String> validatorWrongVersion =
          FormBuilderValidators.ip(version: 5);
      // Fail
      expect(validatorWrongVersion('192.168.0.5'), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.ip(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('192.168.0.1'), isNull);
      // Fail
      expect(validatorWithErrorMessage('256.168.0.1'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.creditCard',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.creditCard();
      // Pass
      expect(validator('4111111111111111'), isNull);
      // Fail
      expect(validator('1234567812345678'), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.creditCard(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('4111111111111111'), isNull);
      // Fail
      expect(validatorWithErrorMessage('1234567812345678'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.creditCardExpirationDate',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final DateTime now = DateTime.now();
      final String month = now.month.toString().padLeft(2, '0');
      final String year = now.year.toString().substring(2);
      final FormFieldValidator<String> validator =
          FormBuilderValidators.creditCardExpirationDate();
      // Pass
      expect(validator('$month/$year'), isNull);
      // Fail
      expect(validator('13/23'), isNotNull);

      final FormFieldValidator<String> validatorNoExpiredCheck =
          FormBuilderValidators.creditCardExpirationDate(
        checkForExpiration: false,
      );
      // Pass
      expect(validatorNoExpiredCheck('12/23'), isNull);
      // Fail
      expect(validatorNoExpiredCheck('13/23'), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.creditCardExpirationDate(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('$month/$year'), isNull);
      // Fail
      expect(validatorWithErrorMessage('13/23'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.creditCardCVC',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.creditCardCVC();
      // Pass
      expect(validator('123'), isNull);
      expect(validator('1234'), isNull);
      // Fail
      expect(validator('12'), isNotNull);
      expect(validator('12345'), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.creditCardCVC(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('123'), isNull);
      // Fail
      expect(validatorWithErrorMessage('12'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.phoneNumber',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.phoneNumber();
      // Valid phone numbers from various countries
      expect(validator('+1 800 555 5555'), isNull); // USA
      expect(validator('+44 20 7946 0958'), isNull); // UK
      expect(validator('+61 2 1234 5678'), isNull); // Australia
      expect(validator('+49 30 123456'), isNull); // Germany
      expect(validator('+33 1 23 45 67 89'), isNull); // France
      expect(validator('+81 3-1234-5678'), isNull); // Japan
      expect(validator('+91 98765 43210'), isNull); // India
      expect(validator('+86 10 1234 5678'), isNull); // China
      expect(validator('+55 11 91234-5678'), isNull); // Brazil
      expect(validator('+27 21 123 4567'), isNull); // South Africa
      // Invalid phone numbers
      expect(validator('123-abc-defg'), isNotNull); // Contains letters
      expect(
        validator('+1-800-555-5555-00000000000'),
        isNotNull,
      ); // Too many digits
      expect(validator('++1 800 555 5555'), isNotNull); // Invalid prefix
      expect(validator('+1 (800) 555-5555'), isNotNull); // Invalid format
      expect(
        validator('+44 20 7946 0958 ext 123'),
        isNotNull,
      ); // Extension included
      // Edge cases
      expect(validator(''), isNotNull); // Empty string
      expect(validator(null), isNotNull); // Null value

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.phoneNumber(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('+1 800 555 5555'), isNull);
      // Fail
      expect(validatorWithErrorMessage('123-abc-defg'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.colorCode',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.colorCode();
      // Pass
      expect(validator('#FFFFFF'), isNull);
      expect(validator('rgb(255, 255, 255)'), isNull);
      // Fail
      expect(validator('#ZZZZZZ'), isNotNull);
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.colorCode(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('#FFFFFF'), isNull);
      // Fail
      expect(validatorWithErrorMessage('#ZZZZZZ'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.fileExtension',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.fileExtension(
        allowedExtensions: <String>['txt', 'pdf'],
      );
      // Pass
      expect(validator(File('test.txt').path), isNull);
      // Fail
      expect(validator(File('test.doc').path), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.fileExtension(
        allowedExtensions: <String>['txt', 'pdf'],
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(File('test.txt').path), isNull);
      // Fail
      expect(
        validatorWithErrorMessage(File('test.doc').path),
        customErrorMessage,
      );
    }),
  );

  testWidgets(
    'FormBuilderValidators.fileSize',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.fileSize(maxSize: 1024);
      // Create a temporary file
      final File file = File('test.txt')
        ..createSync()
        ..writeAsBytesSync(List.filled(512, 0));
      // Pass
      expect(validator(file.lengthSync().toString()), isNull);
      // Fail
      file.writeAsBytesSync(List.filled(2048, 0));
      expect(validator(file.lengthSync().toString()), isNotNull);
      // Cleanup
      file.deleteSync();
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.fileSize(
        maxSize: 1024,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('512'), isNull);
      // Fail
      expect(validatorWithErrorMessage('2048'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.username',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.username();
      // Pass
      expect(validator('hello'), isNull);
      expect(validator('hello12345'), isNull);
      // Fail
      expect(validator('hello@'), isNotNull);
      expect(validator('he'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.username(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('hello'), isNull);
      // Fail
      expect(validatorWithErrorMessage('hello@'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.password',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.password();
      // Pass
      expect(validator('Hellohello1@'), isNull);
      // Fail
      expect(validator('hellohello1@'), isNotNull);
      expect(validator('Hellohello1'), isNotNull);
      expect(validator('Hellohello@'), isNotNull);
      // Fail - only lowercase
      expect(validator('lowercasepassword'), isNotNull);
      // Fail - only uppercase
      expect(validator('UPPERCASEPASSWORD'), isNotNull);
      // Fail - only numbers
      expect(validator('1234567890'), isNotNull);
      // Fail - only special chars
      expect(validator('~!@#%^&*'), isNotNull);
      // Fail - weak password
      expect(validator('password123'), isNotNull);
      // Fail - empty password
      expect(validator(''), isNotNull);
      // Fail - whitespace only
      expect(validator('     '), isNotNull);
      // Fail - similar characters
      expect(validator('aaaaaa1111'), isNotNull);

      final FormFieldValidator<String> customValidator =
          FormBuilderValidators.password(
        minLength: 4,
        maxLength: 16,
        uppercase: 3,
        lowercase: 3,
        number: 3,
        specialChar: 3,
      );
      // Pass - meets all requirements
      expect(customValidator('PASsw0rd@123!!'), isNull);
      // Fail - less than min length
      expect(customValidator('Pass@12'), isNotNull);
      // Fail - more than max length
      expect(customValidator('ThisIsAP@ssw0rd1234'), isNotNull);
      // Fail - missing uppercase chars
      expect(customValidator('password@123'), isNotNull);
      // Fail - missing lowercase chars
      expect(customValidator('PASSWORD@123'), isNotNull);
      // Fail - missing number
      expect(customValidator('Password@abc'), isNotNull);
      // Fail - missing special char
      expect(customValidator('Password123abc'), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.password(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('Hellohello1@'), isNull);
      // Fail
      expect(validatorWithErrorMessage('hellohello1@'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.alphabetical',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.alphabetical();
      // Pass
      expect(validator('Hello'), isNull);
      expect(validator('world'), isNull);
      // Fail
      expect(validator('Hello123'), isNotNull);
      expect(validator('123'), isNotNull);
      expect(validator('!@#'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.alphabetical(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('Hello'), isNull);
      // Fail
      expect(validatorWithErrorMessage('Hello123'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.uuid',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator = FormBuilderValidators.uuid();
      // Pass
      expect(validator('123e4567-e89b-12d3-a456-426614174000'), isNull);
      // Fail
      expect(validator('not-a-uuid'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.uuid(
        errorText: customErrorMessage,
      );
      // Pass
      expect(
        validatorWithErrorMessage('123e4567-e89b-12d3-a456-426614174000'),
        isNull,
      );
      // Fail
      expect(validatorWithErrorMessage('not-a-uuid'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.json',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator = FormBuilderValidators.json();
      // Pass
      expect(validator('{"key": "value"}'), isNull);
      // Fail
      expect(validator('not-json'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.json(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('{"key": "value"}'), isNull);
      // Fail
      expect(validatorWithErrorMessage('not-json'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.latitude',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.latitude();
      // Pass
      expect(validator('45.0'), isNull);
      expect(validator('-90.0'), isNull);
      // Fail
      expect(validator('91.0'), isNotNull);
      expect(validator('latitude'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.latitude(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('45.0'), isNull);
      // Fail
      expect(validatorWithErrorMessage('91.0'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.longitude',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.longitude();
      // Pass
      expect(validator('90.0'), isNull);
      expect(validator('-180.0'), isNull);
      // Fail
      expect(validator('181.0'), isNotNull);
      expect(validator('longitude'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.longitude(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('90.0'), isNull);
      // Fail
      expect(validatorWithErrorMessage('181.0'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.base64',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.base64();
      // Pass
      expect(validator('SGVsbG8gd29ybGQ='), isNull);
      // Fail
      expect(validator('not-base64'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.base64(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('SGVsbG8gd29ybGQ='), isNull);
      // Fail
      expect(validatorWithErrorMessage('not-base64'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.path',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator = FormBuilderValidators.path();
      // Pass
      expect(validator('/path/to/file'), isNull);
      // Fail
      expect(validator(r'path\to\file'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.path(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('/path/to/file'), isNull);
      // Fail
      expect(validatorWithErrorMessage(r'path\to\file'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.oddNumber',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.oddNumber();
      // Pass
      expect(validator('3'), isNull);
      expect(validator('5'), isNull);
      // Fail
      expect(validator('2'), isNotNull);
      expect(validator('4'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.oddNumber(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('3'), isNull);
      // Fail
      expect(validatorWithErrorMessage('2'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.evenNumber',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.evenNumber();
      // Pass
      expect(validator('2'), isNull);
      expect(validator('4'), isNull);
      // Fail
      expect(validator('3'), isNotNull);
      expect(validator('5'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.evenNumber(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('2'), isNull);
      // Fail
      expect(validatorWithErrorMessage('3'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.portNumber',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.portNumber();
      // Pass
      expect(validator('8080'), isNull);
      expect(validator('80'), isNull);
      // Fail
      expect(validator('70000'), isNotNull);
      expect(validator('-1'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.portNumber(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('8080'), isNull);
      // Fail
      expect(validatorWithErrorMessage('70000'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.macAddress',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator =
          FormBuilderValidators.macAddress();
      // Pass
      expect(validator('00:1B:44:11:3A:B7'), isNull);
      expect(validator('00-1B-44-11-3A-B7'), isNull);
      // Fail
      expect(validator('invalid-mac'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.macAddress(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('00:1B:44:11:3A:B7'), isNull);
      // Fail
      expect(validatorWithErrorMessage('invalid-mac'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.iban',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator = FormBuilderValidators.iban();
      // Pass
      expect(validator('GB82WEST12345698765432'), isNull); // A valid UK IBAN
      expect(
        validator('DE89370400440532013000'),
        isNull,
      ); // A valid German IBAN
      expect(
        validator('FR1420041010050500013M02606'),
        isNull,
      ); // A valid French IBAN
      expect(
        validator('GB82 WEST 1234 5698 7654 32'),
        isNull,
      ); // Format with spaces

      // Fail
      expect(validator(''), isNotNull); // Empty string
      expect(validator('INVALIDIBAN'), isNotNull); // Invalid IBAN
      expect(validator('GB82WEST1234569876543212345'), isNotNull); // Too long
      expect(validator('GB82WEST1234'), isNotNull); // Too short

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.iban(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('GB82WEST12345698765432'), isNull);
      // Fail
      expect(validatorWithErrorMessage('INVALIDIBAN'), customErrorMessage);
    }),
  );
  testWidgets(
    'FormBuilderValidators.bic',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator = FormBuilderValidators.bic();
      // Pass
      expect(validator('DEUTDEFF'), isNull); // A valid German BIC
      expect(
        validator('DEUTDEFF500'),
        isNull,
      ); // A valid German BIC with branch
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull); // Empty string
      expect(validator('INVALIDBIC'), isNotNull); // Invalid BIC
      expect(validator('DEUTDEFF5000'), isNotNull); // Too long
      expect(validator('DEUTDEFF5'), isNotNull); // Too short

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.bic(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('DEUTDEFF'), isNull);
      // Fail
      expect(validatorWithErrorMessage('INVALIDBIC'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.isbn',
    (WidgetTester tester) => testValidations(tester, (BuildContext context) {
      final FormFieldValidator<String> validator = FormBuilderValidators.isbn();
      // Pass
      expect(validator('978-3-16-148410-0'), isNull); // A valid ISBN-13
      expect(validator('0-306-40615-2'), isNull); // A valid ISBN-10
      expect(
        validator('9783161484100'),
        isNull,
      ); // A valid ISBN-13 without dashes
      expect(validator('0306406152'), isNull); // A valid ISBN-10 without dashes
      expect(
        validator('3-16-148410-X'),
        isNull,
      ); // A valid ISBN-10 with X as check digit

      // Fail
      expect(validator(null), isNotNull); // Null value
      expect(validator(''), isNotNull); // Empty string
      expect(validator('INVALIDISBN'), isNotNull); // Invalid ISBN string
      expect(validator('978-3-16-148410-00'), isNotNull); // Too long
      expect(validator('3-16-148410-00'), isNotNull); // Too short
      expect(
        validator('978-3-16-14841X-0'),
        isNotNull,
      ); // Invalid character in ISBN-13
      expect(
        validator('0-306-40615-X'),
        isNotNull,
      ); // Invalid character in ISBN-10
      expect(
        validator('978-3-16-148410-1'),
        isNotNull,
      ); // Invalid check digit for ISBN-13
      expect(
        validator('0-306-40615-1'),
        isNotNull,
      ); // Invalid check digit for ISBN-10
      expect(validator('1234567890123'), isNotNull); // Random invalid ISBN-13
      expect(validator('1234567890'), isNotNull); // Random invalid ISBN-10
      expect(validator('978316148410'), isNotNull); // ISBN-13 too short
      expect(validator('030640615'), isNotNull); // ISBN-10 too short
      expect(
        validator('978-3-16-1484100-0'),
        isNotNull,
      ); // Extra digit in ISBN-13
      expect(validator('0-306-40615-22'), isNotNull); // Extra digit in ISBN-10
      expect(validator('978-3-16-14'), isNotNull); // Incomplete ISBN-13
      expect(validator('0-306'), isNotNull); // Incomplete ISBN-10

      final FormFieldValidator<String> validatorWithErrorMessage =
          FormBuilderValidators.isbn(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('978-3-16-148410-0'), isNull);
      // Fail
      expect(validatorWithErrorMessage('INVALIDISBN'), customErrorMessage);
    }),
  );
}
