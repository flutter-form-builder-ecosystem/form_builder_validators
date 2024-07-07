import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'home_page.dart';
import 'localization/intl/app_localizations.dart';
import 'override_form_builder_localizations_en.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  /// The main application widget constructor.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Builder Validators Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        ...GlobalMaterialLocalizations.delegates,
        // Placed in front of `FormBuilderLocalizations.delegate`
        ...AppLocalizations.localizationsDelegates,
        OverrideFormBuilderLocalizationsEn.delegate,
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
