import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../tests_helper.dart';

void main() {
  final faker = Faker.instance;
  const customErrorMessage = 'Custom error message';

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
      expect(validatorDouble(faker.datatype.float()), isNull);
      expect(validatorDouble(-faker.datatype.float()), isNull);
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

      final validatorWithErrorMessage = FormBuilderValidators.required<String>(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('0'), isNull);
      // Fail
      expect(validatorWithErrorMessage(null), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.equal<bool>(
        true,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(true), isNull);
      // Fail
      expect(validatorWithErrorMessage(false), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.notEqual<bool>(
        true,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(false), isNull);
      // Fail
      expect(validatorWithErrorMessage(true), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.maxLength for String',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.maxLength<String>(5);
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator(faker.lorem.word(length: 1)), isNull);
      expect(validator(faker.lorem.word(length: 2)), isNull);
      expect(validator(faker.lorem.word(length: 3)), isNull);
      expect(validator(faker.lorem.word(length: 4)), isNull);
      expect(validator(faker.lorem.word(length: 5)), isNull);
      // Fail
      expect(validator(faker.lorem.word(length: 6)), isNotNull);
      expect(validator(faker.lorem.word(length: 10)), isNotNull);
      expect(validator(faker.lorem.sentence()), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.maxLength<String>(
        5,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(faker.lorem.word(length: 5)), isNull);
      // Fail
      expect(validatorWithErrorMessage(faker.lorem.word(length: 6)),
          customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.minLength for String',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.minLength<String>(5);
      // Pass
      expect(validator(faker.lorem.word(length: 5)), isNull);
      expect(validator(faker.lorem.word(length: 6)), isNull);
      expect(validator(faker.lorem.sentence()), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      final length = faker.datatype.number(min: 1, max: 5);
      expect(validator(faker.datatype.string(length: length)), isNotNull);
      // Advanced
      final validatorAllowEmpty =
          FormBuilderValidators.minLength<String>(5, allowEmpty: true);
      expect(validatorAllowEmpty(null), isNull);
      expect(validatorAllowEmpty(''), isNull);

      final validatorWithErrorMessage = FormBuilderValidators.minLength<String>(
        5,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('12345'), isNull);
      // Fail
      expect(validatorWithErrorMessage('two'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.maxLength for Iterable',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.maxLength<Iterable<String>>(3);
      // Pass
      expect(validator(null), isNull);
      expect(validator([]), isNull);
      final list = List.generate(faker.datatype.number(min: 1, max: 3),
          (index) => faker.datatype.string());
      expect(
          validator([
            faker.datatype.string(),
            faker.datatype.string(),
            faker.datatype.string()
          ]),
          isNull);
      expect(validator(list), isNull);
      // Fail
      final failList = List.generate(faker.datatype.number(min: 4, max: 10),
          (index) => faker.datatype.string());
      expect(validator(failList), isNotNull);

      final validatorWithErrorMessage =
          FormBuilderValidators.maxLength<Iterable<String>>(
        3,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(['one', 'two']), isNull);
      // Fail
      expect(validatorWithErrorMessage(['one', 'two', 'three', 'four']),
          customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.minLength for Iterable',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.minLength<Iterable<String>>(3);
      // Pass
      final list = List.generate(faker.datatype.number(min: 4, max: 10),
          (index) => faker.datatype.string());
      expect(validator(['one', 'two', 'three']), isNull);
      expect(validator(list), isNull);
      // Fail
      final failList = List.generate(faker.datatype.number(min: 1, max: 2),
          (index) => faker.datatype.string());
      expect(validator(null), isNotNull);
      expect(validator([]), isNotNull);
      expect(validator(failList), isNotNull);
      // Advanced
      final validatorAllowEmpty =
          FormBuilderValidators.minLength<Iterable<String>>(
        3,
        allowEmpty: true,
      );
      expect(validatorAllowEmpty(null), isNull);
      expect(validatorAllowEmpty([]), isNull);

      final validatorWithErrorMessage =
          FormBuilderValidators.minLength<Iterable<String>>(
        3,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(['one', 'two', 'three']), isNull);
      // Fail
      expect(validatorWithErrorMessage(['one', 'two']), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.equalLength for Iterable',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.equalLength<Iterable<String>>(3);
      // Pass
      expect(
          validator([
            faker.datatype.string(),
            faker.datatype.string(),
            faker.datatype.string()
          ]),
          isNull);
      // Fail
      final failList = List.generate(faker.datatype.number(min: 1, max: 2),
          (index) => faker.datatype.string());
      expect(validator(null), isNotNull);
      expect(validator([]), isNotNull);
      expect(validator(failList), isNotNull);
      expect(validator(['one', 'two', 'three', 'four']), isNotNull);

      final validatorWithErrorMessage =
          FormBuilderValidators.equalLength<Iterable<String>>(
        3,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(['a', 'b', 'c']), isNull);
      // Fail
      expect(validatorWithErrorMessage(['one', 'two']), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.equalLength for String',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.equalLength<String>(3);
      // Pass
      expect(validator(faker.datatype.string(length: 3)), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator(faker.datatype.string(length: 2)), isNotNull);
      expect(validator(faker.datatype.string(length: 4)), isNotNull);

      final validatorWithErrorMessage =
          FormBuilderValidators.equalLength<String>(
        3,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('333'), isNull);
      // Fail
      expect(validatorWithErrorMessage('22'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.equalLength for int',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.equalLength<int>(3);
      // Pass
      expect(validator(faker.datatype.number(min: 100, max: 999)), isNull);
      expect(validator(333), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(0), isNotNull);
      expect(validator(faker.datatype.number(min: 1, max: 9)), isNotNull);
      expect(validator(faker.datatype.number(min: 10, max: 99)), isNotNull);
      expect(validator(faker.datatype.number(min: 1000)), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.equalLength<int>(
        3,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(333), isNull);
      // Fail
      expect(validatorWithErrorMessage(22), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.maxWordsCount',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.maxWordsCount(5);
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      expect(validator(faker.lorem.sentence(wordCount: 2)), isNull);
      expect(validator(faker.lorem.sentence(wordCount: 3)), isNull);
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
      expect(validator(faker.lorem.sentence(wordCount: 6)), isNotNull);
      expect(validator('The quick brown fox jumps over'), isNotNull);
      expect(
        validator('The quick brown fox jumps over the lazy dog'),
        isNotNull,
      );

      final validatorWithErrorMessage = FormBuilderValidators.maxWordsCount(
        5,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('The quick brown fox jumps'), isNull);
      // Fail
      expect(validatorWithErrorMessage('The quick brown fox jumps over'),
          customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.minWordsCount',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.minWordsCount(5);
      // Pass
      expect(validator(faker.lorem.sentence(wordCount: 6)), isNull);
      expect(validator('The quick brown fox jumps'), isNull);
      expect(validator('The quick brown fox jumps over'), isNull);
      expect(
        validator('The quick brown fox jumps over the lazy dog'),
        isNull,
      );
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator(faker.lorem.sentence(wordCount: 4)), isNotNull);
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

      final validatorWithErrorMessage = FormBuilderValidators.minWordsCount(
        5,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('The quick brown fox jumps'), isNull);
      // Fail
      expect(validatorWithErrorMessage('The quick brown'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.email',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.email();
      // Pass
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator(faker.internet.email()), isNull);
      expect(validator('john@flutter.dev'), isNull);
      // Fail
      expect(validator(faker.internet.domainName()), isNotNull);
      expect(validator(faker.internet.url()), isNotNull);
      expect(validator('john@flutter'), isNotNull);
      expect(validator('john@ flutter.dev'), isNotNull);
      expect(validator('john flutter.dev'), isNotNull);
      expect(validator('flutter.dev'), isNotNull);
      expect(validator(' john@flutter.dev '), isNotNull);
      expect(validator('john@flutter.dev '), isNotNull);
      expect(validator(' john@flutter.dev'), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.email(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('john@flutter.dev'), isNull);
      // Fail
      expect(validatorWithErrorMessage('john@flutter'), customErrorMessage);
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
      expect(validatorInt(faker.datatype.number(min: 0, max: 20)), isNull);
      // Fail
      expect(validatorInt(21), isNotNull);
      expect(validatorInt(999), isNotNull);
      expect(validatorInt(faker.datatype.number(min: 21)), isNotNull);

      final validatorDouble = FormBuilderValidators.max<double>(20);
      // Pass
      expect(validatorDouble(null), isNull);
      expect(validatorDouble(0), isNull);
      expect(validatorDouble(-1), isNull);
      expect(validatorDouble(-1.1), isNull);
      expect(validatorDouble(1.2), isNull);
      expect(validatorDouble(20), isNull);
      expect(validatorDouble(faker.datatype.float(min: 0, max: 20)), isNull);
      // Fail
      expect(validatorDouble(20.01), isNotNull);
      expect(validatorDouble(21), isNotNull);
      expect(validatorDouble(999), isNotNull);
      expect(validatorDouble(faker.datatype.float(min: 21)), isNotNull);

      final validatorString = FormBuilderValidators.max<String>(20);
      // Pass
      expect(validatorString(null), isNull);
      expect(validatorString(''), isNull);
      expect(validatorString('19'), isNull);
      expect(validatorString('20'), isNull);
      expect(validatorString(faker.datatype.number(min: 0, max: 20).toString()),
          isNull);
      // Fail
      expect(validatorString('21'), isNotNull);
      expect(validatorString(faker.datatype.number(min: 21).toString()),
          isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.max<String>(
        20,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('20'), isNull);
      // Fail
      expect(validatorWithErrorMessage('21'), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.min<String>(
        30,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('31'), isNull);
      // Fail
      expect(validatorWithErrorMessage('10'), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.numeric(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('0'), isNull);
      // Fail
      expect(validatorWithErrorMessage('A'), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.integer(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('0'), isNull);
      // Fail
      expect(validatorWithErrorMessage('A'), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.match(
        r'^A[0-9]$',
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('A1'), isNull);
      // Fail
      expect(validatorWithErrorMessage('A'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.notMatch',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.notMatch(r'^A[0-9]$');
      // Pass
      expect(validator('B1'), isNull);
      expect(validator('C2'), isNull);
      // Fail
      expect(validator('A1'), isNotNull);
      expect(validator('A9'), isNotNull);
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      final validatorWithErrorMessage = FormBuilderValidators.notMatch(
        r'^A[0-9]$',
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('B1'), isNull);
      // Fail
      expect(validatorWithErrorMessage('A1'), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.url(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('https://www.google.com'), isNull);
      // Fail
      expect(validatorWithErrorMessage('.com'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.dateString',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.dateString();
      // Pass
      expect(validator('2023-05-29'), isNull);
      // Fail
      expect(validator('invalid-date'), isNotNull);
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      final validatorWithErrorMessage = FormBuilderValidators.dateString(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('2023-05-29'), isNull);
      // Fail
      expect(validatorWithErrorMessage('invalid-date'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.time',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.time();
      // Pass
      expect(validator('4:00'), isNull);
      expect(validator('12:00'), isNull);
      expect(validator('23:59'), isNull);

      expect(validator('4:59:59'), isNull);
      expect(validator('4:4:59'), isNull);
      expect(validator('4:4:4'), isNull);
      expect(validator('11:59:59'), isNull);

      expect(validator('04:04'), isNull);
      expect(validator('04:04:59'), isNull);
      expect(validator('04:04:04'), isNull);

      expect(validator('12:00 AM'), isNull);
      expect(validator('12:00 PM'), isNull);
      expect(validator('11:59 PM'), isNull);

      expect(validator('4:00:00 AM'), isNull);
      expect(validator('12:00:00 PM'), isNull);
      expect(validator('11:59:59 PM'), isNull);
      expect(validator('01:01:01 AM'), isNull);
      expect(validator('10:10:10 PM'), isNull);
      expect(validator('12:34:56 AM'), isNull);

      // Fail
      expect(validator('13:00 AM'), isNotNull);
      expect(validator('25:00'), isNotNull);
      expect(validator('invalid-time'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.time(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('12:00'), isNull);
      // Fail
      expect(validatorWithErrorMessage('25:00'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.dateTime',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.dateTime();
      // Pass
      expect(validator(DateTime.now()), isNull);
      // Fail
      expect(validator(null), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.dateTime(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(DateTime.now()), isNull);
      // Fail
      expect(validatorWithErrorMessage(null), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.dateRange',
    (WidgetTester tester) => testValidations(tester, (context) {
      final minDate = DateTime(2023, 01, 01);
      final maxDate = DateTime(2023, 12, 31);
      final validator =
          FormBuilderValidators.dateRange(minDate: minDate, maxDate: maxDate);
      // Pass
      expect(validator('2023-05-29'), isNull);
      // Fail
      expect(validator('2022-12-31'), isNotNull);
      expect(validator('2024-01-01'), isNotNull);
      expect(validator('invalid-date'), isNotNull);
      expect(validator(null), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.dateRange(
        minDate: minDate,
        maxDate: maxDate,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('2023-05-29'), isNull);
      // Fail
      expect(validatorWithErrorMessage('2022-12-31'), customErrorMessage);
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
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      final validatorWithErrorMessage = FormBuilderValidators.uppercase(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('HELLO'), isNull);
      // Fail
      expect(validatorWithErrorMessage('Hello'), customErrorMessage);
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
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      final validatorWithErrorMessage = FormBuilderValidators.lowercase(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('hello'), isNull);
      // Fail
      expect(validatorWithErrorMessage('Hello'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.range',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.range(10, 20);
      // Pass
      expect(validator(15), isNull);
      expect(validator(null), isNull);
      expect(validator(''), isNull);
      // Fail
      expect(validator(5), isNotNull);
      expect(validator(25), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.range(
        10,
        20,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(15), isNull);
      // Fail
      expect(validatorWithErrorMessage(5), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.isTrue',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.isTrue();
      // Pass
      expect(validator(true), isNull);
      // Fail
      expect(validator(false), isNotNull);
      expect(validator(null), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.isTrue(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(true), isNull);
      // Fail
      expect(validatorWithErrorMessage(false), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.isFalse',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.isFalse();
      // Pass
      expect(validator(false), isNull);
      // Fail
      expect(validator(true), isNotNull);
      expect(validator(null), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.isFalse(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(false), isNull);
      // Fail
      expect(validatorWithErrorMessage(true), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.hasSpecialChars(
        atLeast: 1,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('hello@'), isNull);
      // Fail
      expect(validatorWithErrorMessage('hello'), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.hasUppercaseChars(
        atLeast: 1,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('Hello'), isNull);
      // Fail
      expect(validatorWithErrorMessage('hello'), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.hasLowercaseChars(
        atLeast: 1,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('hello'), isNull);
      // Fail
      expect(validatorWithErrorMessage('HELLO'), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.hasNumericChars(
        atLeast: 1,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('hello1'), isNull);
      // Fail
      expect(validatorWithErrorMessage('hello'), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.startsWith(
        prefix: 'Hello',
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('Hello world'), isNull);
      // Fail
      expect(validatorWithErrorMessage('world Hello'), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.endsWith(
        suffix: 'world',
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('Hello world'), isNull);
      // Fail
      expect(validatorWithErrorMessage('world Hello'), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.contains(
        substring: 'flutter',
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('I love flutter'), isNull);
      // Fail
      expect(validatorWithErrorMessage('I love dart'), customErrorMessage);
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
      expect(validator(null), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.between(
        min: 10,
        max: 20,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(15), isNull);
      // Fail
      expect(validatorWithErrorMessage(5), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.containsElement',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.containsElement([1, 2, 3]);
      // Pass
      expect(validator(2), isNull);
      // Fail
      expect(validator(4), isNotNull);
      expect(validator(null), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.containsElement(
        [1, 2, 3],
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(2), isNull);
      // Fail
      expect(validatorWithErrorMessage(4), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.unique',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.unique([
        'test1',
        'test2',
        'test3',
        'test3',
      ]);
      // Pass
      expect(validator('test1'), isNull);
      // Fail
      expect(validator('test3'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.unique(
        ['test1', 'test2', 'test3', 'test3'],
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('test1'), isNull);
      // Fail
      expect(validatorWithErrorMessage('test3'), customErrorMessage);
    }),
  );

  testWidgets(
    'FormBuilderValidators.singleLine',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.singleLine();
      // Pass
      expect(validator('The quick brown fox jumps'), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator('The quick brown fox\njumps'), isNotNull);
      expect(validator('The quick brown fox\rjumps'), isNotNull);
      expect(validator('The quick brown fox\r\njumps'), isNotNull);
      expect(validator('The quick brown fox\n\rjumps'), isNotNull);

      final validatorWithErrorMessage =
          FormBuilderValidators.singleLine(errorText: customErrorMessage);
      // Pass
      expect(validatorWithErrorMessage('The quick brown fox jumps'), isNull);
      // Fail
      expect(validatorWithErrorMessage('The quick brown fox\njumps'),
          customErrorMessage);
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
    'FormBuilderValidators.conditional',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.conditional<String>(
        (value) => value.contains('test'),
        FormBuilderValidators.hasUppercaseChars(atLeast: 6),
      );
      // Pass
      expect(validator('test HELLOHELLO'), isNull);
      expect(validator('test lasAÑA HELLO'), isNull);
      // Fail
      expect(validator('test'), isNotNull);
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      final validatorWithErrorMessage =
          FormBuilderValidators.conditional<String>(
        (value) => value.contains('test'),
        FormBuilderValidators.hasUppercaseChars(
            atLeast: 6, errorText: customErrorMessage),
      );
      // Pass
      expect(validatorWithErrorMessage('test HELLOHELLO'), isNull);
      // Fail
      expect(validatorWithErrorMessage('test'), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.aggregate<String>(
        [
          FormBuilderValidators.required(errorText: customErrorMessage),
          FormBuilderValidators.minLength(5),
        ],
      );
      // Pass
      expect(validatorWithErrorMessage('hello'), isNull);
      // Fail
      expect(validatorWithErrorMessage(null),
          '$customErrorMessage\n${FormBuilderLocalizations.current.minLengthErrorText(5)}');
    }),
  );
  testWidgets(
    'FormBuilderValidators.defaultValue',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.defaultValue<String>(
          'default', FormBuilderValidators.alphabetical());
      // Pass
      expect(validator(null), isNull);
      expect(validator('hello'), isNull);
      // Fail
      expect(validator('123'), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage =
          FormBuilderValidators.defaultValue<String>(
        'default',
        FormBuilderValidators.alphabetical(errorText: customErrorMessage),
      );
      // Pass
      expect(validatorWithErrorMessage('123'), customErrorMessage);
      // Fail
      expect(validatorWithErrorMessage('123'), isNotNull);
    }),
  );
}
