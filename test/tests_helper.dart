// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/localization/l10n.dart';

/// Test Harness for running Validations
Future<void> testValidations(
  WidgetTester tester,
  void Function(BuildContext) validations,
) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
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
