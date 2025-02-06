import '../../localization/l10n.dart';
import 'constants.dart';

/// {@macro validator_is_after}
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
                .dateMustBeAfterErrorText(reference.toLocal());
  };
}

/// {@macro validator_is_before}
Validator<DateTime> isBefore(
  DateTime reference, {
  String Function(DateTime input, DateTime reference)? isBeforeMsg,
  bool inclusive = false,
}) {
  return (DateTime input) {
    return input.isBefore(reference) ||
            (inclusive ? input.isAtSameMomentAs(reference) : false)
        ? null
        : isBeforeMsg?.call(input, reference) ??
            FormBuilderLocalizations.current
                .dateMustBeBeforeErrorText(reference.toLocal());
  };
}

/// {@macro validator_is_date_time_between}
Validator<DateTime> isDateTimeBetween(
  DateTime minReference,
  DateTime maxReference, {
  String Function(DateTime input, DateTime minReference, DateTime maxReference)?
      isDateTimeBetweenMsg,
  bool minInclusive = false,
  bool maxInclusive = false,
}) {
  assert(minReference.isBefore(maxReference),
      'leftReference must be before rightReference');
  return (DateTime input) {
    return (input.isBefore(maxReference) ||
                (maxInclusive
                    ? input.isAtSameMomentAs(maxReference)
                    : false)) &&
            (input.isAfter(minReference) ||
                (minInclusive ? input.isAtSameMomentAs(minReference) : false))
        ? null
        : isDateTimeBetweenMsg?.call(input, minReference, maxReference) ??
            FormBuilderLocalizations.current.dateMustBeBetweenErrorText(
                minReference.toLocal(), maxReference.toLocal());
  };
}
