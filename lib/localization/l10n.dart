import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'intl/messages.dart';
import 'intl/messages_en.dart';

/// The actual `Localizations` class is [FormBuilderLocalizationsImpl],
/// this class exists only for forward compatibility purposes...
class FormBuilderLocalizations {
  FormBuilderLocalizations._();

  /// The [FormBuilderLocalizationsImpl] instance for the current context.
  static FormBuilderLocalizationsImpl of(BuildContext context) {
    return Localizations.of<FormBuilderLocalizationsImpl>(
          context,
          FormBuilderLocalizationsImpl,
        ) ??
        _default;
  }

  /// The [FormBuilderLocalizationsImpl] instance delegate.
  static const LocalizationsDelegate<FormBuilderLocalizationsImpl> delegate =
      FormBuilderLocalizationsDelegate();

  /// The [GlobalMaterialLocalizations.delegate],
  /// [GlobalCupertinoLocalizations.delegate], and
  /// [GlobalWidgetsLocalizations.delegate] delegates.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// The supported locales.
  static const List<Locale> supportedLocales =
      FormBuilderLocalizationsImpl.supportedLocales;

  static final FormBuilderLocalizationsImplEn _default =
      FormBuilderLocalizationsImplEn();

  static FormBuilderLocalizationsImpl? _current;

  /// Set the current [FormBuilderLocalizationsImpl] instance.
  static void setCurrentInstance(FormBuilderLocalizationsImpl? current) =>
      _current = current;

  /// The current [FormBuilderLocalizationsImpl] instance.
  static FormBuilderLocalizationsImpl get current => _current ?? _default;
}

/// The actual `Localizations` class is [FormBuilderLocalizationsImpl],
class FormBuilderLocalizationsDelegate
    extends LocalizationsDelegate<FormBuilderLocalizationsImpl> {
  /// Constructor for the delegate class.
  const FormBuilderLocalizationsDelegate();

  @override
  Future<FormBuilderLocalizationsImpl> load(Locale locale) {
    final FormBuilderLocalizationsImpl instance =
        lookupFormBuilderLocalizationsImpl(locale);
    FormBuilderLocalizations.setCurrentInstance(instance);
    return SynchronousFuture<FormBuilderLocalizationsImpl>(instance);
  }

  @override
  bool isSupported(Locale locale) =>
      FormBuilderLocalizationsImpl.supportedLocales
          .map((Locale e) => e.languageCode)
          .contains(locale.languageCode);

  @override
  bool shouldReload(FormBuilderLocalizationsDelegate old) => false;
}
