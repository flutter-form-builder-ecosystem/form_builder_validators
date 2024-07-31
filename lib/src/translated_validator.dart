import '../form_builder_validators.dart';

/// Base class for all validators that return a translated error message.
abstract class TranslatedValidator<T> extends BaseValidator<T> {
  /// Creates a new instance of the validator.
  const TranslatedValidator({super.errorText, super.checkNullOrEmpty});

  @override
  String get errorText => super.errorText ?? translatedErrorText;

  /// The translated error message returned if the value is invalid.
  String get translatedErrorText;
}
