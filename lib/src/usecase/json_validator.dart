import 'dart:convert';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class JsonValidator extends BaseValidator<String> {
  const JsonValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.jsonErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return isJSON(valueCandidate!) ? null : errorText;
  }

  /// check if the string is valid JSON
  bool isJSON(String value) {
    try {
      jsonDecode(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
