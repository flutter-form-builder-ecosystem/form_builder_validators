import '../../localization/l10n.dart';
import '../base_validator.dart';

class FileExtensionValidator extends BaseValidator<String> {
  const FileExtensionValidator(
    this.allowedExtensions, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final List<String> allowedExtensions;

  List<String> get _allowedExtensionsLowerCase =>
      allowedExtensions.map((String e) => e.toLowerCase()).toList();

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.fileExtensionErrorText(
        _allowedExtensionsLowerCase.join(', '),
      );

  @override
  String? validateValue(String? valueCandidate) {
    final String extension =
        fileExtensionFromPath(valueCandidate!).toLowerCase();

    if (!_allowedExtensionsLowerCase.contains(extension)) {
      return errorText;
    }
    return null;
  }

  String fileExtensionFromPath(String path) {
    final List<String> parts = path.split('.');

    assert(
      parts.length > 1 && parts.last.isNotEmpty,
      'Invalid file path format: $path. Path should contain a valid extension.',
    );

    return parts.last;
  }
}
