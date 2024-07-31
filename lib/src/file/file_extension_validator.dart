import '../../form_builder_validators.dart';

/// {@template file_extension_validator_template}
/// [FileExtensionValidator] extends [TranslatedValidator] to validate if a file path has an allowed extension.
///
/// This validator checks if the file extension is within the list of allowed extensions.
///
/// ## Parameters:
///
/// - [allowedExtensions] The list of allowed file extensions.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class FileExtensionValidator extends TranslatedValidator<String> {
  /// Constructor for the file extension validator.
  const FileExtensionValidator(
    this.allowedExtensions, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The list of allowed file extensions.
  final List<String> allowedExtensions;

  /// Converts the allowed extensions to lowercase.
  List<String> get _allowedExtensionsLowerCase =>
      allowedExtensions.map((String e) => e.toLowerCase()).toList();

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.fileExtensionErrorText(
        _allowedExtensionsLowerCase.join(', '),
      );

  @override
  String? validateValue(String valueCandidate) {
    final String extension =
        fileExtensionFromPath(valueCandidate).toLowerCase();

    if (!_allowedExtensionsLowerCase.contains(extension)) {
      return errorText;
    }
    return null;
  }

  /// Extracts the file extension from the given file path.
  ///
  /// ## Parameters:
  /// - [path] The file path to extract the extension from.
  ///
  /// ## Returns:
  /// The extracted file extension.
  String fileExtensionFromPath(String path) {
    final List<String> parts = path.split('.');

    assert(
      parts.length > 1 && parts.last.isNotEmpty,
      'Invalid file path format: $path. Path should contain a valid extension.',
    );

    return parts.last;
  }
}
