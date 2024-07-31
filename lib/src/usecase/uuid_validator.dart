import '../../form_builder_validators.dart';

/// {@template uuid_validator_template}
/// [UuidValidator] extends [TranslatedValidator] to validate if a string is a valid UUID (version 4).
///
/// This validator checks if the value matches the specified regex pattern for UUID format, including hyphens.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the UUID format. Defaults to a regex that matches version 4 UUIDs.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class UuidValidator extends TranslatedValidator<String> {
  /// Constructor for the UUID validator.
  UuidValidator({
    /// {@macro uuid_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _uuid;

  /// The regular expression used to validate the UUID format.
  final RegExp regex;

  /// {@template uuid_template}
  /// This regex matches UUIDs (version 4).
  ///
  /// - It validates the format of a UUID, including hyphens.
  ///
  /// Examples: 123e4567-e89b-12d3-a456-426614174000
  /// {@endtemplate}
  static final RegExp _uuid = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.uuidErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return regex.hasMatch(valueCandidate) ? null : errorText;
  }
}
