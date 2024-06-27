import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// Created by ipcjs on 2022/10/31.
class OverrideFormBuilderLocalizationsEn
    extends FormBuilderLocalizationsImplEn {
  /// Constructor for the override class.
  OverrideFormBuilderLocalizationsEn();

  static const LocalizationsDelegate<FormBuilderLocalizationsImpl> delegate =
      _LocalizationsDelegate();

  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  // Override a field and return your translation.
  @override
  String get requiredErrorText => 'override: This field cannot be empty.';
}

class _LocalizationsDelegate
    extends LocalizationsDelegate<FormBuilderLocalizationsImpl> {
  const _LocalizationsDelegate();

  @override
  Future<FormBuilderLocalizationsImpl> load(Locale locale) {
    final OverrideFormBuilderLocalizationsEn instance =
        OverrideFormBuilderLocalizationsEn();
    // IMPORTANT!! must to invoke setCurrentInstance()
    FormBuilderLocalizations.setCurrentInstance(instance);
    return SynchronousFuture<FormBuilderLocalizationsImpl>(instance);
  }

  @override
  bool isSupported(Locale locale) =>
      OverrideFormBuilderLocalizationsEn.supportedLocales.contains(locale);

  @override
  bool shouldReload(_LocalizationsDelegate old) => false;
}
