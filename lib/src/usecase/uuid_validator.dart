import '../../localization/l10n.dart';
import '../base_validator.dart';

class UuidValidator extends BaseValidator<String> {
  UuidValidator({
    /// {@macro uuid_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _uuid;

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
  String? validateValue(String? valueCandidate) {
    return _uuid.hasMatch(valueCandidate!) ? null : errorText;
  }
}
