import '../../form_builder_validators.dart';

/// {@template path_validator_template}
/// [PathValidator] extends [TranslatedValidator] to validate if a string represents a valid file path.
///
/// This validator checks if the string matches the specified regex pattern for valid file paths.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the file path format. Defaults to a standard file path regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class PathValidator extends TranslatedValidator<String> {
  /// Constructor for the file path validator.
  PathValidator({
    /// {@macro file_path_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _filePath;

  /// The regular expression used to validate the file path format.
  final RegExp regex;

  /// {@template file_path_template}
  /// This regex matches file paths.
  ///
  /// - It allows letters, digits, underscores, hyphens, and forward slashes.
  ///
  /// Examples: /path/to/file, C:/Users/Name/Documents
  /// {@endtemplate}
  static final RegExp _filePath = RegExp(
    r'^((\/|\\|[a-zA-Z]:\/)?([^<>:"|?*]+(\/|\\)?)+)$',
  );

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.pathErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }
    return null;
  }
}
