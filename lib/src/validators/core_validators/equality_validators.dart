import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@macro validator_equal}
Validator<T> equal<T extends Object?>(
  T referenceValue, {
  String Function(T input, T referenceValue)? equalMsg,
}) {
  return (T input) {
    return referenceValue == input
        ? null
        : equalMsg?.call(input, referenceValue) ??
              FormBuilderLocalizations.current.equalErrorText(
                referenceValue.toString(),
              );
  };
}

/// {@macro validator_not_equal}
Validator<T> notEqual<T extends Object?>(
  T referenceValue, {
  String Function(T input, T referenceValue)? notEqualMsg,
}) {
  return (T input) {
    return referenceValue != input
        ? null
        : notEqualMsg?.call(input, referenceValue) ??
              FormBuilderLocalizations.current.notEqualErrorText(
                referenceValue.toString(),
              );
  };
}
