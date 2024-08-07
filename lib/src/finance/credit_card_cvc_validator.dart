import '../../form_builder_validators.dart';

/// {@template credit_card_cvc_validator_template}
/// [CreditCardCvcValidator] extends [TranslatedValidator] to validate if a string represents a valid credit card CVC (Card Verification Code).
///
/// This validator checks if the CVC is a numeric string of length 3 or 4.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class CreditCardCvcValidator extends TranslatedValidator<String> {
  /// Constructor for the credit card CVC validator.
  const CreditCardCvcValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.creditCardCVCErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final int? cvc = int.tryParse(valueCandidate);
    if (cvc == null || valueCandidate.length < 3 || valueCandidate.length > 4) {
      return errorText;
    }
    return null;
  }
}
