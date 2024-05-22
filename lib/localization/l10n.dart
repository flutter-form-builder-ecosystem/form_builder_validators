import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'intl/messages.dart';
import 'intl/messages_en.dart';

/// The actual `Localizations` class is [FormBuilderLocalizationsImpl], this class exists only for forward compatibility purposes...
class FormBuilderLocalizations {
  FormBuilderLocalizations._();

  static FormBuilderLocalizationsImpl of(BuildContext context) {
    return Localizations.of<FormBuilderLocalizationsImpl>(
          context,
          FormBuilderLocalizationsImpl,
        ) ??
        _default;
  }

  static const LocalizationsDelegate<FormBuilderLocalizationsImpl> delegate =
      FormBuilderLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales =
      FormBuilderLocalizationsImpl.supportedLocales;

  static final _default = FormBuilderLocalizationsImplEn();
  static FormBuilderLocalizationsImpl? _current;

  static void setCurrentInstance(FormBuilderLocalizationsImpl? current) =>
      _current = current;

  static FormBuilderLocalizationsImpl get current => _current ?? _default;
}

class FormBuilderLocalizationsDelegate
    extends LocalizationsDelegate<FormBuilderLocalizationsImpl> {
  const FormBuilderLocalizationsDelegate();

  @override
  Future<FormBuilderLocalizationsImpl> load(Locale locale) {
    final instance = lookupFormBuilderLocalizationsImpl(locale);
    FormBuilderLocalizations.setCurrentInstance(instance);
    return SynchronousFuture<FormBuilderLocalizationsImpl>(instance);
  }

  @override
  bool isSupported(Locale locale) =>
      FormBuilderLocalizationsImpl.supportedLocales
          .map((e) => e.languageCode)
          .contains(locale.languageCode);

  @override
  bool shouldReload(FormBuilderLocalizationsDelegate old) => false;
}
