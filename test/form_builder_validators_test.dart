import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// Test Harness for running Validations
Future<void> testValidations(
  WidgetTester tester,
  void Function(BuildContext) validations,
) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Builder(
        builder: (BuildContext context) {
          // Exercise validations using the provided context
          validations(context);
          // The builder function must return a widget.
          return const Placeholder();
        },
      ),
    ),
  );

  // Critical to pumpAndSettle to let Builder build to exercise validations
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'FormBuilderValidators.required',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validatorBool = FormBuilderValidators.required<bool>();
      // Pass
      expect(validatorBool(false), isNull);
      expect(validatorBool(true), isNull);
      // Fail
      expect(validatorBool(null), isNotNull);

      final validatorDate = FormBuilderValidators.required<DateTime>();
      // Pass
      expect(validatorDate(DateTime.now()), isNull);
      // Fail
      expect(validatorDate(null), isNotNull);

      final validatorInt = FormBuilderValidators.required<int>();
      // Pass
      expect(validatorInt(0), isNull);
      // Fail
      expect(validatorInt(null), isNotNull);

      final validatorDouble = FormBuilderValidators.required<double>();
      // Pass
      expect(validatorDouble(0), isNull);
      expect(validatorDouble(0.1), isNull);
      expect(validatorDouble(1.234), isNull);
      expect(validatorDouble(-4.567), isNull);
      // Fail
      expect(validatorDouble(null), isNotNull);

      final validatorString = FormBuilderValidators.required<String>();
      // Pass
      expect(validatorString('0'), isNull);
      expect(validatorString('something long'), isNull);
      // Fail
      expect(validatorString(null), isNotNull);
      expect(validatorString(''), isNotNull);

      final validatorList = FormBuilderValidators.required<List<int>>();
      // Pass
      expect(validatorList(const [1]), isNull);
      expect(validatorList(const [1, 2]), isNull);
      // Fail
      expect(validatorList(null), isNotNull);
      expect(validatorList(const []), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.equal',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.equal<bool>(true);
      // Pass
      expect(validator(true), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(false), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.notEqual',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.notEqual<bool>(true);
      // Pass
      expect(validator(false), isNull);
      expect(validator(null), isNull);
      // Fail
      expect(validator(true), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.maxLength for String',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.maxLength<String>(5);
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('two'), isNull);
      expect(validator('12345'), isNull);
      // Fail
      expect(validator('something long'), isNotNull);
      expect(validator('123456'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.minLength for String',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.minLength<String>(5);
      // Pass
      expect(validator('12345'), isNull);
      expect(validator('123456'), isNull);
      expect(validator('something long'), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator('two'), isNotNull);
      // Advanced
      final validatorAllowEmpty =
          FormBuilderValidators.minLength<String>(5, allowEmpty: true);
      expect(validatorAllowEmpty(null), isNull);
      expect(validatorAllowEmpty(''), isNull);
    }),
  );
  testWidgets(
    'FormBuilderValidators.maxLength for Iterable',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.maxLength<Iterable<String>>(3);
      // Pass
      expect(validator(null), isNull);
      expect(validator([]), isNull);
      expect(validator(['one', 'two']), isNull);
      expect(validator(['one', 'two', 'three']), isNull);
      // Fail
      expect(validator(['one', 'two', 'three', 'four']), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.minLength for Iterable',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.minLength<Iterable<String>>(3);
      // Pass
      expect(validator(['one', 'two', 'three']), isNull);
      expect(validator(['one', 'two', 'three', 'four']), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator([]), isNotNull);
      expect(validator(['one', 'two']), isNotNull);
      // Advanced
      final validatorAllowEmpty =
          FormBuilderValidators.minLength<Iterable<String>>(
        3,
        allowEmpty: true,
      );
      expect(validatorAllowEmpty(null), isNull);
      expect(validatorAllowEmpty([]), isNull);
    }),
  );
  testWidgets(
    'FormBuilderValidators.equalLength for Iterable',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.equalLength<Iterable<String>>(3);

      // Pass
      expect(validator(['a', 'b', 'c']), isNull);

      // Fail
      expect(validator(null), isNotNull);
      expect(validator([]), isNotNull);
      expect(validator(['one', 'two']), isNotNull);
      expect(validator(['one', 'two', 'three', 'four']), isNotNull);
    }),
  );
  testWidgets(
    'FormBuilderValidators.equalLength for String',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.equalLength<String>(3);

      // Pass
      expect(validator('333'), isNull);

      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator('22'), isNotNull);
      expect(validator('4444'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.equalLength for int',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.equalLength<int>(3);

      // Pass
      expect(validator(333), isNull);

      // Fail
      expect(validator(null), isNotNull);
      expect(validator(0), isNotNull);
      expect(validator(1), isNotNull);
      expect(validator(22), isNotNull);
      expect(validator(4444), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.maxWordsCount',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.maxWordsCount(5);
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('the quick brown'), isNull);
      expect(validator('The quick brown fox jumps'), isNull);
      // 1 White spaces to test the trimming of the string
      expect(validator(' '), isNull);
      // 5 White spaces to test the trimming of the string
      expect(validator('     '), isNull);
      // + 1 White space to test the trimming of the string
      expect(validator(' The quick brown fox'), isNull);
      // + 1 White space to test the trimming of the string
      expect(validator('The quick brown fox '), isNull);
      // + 1 White space to test the trimming of the string
      expect(validator(' The quick brown fox jumps'), isNull);
      // + 1 White space to test the trimming of the string
      expect(validator('The quick brown fox jumps '), isNull);
      // Fail
      expect(validator('The quick brown fox jumps over'), isNotNull);
      expect(
        validator('The quick brown fox jumps over the lazy dog'),
        isNotNull,
      );
    }),
  );

  testWidgets(
    'FormBuilderValidators.minWordsCount',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.minWordsCount(5);
      // Pass
      expect(validator('The quick brown fox jumps'), isNull);
      expect(validator('The quick brown fox jumps over'), isNull);
      expect(
        validator('The quick brown fox jumps over the lazy dog'),
        isNull,
      );
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator('The quick brown'), isNotNull);
      // 1 White spaces to test the trimming of the string
      expect(validator(' '), isNotNull);
      // 5 White spaces to test the trimming of the string
      expect(validator('     '), isNotNull);
      // + 1 White space to test the trimming of the string
      expect(validator(' The quick brown fox'), isNotNull);
      // + 1 White space to test the trimming of the string
      expect(validator('The quick brown fox '), isNotNull);
      // Advanced
      final validatorAllowEmpty =
          FormBuilderValidators.minWordsCount(5, allowEmpty: true);
      expect(validatorAllowEmpty(null), isNull);
      expect(validatorAllowEmpty(''), isNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.email',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.email();
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('john@flutter.dev'), isNull);

      // Fail
      expect(validator('john@flutter'), isNotNull);
      expect(validator('john@ flutter.dev'), isNotNull);
      expect(validator('john flutter.dev'), isNotNull);
      expect(validator('flutter.dev'), isNotNull);
      expect(validator(' john@flutter.dev '), isNotNull);
      expect(validator('john@flutter.dev '), isNotNull);
      expect(validator(' john@flutter.dev'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.max',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validatorInt = FormBuilderValidators.max<int>(20);
      // Pass
      expect(validatorInt(null), isNull);
      expect(validatorInt(0), isNull);
      expect(validatorInt(-1), isNull);
      expect(validatorInt(20), isNull);
      // Fail
      expect(validatorInt(21), isNotNull);
      expect(validatorInt(999), isNotNull);

      final validatorDouble = FormBuilderValidators.max<double>(20);
      // Pass
      expect(validatorDouble(null), isNull);
      expect(validatorDouble(0), isNull);
      expect(validatorDouble(-1), isNull);
      expect(validatorDouble(-1.1), isNull);
      expect(validatorDouble(1.2), isNull);
      expect(validatorDouble(20), isNull);
      // Fail
      expect(validatorDouble(20.01), isNotNull);
      expect(validatorDouble(21), isNotNull);
      expect(validatorDouble(999), isNotNull);

      final validatorString = FormBuilderValidators.max<String>(20);
      // Pass
      expect(validatorString(null), isNull);
      expect(validatorString(''), isNull);
      expect(validatorString('19'), isNull);
      expect(validatorString('20'), isNull);
      // Fail
      expect(validatorString('21'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.min',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validatorInt = FormBuilderValidators.min<int>(30);
      // Pass
      expect(validatorInt(null), isNull);
      expect(validatorInt(31), isNull);
      expect(validatorInt(70), isNull);
      // Fail
      expect(validatorInt(-1), isNotNull);
      expect(validatorInt(0), isNotNull);
      expect(validatorInt(10), isNotNull);
      expect(validatorInt(29), isNotNull);

      final validatorDouble = FormBuilderValidators.min<double>(30);
      // Pass
      expect(validatorDouble(null), isNull);
      expect(validatorDouble(30.01), isNull);
      expect(validatorDouble(31), isNull);
      expect(validatorDouble(70), isNull);
      // Fail
      expect(validatorDouble(-1), isNotNull);
      expect(validatorDouble(0), isNotNull);
      expect(validatorDouble(10), isNotNull);
      expect(validatorDouble(29), isNotNull);

      final validatorString = FormBuilderValidators.min<String>(30);
      // Pass
      expect(validatorString(null), isNull);
      expect(validatorString(''), isNull);
      expect(validatorString('31'), isNull);
      // Fail
      expect(validatorString('10'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.numeric',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.numeric();
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('0'), isNull);
      expect(validator('31'), isNull);
      expect(validator('-1'), isNull);
      expect(validator('-1.01'), isNull);
      // Fail
      expect(validator('A'), isNotNull);
      expect(validator('XYZ'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.integer',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.integer();
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('0'), isNull);
      expect(validator('31'), isNull);
      expect(validator('-1'), isNull);
      // Fail
      expect(validator('-1.01'), isNotNull);
      expect(validator('1.'), isNotNull);
      expect(validator('A'), isNotNull);
      expect(validator('XYZ'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.match',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.match(r'^A[0-9]$');
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('A1'), isNull);
      expect(validator('A9'), isNull);
      // Fail
      expect(validator('A'), isNotNull);
      expect(validator('Z9'), isNotNull);
      expect(validator('A12'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.url',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.url();
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('https://www.google.com'), isNull);
      expect(validator('www.google.com'), isNull);
      expect(validator('google.com'), isNull);
      expect(validator('http://google.com'), isNull);
      expect(validator('HTTPS://GOOGLE.COM'), isNull);
      expect(validator('GOOGLE.com'), isNull);
      expect(validator('GOOGLE.COM'), isNull);
      expect(validator('google.com/search?q=TEST'), isNull);
      expect(validator('google.com/search#MY_AWESOME_THING'), isNull);
      // Fail
      expect(validator('.com'), isNotNull);
      // Advanced overrides
      expect(
        FormBuilderValidators.url(
          protocols: ['https', 'http'],
          errorText: 'Only HTTP and HTTPS allowed',
        )('ftp://www.google.com'),
        isNotNull,
      );
    }),
  );

  testWidgets(
    'FormBuilderValidators.IP',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.ip();
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('192.168.0.1'), isNull);
      // Fail
      expect(validator('256.168.0.1'), isNotNull);
      expect(validator('256.168.0.'), isNotNull);
      expect(validator('255.168.0.'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.compose',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.compose<String>([
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
        FormBuilderValidators.minLength(2),
        FormBuilderValidators.maxLength(3),
      ]);
      // Pass
      expect(validator('12'), isNull);
      expect(validator('123'), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator('1'), isNotNull);
      expect(validator('1234'), isNotNull);
      expect(validator('ABC'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.creditCard',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.creditCard();
      // Pass
      expect(validator('4111111111111111'), isNull);
      // Fail
      expect(validator('1234567812345678'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.creditCardExpirationDate',
    (WidgetTester tester) => testValidations(tester, (context) {
      final now = DateTime.now();
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString().substring(2);
      final validator = FormBuilderValidators.creditCardExpirationDate();
      // Pass
      expect(validator('$month/$year'), isNull);
      // Fail
      expect(validator('13/23'), isNotNull);

      final validatorNoExpiredCheck =
          FormBuilderValidators.creditCardExpirationDate(
              checkForExpiration: false);
      // Pass
      expect(validatorNoExpiredCheck('12/23'), isNull);
      // Fail
      expect(validatorNoExpiredCheck('13/23'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.creditCardCVC',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.creditCardCVC();
      // Pass
      expect(validator('123'), isNull);
      expect(validator('1234'), isNull);
      // Fail
      expect(validator('12'), isNotNull);
      expect(validator('12345'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.phoneNumber',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.phoneNumber();

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
      expect(validator('+1-800-555-5555-00000000000'),
          isNotNull); // Too many digits
      expect(validator('++1 800 555 5555'), isNotNull); // Invalid prefix
      expect(validator('+1 (800) 555-5555'), isNotNull); // Invalid format
      expect(validator('+44 20 7946 0958 ext 123'),
          isNotNull); // Extension included

      // Edge cases
      expect(validator(''), isNotNull); // Empty string
      expect(validator(null), isNotNull); // Null value
    }),
  );

  testWidgets(
    'FormBuilderValidators.colorCode',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.colorCode();
      // Pass
      expect(validator('#FFFFFF'), isNull);
      expect(validator('rgb(255, 255, 255)'), isNull);
      // Fail
      expect(validator('#ZZZZZZ'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.uppercase',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.uppercase();
      // Pass
      expect(validator('HELLO'), isNull);
      expect(validator('LASAÑA'), isNull);
      // Fail
      expect(validator('Hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.lowercase',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.lowercase();
      // Pass
      expect(validator('hello'), isNull);
      expect(validator('lasaña'), isNull);
      // Fail
      expect(validator('Hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.fileExtension',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.fileExtension(
        allowedExtensions: ['txt', 'pdf'],
      );
      // Pass
      expect(validator(File('test.txt').path), isNull);
      // Fail
      expect(validator(File('test.doc').path), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.fileSize',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.fileSize(maxSize: 1024);
      // Create a temporary file
      final file = File('test.txt')
        ..createSync()
        ..writeAsBytesSync(List.filled(512, 0));
      // Pass
      expect(validator(file.lengthSync().toString()), isNull);
      // Fail
      file.writeAsBytesSync(List.filled(2048, 0));
      expect(validator(file.lengthSync().toString()), isNotNull);
      // Cleanup
      file.deleteSync();
    }),
  );

  testWidgets(
    'FormBuilderValidators.conditional',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.conditional(
        (value) => value != null,
        FormBuilderValidators.hasUppercaseChars(atLeast: 3),
      );
      // Pass
      expect(validator('HELLO'), isNull);
      expect(validator('lasAÑA'), isNull);
      // Fail
      expect(validator('hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.range',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.range(10, 20);
      // Pass
      expect(validator(15), isNull);
      // Fail
      expect(validator(5), isNotNull);
      expect(validator(25), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.mustBeTrue',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.mustBeTrue();
      // Pass
      expect(validator(true), isNull);
      // Fail
      expect(validator(false), isNotNull);
      expect(validator(null), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.mustBeFalse',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.mustBeFalse();
      // Pass
      expect(validator(false), isNull);
      // Fail
      expect(validator(true), isNotNull);
      expect(validator(null), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.hasSpecialChars',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.hasSpecialChars(atLeast: 1);
      // Pass
      expect(validator('hello@'), isNull);
      // Fail
      expect(validator('hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.hasUppercaseChars',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.hasUppercaseChars(atLeast: 1);
      // Pass
      expect(validator('Hello'), isNull);
      expect(validator('lasaÑa'), isNull);
      // Fail
      expect(validator('hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.hasLowercaseChars',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.hasLowercaseChars(atLeast: 1);
      // Pass
      expect(validator('hello'), isNull);
      expect(validator('LASAñA'), isNull);
      // Fail
      expect(validator('HELLO'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.hasNumericChars',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.hasNumericChars(atLeast: 1);
      // Pass
      expect(validator('hello1'), isNull);
      // Fail
      expect(validator('hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.password',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.password();
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

      final customValidator = FormBuilderValidators.password(
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
    }),
  );

  testWidgets(
    'FormBuilderValidators.alphabetical',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.alphabetical();
      // Pass
      expect(validator('Hello'), isNull);
      expect(validator('world'), isNull);
      // Fail
      expect(validator('Hello123'), isNotNull);
      expect(validator('123'), isNotNull);
      expect(validator('!@#'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.uuid',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.uuid();
      // Pass
      expect(validator('123e4567-e89b-12d3-a456-426614174000'), isNull);
      // Fail
      expect(validator('not-a-uuid'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.json',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.json();
      // Pass
      expect(validator('{"key": "value"}'), isNull);
      // Fail
      expect(validator('not-json'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.latitude',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.latitude();
      // Pass
      expect(validator('45.0'), isNull);
      expect(validator('-90.0'), isNull);
      // Fail
      expect(validator('91.0'), isNotNull);
      expect(validator('latitude'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.longitude',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.longitude();
      // Pass
      expect(validator('90.0'), isNull);
      expect(validator('-180.0'), isNull);
      // Fail
      expect(validator('181.0'), isNotNull);
      expect(validator('longitude'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.base64',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.base64();
      // Pass
      expect(validator('SGVsbG8gd29ybGQ='), isNull);
      // Fail
      expect(validator('not-base64'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.path',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.path();
      // Pass
      expect(validator('/path/to/file'), isNull);
      // Fail
      expect(validator('path\\to\\file'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.oddNumber',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.oddNumber();
      // Pass
      expect(validator('3'), isNull);
      expect(validator('5'), isNull);
      // Fail
      expect(validator('2'), isNotNull);
      expect(validator('4'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.evenNumber',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.evenNumber();
      // Pass
      expect(validator('2'), isNull);
      expect(validator('4'), isNull);
      // Fail
      expect(validator('3'), isNotNull);
      expect(validator('5'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.portNumber',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.portNumber();
      // Pass
      expect(validator('8080'), isNull);
      expect(validator('80'), isNull);
      // Fail
      expect(validator('70000'), isNotNull);
      expect(validator('-1'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.macAddress',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.macAddress();
      // Pass
      expect(validator('00:1B:44:11:3A:B7'), isNull);
      expect(validator('00-1B-44-11-3A-B7'), isNull);
      // Fail
      expect(validator('invalid-mac'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.startsWith',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.startsWith(prefix: 'Hello');
      // Pass
      expect(validator('Hello world'), isNull);
      // Fail
      expect(validator('world Hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.endsWith',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.endsWith(suffix: 'world');
      // Pass
      expect(validator('Hello world'), isNull);
      // Fail
      expect(validator('world Hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.contains',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.contains(substring: 'flutter');
      // Pass
      expect(validator('I love flutter'), isNull);
      // Fail
      expect(validator('I love dart'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.between',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.between(min: 10, max: 20);
      // Pass
      expect(validator(15), isNull);
      // Fail
      expect(validator(5), isNotNull);
      expect(validator(25), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.inList',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.inList([1, 2, 3]);
      // Pass
      expect(validator(2), isNull);
      // Fail
      expect(validator(4), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.or',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.or([
        FormBuilderValidators.numeric(),
        FormBuilderValidators.startsWith(prefix: 'Hello'),
      ]);
      // Pass
      expect(validator('123'), isNull);
      expect(validator('Hello world'), isNull);
      // Fail
      expect(validator('123 hello'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.aggregate',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.aggregate<String>([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(5),
        FormBuilderValidators.maxLength(10),
      ]);
      // Pass
      expect(validator('hello'), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator('test'), isNotNull);
      expect(validator('this string is too long'), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.transform',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.transform<String>(
        FormBuilderValidators.required(),
        (value) => value?.trim() ?? '',
      );
      // Pass
      expect(validator(' trimmed '), isNull);
      // Fail
      expect(validator('  '), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.skipWhen',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.skipWhen<String>(
        (value) => value == 'skip',
        FormBuilderValidators.required(),
      );
      // Pass
      expect(validator('skip'), isNull);
      // Fail
      expect(validator(''), isNotNull);
    }),
  );

  testWidgets(
    'FormBuilderValidators.log',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.log<String>(
        log: (value) => 'Logging: $value',
      );
      // Pass
      expect(validator('test'), isNull);
      // Fail
      expect(validator(null), isNull); // Log message will be displayed
    }),
  );

  testWidgets(
    'FormBuilderValidators.iban',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.iban();
      // Pass
      expect(validator('GB82WEST12345698765432'), isNull); // A valid UK IBAN
      expect(
          validator('DE89370400440532013000'), isNull); // A valid German IBAN
      expect(validator('FR1420041010050500013M02606'),
          isNull); // A valid French IBAN
      expect(validator('GB82 WEST 1234 5698 7654 32'),
          isNull); // Format with spaces

      // Fail
      //expect(validator(''), isNotNull); // Empty string
      expect(validator('INVALIDIBAN'), isNotNull); // Invalid IBAN
      expect(validator('GB82WEST1234569876543212345'), isNotNull); // Too long
      expect(validator('GB82WEST1234'), isNotNull); // Too short
    }),
  );
}
