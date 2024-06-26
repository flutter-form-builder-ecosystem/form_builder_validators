import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class LogValidator<T> extends BaseValidator<T> {
  const LogValidator(
    String Function(T? value)? this.log, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final String Function(T? value)? log;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(T? valueCandidate) {
    if (log != null) {
      debugPrint(log!(valueCandidate));
    } else if (valueCandidate != null) {
      debugPrint(valueCandidate.toString());
    } else {
      debugPrint(errorText);
    }
    return null;
  }
}
