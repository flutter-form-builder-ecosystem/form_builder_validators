import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@macro validator_is_equal}
Validator<T> isEqual<T extends Object?>(
  T referenceValue, {
  String Function(T input, T referenceValue)? isEqualMsg,
}) {
  return (T input) {
    return referenceValue == input
        ? null
        : isEqualMsg?.call(input, referenceValue) ??
            FormBuilderLocalizations.current
                .equalErrorText(referenceValue.toString());
  };
}

/// {@macro validator_is_not_equal}
Validator<T> isNotEqual<T extends Object?>(
  T referenceValue, {
  String Function(T input, T referenceValue)? isNotEqualMsg,
}) {
  return (T input) {
    return referenceValue != input
        ? null
        : isNotEqualMsg?.call(input, referenceValue) ??
            FormBuilderLocalizations.current
                .notEqualErrorText(referenceValue.toString());
  };
}
