import '../../localization/l10n.dart';
import '../base_validator.dart';

class MimeTypeValidator extends BaseValidator<String> {
  MimeTypeValidator({
    RegExp? regex,

    /// {@macro mimetype_validator_template}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _mineType;

  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.invalidMimeTypeErrorText;

  /// {@template mimetype_validator_template}
  /// This list contains valid MIME types that the field's value can match.
  ///
  /// - It includes common MIME types like 'application/json', 'image/png', etc.
  /// - It can be used to validate that the field's value matches one of the valid MIME types.
  ///
  /// Examples: application/json, image/png
  /// {@endtemplate}
  static final RegExp _mineType = RegExp(
    r'^[a-zA-Z0-9!#$&^_-]+\/[a-zA-Z0-9!#$&^_-]+$',
  );

  @override
  String? validateValue(String valueCandidate) {
    return regex.hasMatch(valueCandidate) ? null : errorText;
  }
}
