import '../../localization/l10n.dart';
import '../base_validator.dart';

class PathValidator extends BaseValidator<String?> {
  PathValidator({
    /// {@macro file_path_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _filePath;

  final RegExp regex;

  /// {@template file_path_template}
  /// This regex matches file paths.
  ///
  /// - It allows letters, digits, underscores, hyphens, and forward slashes.
  ///
  /// Examples: /path/to/file, C:/Users/Name/Documents
  /// {@endtemplate}
  static final RegExp _filePath = RegExp(r'^[a-zA-Z0-9_\-\/]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.pathErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    if (!regex.hasMatch(valueCandidate!)) {
      return errorText;
    }
    return null;
  }
}
