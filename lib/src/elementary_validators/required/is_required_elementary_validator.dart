import '../../../localization/l10n.dart';
import '../../base_elementary_validator.dart';

/// {@template is_required_elementary_validator}
/// This validator checks if a value was provided. On the validation
/// process, if an empty value is provided, it triggers the [otherwise]
/// conditions. If all of them fails, it returns an error message, otherwise, it
/// returns null.
///
/// ## Parameters
/// - [errorText] The error message returned if the validation fails.
/// - [and] List of elementary validators that will be executed if this
/// validator passes.
/// - [otherwise] List of elementary validators that will be executed if this
/// validator fails. They are alternative validation in case this fails.
/// {@endtemplate}
final class IsRequiredElementaryValidator<T extends Object>
    extends BaseElementaryValidator<T?, T> {
  /// {@macro is_required_elementary_validator}
  const IsRequiredElementaryValidator({
    super.errorText,
    super.and,
    super.otherwise,
  });

  @override
  (bool, T?) transformValueIfValid(T? value) {
    if (value != null &&
        (value is! String || value.trim().isNotEmpty) &&
        (value is! Iterable || value.isNotEmpty) &&
        (value is! Map || value.isNotEmpty)) {
      return (true, value);
    }
    return (false, null);
  }

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;
}
