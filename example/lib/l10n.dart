import 'package:flutter/material.dart';

import 'localization/intl/app_localizations.dart';

/// Extension for the app localization.
extension AppLocalizationsExtensions on BuildContext {
  /// Get the L10n localization.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
