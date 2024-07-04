import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template file_name_validator_template}
/// [FileNameValidator] extends [BaseValidator] to validate if a string is a valid file name.
///
/// This validator checks if the string matches the specified regex pattern for valid file names.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the file name format. Defaults to a standard file name regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class FileNameValidator extends BaseValidator<String> {
  /// Constructor for the file name validator.
  FileNameValidator({
    /// {@macro filename_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _fileName;

  /// The regular expression used to validate the file name format.
  final RegExp regex;

  /// {@template filename_template}
  /// This regex matches valid file name characters.
  ///
  /// - It allows letters, digits, underscores, hyphens, and periods.
  /// - It ensures that the file name does not contain invalid characters.
  ///
  /// Examples: valid_filename.txt, another-file_name.jpg
  /// {@endtemplate}
  static final RegExp _fileName = RegExp(r'^[a-zA-Z0-9_\-\.]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.fileNameErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isFileName(valueCandidate) ? null : errorText;
  }

  /// Checks if the provided value is a valid file name.
  ///
  /// ## Parameters:
  /// - [valueCandidate] The string to be evaluated.
  ///
  /// ## Returns:
  /// A boolean indicating whether the value is a valid file name.
  bool isFileName(String valueCandidate) {
    return regex.hasMatch(valueCandidate);
  }
}
