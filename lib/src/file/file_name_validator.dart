import '../../localization/l10n.dart';
import '../base_validator.dart';

class FileNameValidator extends BaseValidator<String> {
  FileNameValidator({
    /// {@macro filename_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _fileName;

  final RegExp regex;

  /// {@template filename_template}
  /// This regex matches any character that is not a valid file name character.
  /// - It includes special characters, digits, and lowercase letters.
  /// - It can be used to find invalid file name characters.
  /// Examples: a, 1, @
  /// {@endtemplate}
  static final RegExp _fileName = RegExp(r'^[a-zA-Z0-9_\-\.]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.fileNameErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isFileName(valueCandidate) ? null : errorText;
  }

  bool isFileName(String valueCandidate) {
    return regex.hasMatch(valueCandidate);
  }
}
