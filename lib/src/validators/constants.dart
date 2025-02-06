/// A validator function receives an object of type `T`, which can be any
/// type/subtype of nullable Object, and then it returns `null`, if the input
/// is valid or a [String] with the validation failure message.
///
/// ## Why do not we use Flutter's `FormFieldValidator`?
/// Both signatures are very close to each other:
/// `FormFieldValidator<T> = String? Function(T? value)`
/// `Validator<T extends Object?> = String? Function(T value)`
/// But there is an important difference: the `T` from [Validator] extends from
/// nullable Object and it parameter is not necessarily nullable, which makes
/// it possible to create validator that assume the input is not null. With
/// `FormFieldValidator`, the input must be checked for null value even if the
/// validator expects to receive only non-nullable inputs.
/// - Example:
/// ```dart
/// Validator<String> isLowerCase1 = (value) {
///   return value == value.toLowerCase() ? null : 'should be lowercase';
/// };
/// FormFieldValidator<String> isLowerCase2 = (value) {
///   // toLowerCase is called conditionally if `value` is not null.
///   return value == value?.toLowerCase() ? null : 'should be lowercase';
/// };
/// ```
///
typedef Validator<T extends Object?> = String? Function(T);
