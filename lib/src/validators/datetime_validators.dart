import '../../localization/l10n.dart';
import 'constants.dart';

/// {@template validator_is_after}
/// Creates a [DateTime] validator that checks if an input date occurs after
/// `reference`.
///
/// ## Parameters
/// - `reference` (`DateTime`): The baseline date against which the input will be compared.
///   This serves as the minimum acceptable date (exclusive by default).
/// - `isAfterMsg` (`String Function(DateTime input, DateTime reference)?`): Optional custom
///   error message generator. When provided, it receives both the input and reference
///   dates to construct a context-aware error message.
/// - `inclusive` (`bool`): When set to `true`, allows the input date to exactly match
///   the reference date. Defaults to `false`, requiring strictly later dates.
///
/// ## Returns
/// Returns a `Validator<DateTime>` function that:
/// - Returns `null` if validation passes (input is after reference)
/// - Returns an error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Basic usage requiring date after January 1st, 2025
/// final validator = isAfter(DateTime(2025));
///
/// // Inclusive validation allowing exact match
/// final inclusiveValidator = isAfter(
///   DateTime(2024),
///   inclusive: true,
/// );
///
/// // Custom error message
/// final customValidator = isAfter(
///   DateTime(2024),
///   isAfterMsg: (_, ref) => 'Please select a date after ${ref.toString()}',
/// );
/// ```
/// {@endtemplate}
Validator<DateTime> isAfter(
  DateTime reference, {
  String Function(DateTime input, DateTime reference)? isAfterMsg,
  bool inclusive = false,
}) {
  return (DateTime input) {
    return input.isAfter(reference) ||
            (inclusive ? input.isAtSameMomentAs(reference) : false)
        ? null
        : isAfterMsg?.call(input, reference) ??
            FormBuilderLocalizations.current
                .dateMustBeAfterErrorText(reference);
  };
}

/// This function returns a validator that checks if the user [DateTime] input is
/// in the future (after [DateTime.now]). If the checking results true, the validator
/// returns `null`. Otherwise, it returns `isInTheFutureMsg`, if provided, or
/// `FormBuilderLocalizations.current.dateMustBeInTheFutureErrorText`.
Validator<DateTime> isInTheFuture({
  String? isInTheFutureMsg,
}) {
  return (DateTime value) {
    return value.isAfter(DateTime.now())
        ? null
        : isInTheFutureMsg ??
            FormBuilderLocalizations.current.dateMustBeInTheFutureErrorText;
  };
}

String tmpIsBeforeErrorMsg(DateTime reference) {
  return 'The date must be before ${reference.toLocal()}';
}

/// This function returns a validator that checks if the user [DateTime] input is
/// before (or equal, if `inclusive` is true) to `reference`. If the checking results
/// true, the validator returns `null`. Otherwise, it returns `isBeforeMsg`, if
/// provided, or `FormBuilderLocalizations.current.isBeforeErrorText`.
Validator<DateTime> isBefore(
  DateTime reference, {
  String Function(DateTime)? isBeforeMsg,
  bool inclusive = false,
}) {
  return (DateTime value) {
    return value.isBefore(reference) ||
            (inclusive ? value.isAtSameMomentAs(reference) : false)
        ? null
        : isBeforeMsg?.call(reference) ?? tmpIsBeforeErrorMsg(reference);
  };
}

/// This function returns a validator that checks if the user [DateTime] input is
/// in the past (before [DateTime.now]). If the checking results true, the validator
/// returns `null`. Otherwise, it returns `isInThePastMsg`, if provided, or
/// `FormBuilderLocalizations.current.dateMustBeInThePastErrorText`.
Validator<DateTime> isInThePast({
  String? isInThePastMsg,
}) {
  return (DateTime value) {
    return value.isBefore(DateTime.now())
        ? null
        : isInThePastMsg ??
            FormBuilderLocalizations.current.dateMustBeInThePastErrorText;
  };
}

String tmpIsDateTimeBetweenErrorMsg(DateTime left, DateTime right) {
  return 'The date must be after ${left.toLocal()} and before ${right.toLocal()}';
}

/// This function returns a validator that checks if the user [DateTime] input is
/// between `leftReference` and `rightReference` [DateTime]s. If the checking results
/// true, the validator returns `null`. Otherwise, it returns `isDateTimeBetweenMsg`, if
/// provided, or `FormBuilderLocalizations.current.isDateTimeBetweenErrorText`.
Validator<DateTime> isDateTimeBetween(
  DateTime leftReference,
  DateTime rightReference, {
  String Function(DateTime, DateTime)? isDateTimeBetweenMsg,
  bool leftInclusive = false,
  bool rightInclusive = false,
}) {
  assert(leftReference.isBefore(rightReference),
      'leftReference must be before rightReference');
  return (DateTime value) {
    return (value.isBefore(rightReference) ||
                (rightInclusive
                    ? value.isAtSameMomentAs(rightReference)
                    : false)) &&
            (value.isAfter(leftReference) ||
                (leftInclusive ? value.isAtSameMomentAs(leftReference) : false))
        ? null
        : isDateTimeBetweenMsg?.call(leftReference, rightReference) ??
            tmpIsDateTimeBetweenErrorMsg(leftReference, rightReference);
  };
}
