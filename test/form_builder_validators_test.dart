import 'dart:io';
import 'dart:math';

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
      expect(validator('two'), isNull);
      expect(validator('12345'), isNull);
      // Fail
      expect(validator('something long'), isNotNull);
      expect(validator('123456'), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.maxLength<String>(
        5,
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('12345'), isNull);
      // Fail
      expect(validatorWithErrorMessage('123456'), customErrorMessage);
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
      expect(validator(['one', 'two']), isNull);
      expect(validator(['one', 'two', 'three']), isNull);
      // Fail
      expect(validator(['one', 'two', 'three', 'four']), isNotNull);

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
      expect(validator(['a', 'b', 'c']), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator([]), isNotNull);
      expect(validator(['one', 'two']), isNotNull);
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
      expect(validator('333'), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
      expect(validator('22'), isNotNull);
      expect(validator('4444'), isNotNull);

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
      expect(validator(333), isNull);
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(0), isNotNull);
      expect(validator(1), isNotNull);
      expect(validator(22), isNotNull);
      expect(validator(4444), isNotNull);

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
      expect(validator('john@flutter.dev'), isNull);
      // Fail
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
    'FormBuilderValidators.ip',
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

      final validatorWrongVersion = FormBuilderValidators.ip(version: 5);
      // Fail
      expect(validatorWrongVersion('192.168.0.5'), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.ip(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('192.168.0.1'), isNull);
      // Fail
      expect(validatorWithErrorMessage('256.168.0.1'), customErrorMessage);
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
      expect(validator('12:00'), isNull);
      expect(validator('23:59'), isNull);
      // Fail
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

      final validatorWithErrorMessage = FormBuilderValidators.creditCard(
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

      final validatorWithErrorMessage =
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.creditCardCVC();
      // Pass
      expect(validator('123'), isNull);
      expect(validator('1234'), isNull);
      // Fail
      expect(validator('12'), isNotNull);
      expect(validator('12345'), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.creditCardCVC(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('123'), isNull);
      // Fail
      expect(validator('12'), customErrorMessage);
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

      final validatorWithErrorMessage = FormBuilderValidators.phoneNumber(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.colorCode();
      // Pass
      expect(validator('#FFFFFF'), isNull);
      expect(validator('rgb(255, 255, 255)'), isNull);
      // Fail
      expect(validator('#ZZZZZZ'), isNotNull);
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      final validatorWithErrorMessage = FormBuilderValidators.colorCode(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('#FFFFFF'), isNull);
      // Fail
      expect(validatorWithErrorMessage('#ZZZZZZ'), customErrorMessage);
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
    'FormBuilderValidators.fileExtension',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.fileExtension(
        allowedExtensions: ['txt', 'pdf'],
      );
      // Pass
      expect(validator(File('test.txt').path), isNull);
      // Fail
      expect(validator(File('test.doc').path), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.fileExtension(
        allowedExtensions: ['txt', 'pdf'],
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage(File('test.txt').path), isNull);
      // Fail
      expect(
          validatorWithErrorMessage(File('test.doc').path), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.fileSize(
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
    'FormBuilderValidators.username',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.username();
      // Pass
      expect(validator('hello'), isNull);
      expect(validator('hello12345'), isNull);
      // Fail
      expect(validator('hello@'), isNotNull);
      expect(validator('he'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.username(
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

      final validatorWithErrorMessage = FormBuilderValidators.password(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.alphabetical();
      // Pass
      expect(validator('Hello'), isNull);
      expect(validator('world'), isNull);
      // Fail
      expect(validator('Hello123'), isNotNull);
      expect(validator('123'), isNotNull);
      expect(validator('!@#'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.alphabetical(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.uuid();
      // Pass
      expect(validator('123e4567-e89b-12d3-a456-426614174000'), isNull);
      // Fail
      expect(validator('not-a-uuid'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.uuid(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.json();
      // Pass
      expect(validator('{"key": "value"}'), isNull);
      // Fail
      expect(validator('not-json'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.json(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.latitude();
      // Pass
      expect(validator('45.0'), isNull);
      expect(validator('-90.0'), isNull);
      // Fail
      expect(validator('91.0'), isNotNull);
      expect(validator('latitude'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.latitude(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.longitude();
      // Pass
      expect(validator('90.0'), isNull);
      expect(validator('-180.0'), isNull);
      // Fail
      expect(validator('181.0'), isNotNull);
      expect(validator('longitude'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.longitude(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.base64();
      // Pass
      expect(validator('SGVsbG8gd29ybGQ='), isNull);
      // Fail
      expect(validator('not-base64'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.base64(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.path();
      // Pass
      expect(validator('/path/to/file'), isNull);
      // Fail
      expect(validator('path\\to\\file'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.path(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('/path/to/file'), isNull);
      // Fail
      expect(validatorWithErrorMessage('path\\to\\file'), customErrorMessage);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.oddNumber(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.evenNumber();
      // Pass
      expect(validator('2'), isNull);
      expect(validator('4'), isNull);
      // Fail
      expect(validator('3'), isNotNull);
      expect(validator('5'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.evenNumber(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.portNumber();
      // Pass
      expect(validator('8080'), isNull);
      expect(validator('80'), isNull);
      // Fail
      expect(validator('70000'), isNotNull);
      expect(validator('-1'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.portNumber(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.macAddress();
      // Pass
      expect(validator('00:1B:44:11:3A:B7'), isNull);
      expect(validator('00-1B-44-11-3A-B7'), isNull);
      // Fail
      expect(validator('invalid-mac'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.macAddress(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('00:1B:44:11:3A:B7'), isNull);
      // Fail
      expect(validatorWithErrorMessage('invalid-mac'), customErrorMessage);
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
    'FormBuilderValidators.or',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.or([
        FormBuilderValidators.endsWith(suffix: 'world'),
        FormBuilderValidators.startsWith(prefix: 'Hello'),
      ]);
      // Pass
      expect(validator('Hello world'), isNull);
      expect(validator('Hello'), isNull);
      // Fail
      expect(validator('123 hello'), isNotNull);
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
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
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.transform<String>(
        FormBuilderValidators.required(errorText: customErrorMessage),
        (value) => value?.trim() ?? '',
      );
      // Pass
      expect(validatorWithErrorMessage(' trimmed '), isNull);
      // Fail
      expect(validatorWithErrorMessage('  '), customErrorMessage);
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
      expect(validator(null), isNotNull);

      final validatorWithErrorMessage = FormBuilderValidators.skipWhen<String>(
        (value) => value == 'skip',
        FormBuilderValidators.required(errorText: customErrorMessage),
      );
      // Pass
      expect(validatorWithErrorMessage('skip'), isNull);
      // Fail
      expect(validatorWithErrorMessage(''), customErrorMessage);
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
      expect(validator(null), isNull);
      expect(validator(''), isNull);

      //TODO Add object test
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
      expect(validator(''), isNotNull); // Empty string
      expect(validator('INVALIDIBAN'), isNotNull); // Invalid IBAN
      expect(validator('GB82WEST1234569876543212345'), isNotNull); // Too long
      expect(validator('GB82WEST1234'), isNotNull); // Too short

      final validatorWithErrorMessage = FormBuilderValidators.iban(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('GB82WEST12345698765432'), isNull);
      // Fail
      expect(validatorWithErrorMessage('INVALIDIBAN'), customErrorMessage);
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
    'FormBuilderValidators.bic',
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.bic();
      // Pass
      expect(validator('DEUTDEFF'), isNull); // A valid German BIC
      expect(
          validator('DEUTDEFF500'), isNull); // A valid German BIC with branch
      // Fail
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull); // Empty string
      expect(validator('INVALIDBIC'), isNotNull); // Invalid BIC
      expect(validator('DEUTDEFF5000'), isNotNull); // Too long
      expect(validator('DEUTDEFF5'), isNotNull); // Too short

      final validatorWithErrorMessage = FormBuilderValidators.bic(
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
    (WidgetTester tester) => testValidations(tester, (context) {
      final validator = FormBuilderValidators.isbn();
      // Pass
      expect(validator('978-3-16-148410-0'), isNull); // A valid ISBN-13
      expect(validator('0-306-40615-2'), isNull); // A valid ISBN-10
      expect(
          validator('9783161484100'), isNull); // A valid ISBN-13 without dashes
      expect(validator('0306406152'), isNull); // A valid ISBN-10 without dashes
      expect(validator('3-16-148410-X'),
          isNull); // A valid ISBN-10 with X as check digit

      // Fail
      expect(validator(null), isNotNull); // Null value
      expect(validator(''), isNotNull); // Empty string
      expect(validator('INVALIDISBN'), isNotNull); // Invalid ISBN string
      expect(validator('978-3-16-148410-00'), isNotNull); // Too long
      expect(validator('3-16-148410-00'), isNotNull); // Too short
      expect(validator('978-3-16-14841X-0'),
          isNotNull); // Invalid character in ISBN-13
      expect(validator('0-306-40615-X'),
          isNotNull); // Invalid character in ISBN-10
      expect(validator('978-3-16-148410-1'),
          isNotNull); // Invalid check digit for ISBN-13
      expect(validator('0-306-40615-1'),
          isNotNull); // Invalid check digit for ISBN-10
      expect(validator('1234567890123'), isNotNull); // Random invalid ISBN-13
      expect(validator('1234567890'), isNotNull); // Random invalid ISBN-10
      expect(validator('978316148410'), isNotNull); // ISBN-13 too short
      expect(validator('030640615'), isNotNull); // ISBN-10 too short
      expect(
          validator('978-3-16-1484100-0'), isNotNull); // Extra digit in ISBN-13
      expect(validator('0-306-40615-22'), isNotNull); // Extra digit in ISBN-10
      expect(validator('978-3-16-14'), isNotNull); // Incomplete ISBN-13
      expect(validator('0-306'), isNotNull); // Incomplete ISBN-10

      final validatorWithErrorMessage = FormBuilderValidators.isbn(
        errorText: customErrorMessage,
      );
      // Pass
      expect(validatorWithErrorMessage('978-3-16-148410-0'), isNull);
      // Fail
      expect(validatorWithErrorMessage('INVALIDISBN'), customErrorMessage);
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
