import 'package:example/override_form_builder_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Builder Validators Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      supportedLocales: const [
        ...FormBuilderLocalizations.supportedLocales,
      ],
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        // Placed in front of `FormBuilderLocalizations.delegate`
        OverrideFormBuilderLocalizationsEn.delegate,
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
