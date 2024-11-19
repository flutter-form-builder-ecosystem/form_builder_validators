import '../localization/l10n.dart';
import 'constants.dart';

String tmpIsAfterErrorMsg(DateTime reference) =>
    'The date must be after $reference';

/// This function returns a validator that checks if the user [DateTime] input is
/// after (or equal, if `inclusive` is true) to `reference`. If the checking results
/// true, the validator returns `null`. Otherwise, it returns `isAfterMsg`, if
/// provided, or `FormBuilderLocalizations.current.isAfterErrorText`.
Validator<DateTime> isAfter(
  DateTime reference, {
  String Function(DateTime)? isAfterMsg,
  bool inclusive = false,
}) {
  return (DateTime value) {
    return value.isAfter(reference) ||
            (inclusive ? value.isAtSameMomentAs(reference) : false)
        ? null
        : isAfterMsg?.call(reference) ?? tmpIsAfterErrorMsg(reference);
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
