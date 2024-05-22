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
}
