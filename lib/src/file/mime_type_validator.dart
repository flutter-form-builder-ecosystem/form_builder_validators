import '../../form_builder_validators.dart';

/// {@template mime_type_validator_template}
/// [MimeTypeValidator] extends [TranslatedValidator] to validate if a string represents a valid MIME type.
///
/// This validator checks if the string matches a valid MIME type pattern.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the MIME type format. Defaults to a standard MIME type regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MimeTypeValidator extends TranslatedValidator<String> {
  /// Constructor for the MIME type validator.
  MimeTypeValidator({
    RegExp? regex,

    /// {@macro mimetype_validator_template}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _mimeType;

  /// The regular expression used to validate the MIME type format.
  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.invalidMimeTypeErrorText;

  /// {@template mimetype_validator_template}
  /// This regex matches valid MIME types.
  ///
  /// - It ensures the string is in the format 'type/subtype'.
  /// - It supports common MIME types such as 'application/json', 'image/png', etc.
  ///
  /// Examples: application/json, image/png
  /// {@endtemplate}
  static final RegExp _mimeType = RegExp(
    r'^[a-zA-Z0-9!#$&^_-]+\/[a-zA-Z0-9!#$&^_-]+$',
  );

  @override
  String? validateValue(String valueCandidate) {
    return regex.hasMatch(valueCandidate) ? null : errorText;
  }
}
