import '../../localization/l10n.dart';
import '../base_validator.dart';

class FileNameValidator extends BaseValidator<String> {
  const FileNameValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.fileNameErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isFileName(valueCandidate) ? null : errorText;
  }

  bool isFileName(String valueCandidate) {
    return RegExp(r'^[a-zA-Z0-9_\-\.]+$').hasMatch(valueCandidate);
  }
}
