import 'dart:convert';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class Base64Validator extends BaseValidator<String> {
  const Base64Validator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.base64ErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return isBase64(valueCandidate!) ? null : errorText;
  }

  /// check if the string is a valid base64 string
  bool isBase64(String value) {
    try {
      base64Decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
