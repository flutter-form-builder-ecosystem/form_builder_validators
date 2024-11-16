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
