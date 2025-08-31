import '../../localization/l10n.dart';
import 'constants.dart';

/// {@macro validator_after}
Validator<DateTime> after(
  DateTime reference, {
  String Function(DateTime input, DateTime reference)? afterMsg,
  bool inclusive = false,
}) {
  return (DateTime input) {
    return input.isAfter(reference) ||
            (inclusive ? input.isAtSameMomentAs(reference) : false)
        ? null
        : afterMsg?.call(input, reference) ??
              FormBuilderLocalizations.current.dateMustBeAfterErrorText(
                reference.toLocal(),
              );
  };
}

/// {@macro validator_before}
Validator<DateTime> before(
  DateTime reference, {
  String Function(DateTime input, DateTime reference)? beforeMsg,
  bool inclusive = false,
}) {
  return (DateTime input) {
    return input.isBefore(reference) ||
            (inclusive ? input.isAtSameMomentAs(reference) : false)
        ? null
        : beforeMsg?.call(input, reference) ??
              FormBuilderLocalizations.current.dateMustBeBeforeErrorText(
                reference.toLocal(),
              );
  };
}

/// {@macro validator_between_date_time}
Validator<DateTime> betweenDateTime(
  DateTime minReference,
  DateTime maxReference, {
  String Function(DateTime input, DateTime minReference, DateTime maxReference)?
  betweenDateTimeMsg,
  bool minInclusive = false,
  bool maxInclusive = false,
}) {
  assert(
    minReference.isBefore(maxReference),
    'leftReference must be before rightReference',
  );
  return (DateTime input) {
    return (input.isBefore(maxReference) ||
                (maxInclusive
                    ? input.isAtSameMomentAs(maxReference)
                    : false)) &&
            (input.isAfter(minReference) ||
                (minInclusive ? input.isAtSameMomentAs(minReference) : false))
        ? null
        : betweenDateTimeMsg?.call(input, minReference, maxReference) ??
              FormBuilderLocalizations.current.dateMustBeBetweenErrorText(
                minReference.toLocal(),
                maxReference.toLocal(),
              );
  };
}
