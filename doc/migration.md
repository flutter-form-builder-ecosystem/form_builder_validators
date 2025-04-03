## Migrations
### v11 to v12
The next items of this section show how to convert from the old API functions to the closest equivalent using the new APIs. For each item, we try to show how the conversion is made from a validator with all its parameters being used, thus, if your case is simples, probably it will be enough to ignore the additional parameters in the example.
#### checkNullOrEmpty
Before specifying the equivalent to each validator, it is important to deal with the `checkNullOrEmpty` parameter. Every validator from the old API has this parameter, thus we are going to use this section to specify how to handle this situation for most of the cases and we will assume that this aspect is already handled for the following sections. 

The conditions are:
- `checkNullOrEmpty = true` 
```dart
// Old API
FormBuilderValidators.someValidator(..., checkNullOrEmpty:true);

// New API
Validators.required(Validators.someEquivalentValidator(...));

```
- `checkNullOrEmpty = false` 
```dart
// Old API
FormBuilderValidators.someValidator(..., checkNullOrEmpty:false);

// New API
Validators.optional(Validators.someEquivalentValidator(...));
```

#### Bool validators

For the following group of validators (`hasLowercaseChars`, `hasNumericChars`, `hasSpecialChars`, and `hasUppercaseChars`), it is expected to receive a `String` as user input. Thus, if your form widget does not guarantee a `String` input (e.g. it may receive an `Object`), you must wrap the equivalent validator with the type validator for strings (`Validators.string`). 
Apply the following logic to the next items:

```dart
// Replace "Something" with the actual name of the validator
// Old API - No type checking needed
FormBuilderValidators.hasMinSomethingChars(...);

// New API - With type checking when the input is not guaranteed to be a String
Validators.string(Validators.hasMinSomethingChars(...));
```

- `FormBuilderValidators.hasLowercaseChars`
```dart
// Old API
FormBuilderValidators.hasLowercaseChars(
  atLeast: 3,
  regex: RegExp(r'[a-z]'),
  errorText: 'Need at least 3 lowercase letters'
);

// New API equivalent
Validators.hasMinLowercaseChars(
  min: 3,
  customLowercaseCounter: (input) => RegExp(r'[a-z]').allMatches(input).length,
  hasMinLowercaseCharsMsg: (_, __) => 'Need at least 3 lowercase letters'
);
```

- `FormBuilderValidators.hasNumericChars`
```dart
// Old API
FormBuilderValidators.hasNumericChars(
  atLeast: 2,
  regex: RegExp(r'[0-9]'),
  errorText: 'Need at least 2 numbers'
);

// New API equivalent
Validators.hasMinNumericChars(
  min: 2,
  customNumericCounter: (input) => RegExp(r'[0-9]').allMatches(input).length,
  hasMinNumericCharsMsg: (_, __) => 'Need at least 2 numbers'
);
```

- `FormBuilderValidators.hasSpecialChars`
```dart
// Old API
FormBuilderValidators.hasSpecialChars(
  atLeast: 1,
  regex: RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
  errorText: 'Need at least 1 special character'
);

// New API equivalent
Validators.hasMinSpecialChars(
  min: 1,
  customSpecialCounter: (input) => RegExp(r'[!@#$%^&*(),.?":{}|<>]').allMatches(input).length,
  hasMinSpecialCharsMsg: (_, __) => 'Need at least 1 special character'
);
```

- `FormBuilderValidators.hasUppercaseChars`
```dart
// Old API
FormBuilderValidators.hasUppercaseChars(
  atLeast: 2,
  regex: RegExp(r'[A-Z]'),
  errorText: 'Need at least 2 uppercase letters'
);

// New API equivalent
Validators.hasMinUppercaseChars(
  min: 2,
  customUppercaseCounter: (input) => RegExp(r'[A-Z]').allMatches(input).length,
  hasMinUppercaseCharsMsg: (_, __) => 'Need at least 2 uppercase letters'
);
```
    
For the remaining `isFalse` and `isTrue`, it is not necessary to wrap them with `Validators.string` even if the form widget does not provide `String` input.


- `FormBuilderValidators.isFalse`
```dart
// Old API
FormBuilderValidators.isFalse(
  errorText: 'Value must be false'
);

// New API equivalent
Validators.isFalse(
  isFalseMsg: (_) => 'Value must be false'
);
```

- `FormBuilderValidators.isTrue`
```dart
// Old API
FormBuilderValidators.isTrue(
  errorText: 'Value must be true'
);

// New API equivalent
Validators.isTrue(
  isTrueMsg: (_) => 'Value must be true'
);
```

#### Collection validators
- `FormBuilderValidators.containsElement`
```dart
// Old API
FormBuilderValidators.containsElement(
  [v1, v2, v3],
  errorText: 'Value must be in the list'
);

// New API equivalent
Validators.inList(
  [v1, v2, v3],
  inListMsg: (_, __) => 'Value must be in the list'
);
```
- `FormBuilderValidators.equalLength`
  - The parameter `allowEmpty` was removed and [additional logic](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/collection/equal_length_validator.dart#L40) must be provided to handle the case in which this parameter is true. 

```dart
// Old API
FormBuilderValidators.equalLength(
  8,
  allowEmpty: false,
  errorText: 'Must be exactly 8 characters'
);

// New API equivalent
Validators.equalLength(
  8,
  equalLengthMsg: (_, __) => 'Must be exactly 8 characters'
);

// Note: The parameter `allowEmpty` was removed.
// To handle 'allowEmpty: true' case, use something like:
Validators.or([
  Validators.equalLength(0),
  Validators.equalLength(8)
]);
```

- `FormBuilderValidators.maxLength`
```dart
// Old API
FormBuilderValidators.maxLength(
  50,
  errorText: 'Must be no more than 50 characters'
);

// New API equivalent
Validators.maxLength(
  50,
  maxLengthMsg: (_, __) => 'Must be no more than 50 characters'
);
```

- `FormBuilderValidators.minLength`
```dart
// Old API
FormBuilderValidators.minLength(
  8,
  errorText: 'Must be at least 8 characters'
);

// New API equivalent
Validators.minLength(
  8,
  minLengthMsg: (_, __) => 'Must be at least 8 characters'
);
```

- `FormBuilderValidators.range` (for collections)
```dart
// Old API (inclusive: true)
FormBuilderValidators.range(
  3,
  10,
  inclusive: true,
  errorText: 'Length must be between 3 and 10'
);

// New API equivalent
Validators.betweenLength(
  3,
  10,
  betweenLengthMsg: (_) => 'Length must be between 3 and 10'
);

/******************************************************************************/

// Old API (inclusive: false)
FormBuilderValidators.range(
  3,
  10,
  inclusive: false,
  errorText: 'Length must be between 4 and 9'
);

// New API equivalent
Validators.betweenLength(
  4,
  9,
  betweenLengthMsg: (_) => 'Length must be between 4 and 9'
);
```

- `FormBuilderValidators.range` (for numeric values)
```dart
// Old API
FormBuilderValidators.range(
  1,
  100,
  inclusive: true,
  errorText: 'Value must be between 1 and 100'
);

// New API equivalent
Validators.between(
  1,
  100,
  minInclusive: true,
  maxInclusive: true,
  betweenMsg: (_, __, ___, ____, _____) => 'Value must be between 1 and 100'
);
```
- `FormBuilderValidators.unique([v1, v2, v3], errorText:'some error')`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/collection/unique_validator.dart#L32), thus, a custom validator should be implemented.
  - Example: 

```dart
Validator<T> unique<T extends Object>(List<T> values, {String? errorText}){
  return (input){
    return values.where((element) => element == input).length > 1? errorText:null;
  };

}
```
        
### Core validators

- `FormBuilderValidators.aggregate`
```dart
// Old API
FormBuilderValidators.aggregate([
  validator1,
  validator2,
  validator3
]);

// New API equivalent
Validators.and(
  [validator1, validator2, validator3],
  separator: '\n',
  printErrorAsSoonAsPossible: false
);
```

- `FormBuilderValidators.compose`
```dart
// Old API
FormBuilderValidators.compose([
  validator1,
  validator2
]);

// New API equivalent
Validators.and([
  validator1,
  validator2
]);
```

- `FormBuilderValidators.conditional`
```dart
// Old API
FormBuilderValidators.conditional(
  (value) => value != null,
  validator
);

// New API equivalent
Validators.validateIf(
  (value) => value != null,
  validator
);
```

- `FormBuilderValidators.defaultValue`
```dart
// Old API
FormBuilderValidators.defaultValue(
  'Default',
  validator
);

// New API equivalent
Validators.validateWithDefault(
  'Default',
  validator
);
```

- `FormBuilderValidators.equal`
```dart
// Old API
FormBuilderValidators.equal(
  expectedValue,
  'Must match the expected value'
);

// New API equivalent
Validators.equal(
  expectedValue,
  equalMsg: (_, __) => 'Must match the expected value'
);
```

- `FormBuilderValidators.log`
```dart
// Old API
FormBuilderValidators.log(
  logFunction,
  'Error message'
);

// New API equivalent
Validators.debugPrintValidator(
  (input) => logFunction?.call(input) ?? 'Error message'
);
```

- `FormBuilderValidators.notEqual`
```dart
// Old API
FormBuilderValidators.notEqual(
  forbiddenValue,
  'Must not match the forbidden value'
);

// New API equivalent
Validators.notEqual(
  forbiddenValue,
  notEqualMsg: (_, __) => 'Must not match the forbidden value'
);
```

- `FormBuilderValidators.or`
```dart
// Old API
FormBuilderValidators.or([
  validator1,
  validator2
]);

// New API equivalent
Validators.or([
  validator1,
  validator2
]);
```

- `FormBuilderValidators.required`
```dart
// Old API
FormBuilderValidators.required(
  'This field is required'
);

// New API equivalent
Validators.required(
  null,
  'This field is required'
);
```

- `FormBuilderValidators.skipWhen`
```dart
// Old API
FormBuilderValidators.skipWhen(
  (value) => value == null,
  validator
);

// New API equivalent
Validators.skipIf(
  (value) => value == null,
  validator
);
```

- `FormBuilderValidators.transform`
```dart
// Old API
FormBuilderValidators.transform(
  (value) => value?.toString().trim(),
  validator
);

// New API equivalent
Validators.transformAndValidate(
  (value) => value?.toString().trim(),
  next: validator
);
```

### Datetime validators

- `FormBuilderValidators.dateFuture()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/datetime/date_future_validator.dart#L29), thus, a custom validator should be implemented.
  - Example: 

```dart
// Old API:
FormBuilderValidators.dateFuture(errorText: 'Date must be in the future');

// New API (closest):
Validators.dateTime(
    Validators.after(
        DateTime.now(), 
        afterMsg: (_, __)=>'Date must be in the future',
    ),
);
``` 

- `FormBuilderValidators.datePast()`:there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/datetime/date_past_validator.dart#L29), thus, a custom validator should be implemented.
  - Example: 

```dart
// Old API:
FormBuilderValidators.datePast(errorText: 'Date must be in the past');

// New API (closest):
Validators.dateTime(
    Validators.before(
        DateTime.now(), 
        beforeMsg: (_, __)=>'Date must be in the past',
    ),
);
``` 

- `FormBuilderValidators.dateRange()`

```dart
// Old API
FormBuilderValidators.dateRange(
  minDate,
  maxDate,
  errorText: 'Date must be between min and max dates'
);

// New API equivalent
Validators.dateTime(
  Validators.betweenDateTime(
    minDate,
    maxDate,
    betweenDateTimeMsg: (_, __, ___) => 'Date must be between min and max dates'
  ),
);
```

- `FormBuilderValidators.dateTime()`: this validator only checks if the input of type `DateTime?` is not null. Something close would be the following example: 

```dart
// Old API:
FormBuilderValidators.dateTime(errorText: 'Invalid date time');

// New API (close):
final errorText = 'Invalid date time';
Validators.required(Validators.dateTime(null, (_)=>errorText), errorText);
```

- `FormBuilderValidators.date()`
```dart
// Old API
FormBuilderValidators.date(errorText: 'Invalid date time');

// New API
Validators.dateTime(null, (_)=>'Invalid date time');
```
- `FormBuilderValidators.time()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/datetime/time_validator.dart#L48). But it is a combination of `Validators.dateTime` with `Validators.match` using some specific regex.

- `FormBuilderValidators.timeZone()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/datetime/timezone_validator.dart#L75). 
Something close would be:
```dart
Validators.inList(validTimezones, inListMsg: (_, __)=> 'Invalid timezone')
```

### File validators

- `FormBuilderValidators.fileExtension()`
```dart
// Old API:
FormBuilderValidators.fileExtension(
  ['pdf', 'txt', 'png'],
  errorText: 'Invalid extension',
);

// New API:
Validators.matchesAllowedExtensions(
  // Actually, the extension is '.pdf' and not 'pdf'
  ['.pdf', '.txt', '.png'],
  matchesAllowedExtensionsMsg:(_)=>'Invalid extension',
  caseSensitive: false,
);
```
- `FormBuilderValidators.fileName()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/file/file_name_validator.dart#L46). Something close would be:
```dart 
// Old API:
FormBuilderValidators.fileName(
    regex: RegExp(r'^[a-zA-Z0-9_\-\.]+$'),
    errorText: 'invalid file name'
);

// New API:
Validators.match(
    RegExp(r'^[a-zA-Z0-9_\-\.]+$'),
    matchMsg: (_)=>'invalid file name',
);
```

- `FormBuilderValidators.fileSize()`
```dart
// base1024Conversion:true
// Old API:
FormBuilderValidators.fileSize(
    12 * 1024,
    base1024Conversion:true,
    errorText:'error text',
);

// New API:
Validators.maxFileSize(
    12 * 1024,
    base: Base.b1024,
    maxFileSizeMsg: (_, __, ___)=>'error text',
);
//--------------------------------------------------------------------------
// base1024Conversion:false
// Old API:
FormBuilderValidators.fileSize(
    12 * 1000,
    base1024Conversion:false,
    errorText:'error text',
);

// New API:
Validators.maxFileSize(
    12 * 1000,
    base: Base.b1000,
    maxFileSizeMsg: (_, __, ___)=>'error text',
);
```
- `FormBuilderValidators.mimeType()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/file/mime_type_validator.dart#L47). Something close would be:
```dart
// Old API:
FormBuilderValidators.mimeType(
  // This regex is the same as the default
  regex: RegExp(r'^[a-zA-Z0-9!#$&^_-]+\/[a-zA-Z0-9!#$&^_-]+$'),
  errorText: 'error text',
);

// New API:
Validators.match(
  RegExp(r'^[a-zA-Z0-9!#$&^_-]+\/[a-zA-Z0-9!#$&^_-]+$'),
  matchMsg: (_)=>'error text'
);
```
- `FormBuilderValidators.path()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/file/path_validator.dart#L46). Something close would be:
```dart
// Old API:
FormBuilderValidators.path(
  errorText: 'error text',
);

// New API:
Validators.match(
  RegExp(r'^((\/|\\|[a-zA-Z]:\/)?([^<>:"|?*]+(\/|\\)?)+)$'),
  matchMsg: (_)=>'error text'
);
```

### Finance validators

- `FormBuilderValidators.bic()`
```dart
// Old API (no regex):
FormBuilderValidators.bic(
  errorText: 'error text',
);

// New API:
Validators.bic(
  bicMsg: (_)=>'error text'
);

//------------------------------------------------------------------------------
// Old API (with regex):
FormBuilderValidators.bic(regex: someRegex);

// New API:
Validators.bic(isBic: (input)=>someRegex.hasMatch(input));
```
TODO continue from here!!!
- `FormBuilderValidators.creditCardCVC()` - requires the field's value to be a valid credit card CVC number.
- `FormBuilderValidators.creditCardExpirationDate()` - requires the field's value to be a valid credit card expiration date and can check if not expired yet.
- `FormBuilderValidators.creditCard()` - requires the field's value to be a valid credit card number.
- `FormBuilderValidators.iban()` - requires the field's to be a valid IBAN.

### Identity validators

- `FormBuilderValidators.city()` - requires the field's value to be a valid city name.
- `FormBuilderValidators.country()` - requires the field's value to be a valid country name.
- `FormBuilderValidators.firstName()` - requires the field's value to be a valid first name.
- `FormBuilderValidators.lastName()` - requires the field's value to be a valid last name.
- `FormBuilderValidators.passportNumber()` - requires the field's value to be a valid passport number.
- `FormBuilderValidators.password()` - requires the field's to be a valid password that matched required conditions.
- `FormBuilderValidators.ssn()` - requires the field's to be a valid SSN (Social Security Number).
- `FormBuilderValidators.state()` - requires the field's value to be a valid state name.
- `FormBuilderValidators.street()` - requires the field's value to be a valid street name.
- `FormBuilderValidators.username()` - requires the field's to be a valid username that matched required conditions.
- `FormBuilderValidators.zipCode()` - requires the field's to be a valid zip code.

### Network validators

- `FormBuilderValidators.email()` - requires the field's value to be a valid email address.
- `FormBuilderValidators.ip()` - requires the field's value to be a valid IP address.
- `FormBuilderValidators.latitude()` - requires the field's to be a valid latitude.
- `FormBuilderValidators.longitude()` - requires the field's to be a valid longitude.
- `FormBuilderValidators.macAddress()` - requires the field's to be a valid MAC address.
- `FormBuilderValidators.phoneNumber()` - requires the field's value to be a valid phone number.
- `FormBuilderValidators.portNumber()` - requires the field's to be a valid port number.
- `FormBuilderValidators.url()` - requires the field's value to be a valid URL.

### Numeric validators

- `FormBuilderValidators.between()` - requires the field's to be between two numbers.
- `FormBuilderValidators.evenNumber()` - requires the field's to be an even number.
- `FormBuilderValidators.integer()` - requires the field's value to be an integer.
- `FormBuilderValidators.max()` - requires the field's value to be less than or equal to the provided number.
- `FormBuilderValidators.min()` - requires the field's value to be greater than or equal to the provided number.
- `FormBuilderValidators.negativeNumber()` - requires the field's to be a negative number.
- `FormBuilderValidators.notZeroNumber()` - requires the field's to be not a number zero.
- `FormBuilderValidators.numeric()` - requires the field's value to be a valid number.
- `FormBuilderValidators.oddNumber()` - requires the field's to be an odd number.
- `FormBuilderValidators.positiveNumber()` - requires the field's to be a positive number.
- `FormBuilderValidators.prime()` - requires the field's to be a prime number.

### String validators

- `FormBuilderValidators.alphabetical()` - requires the field's to contain only alphabetical characters.
- `FormBuilderValidators.contains()` - requires the substring to be in the field's value.
- `FormBuilderValidators.endsWith()` - requires the substring to be the end of the field's value.
- `FormBuilderValidators.lowercase()` - requires the field's value to be lowercase.
- `FormBuilderValidators.matchNot()` - requires the field's value to not match the provided regex pattern.
- `FormBuilderValidators.match()` - requires the field's value to match the provided regex pattern.
- `FormBuilderValidators.maxWordsCount()` - requires the word count of the field's value to be less than or equal to the provided maximum count.
- `FormBuilderValidators.minWordsCount()` - requires the word count of the field's value to be greater than or equal to the provided minimum count.
- `FormBuilderValidators.singleLine()` - requires the field's string to be a single line of text.
- `FormBuilderValidators.startsWith()` - requires the substring to be the start of the field's value.
- `FormBuilderValidators.uppercase()` - requires the field's value to be uppercase.

### Use-case validators

- `FormBuilderValidators.base64()` - requires the field's to be a valid base64 string.
- `FormBuilderValidators.colorCode()` - requires the field's value to be a valid color code.
- `FormBuilderValidators.duns()` - requires the field's value to be a valid DUNS.
- `FormBuilderValidators.isbn()` - requires the field's to be a valid ISBN.
- `FormBuilderValidators.json()` - requires the field's to be a valid json string.
- `FormBuilderValidators.languageCode()` - requires the field's to be a valid language code.
- `FormBuilderValidators.licensePlate()` - requires the field's to be a valid license plate.
- `FormBuilderValidators.uuid()` - requires the field's to be a valid uuid.
- `FormBuilderValidators.vin()` - requires the field's to be a valid VIN number.

### Extension method validators

Used for chaining and combining multiple validators.

- `FormBuilderValidator.and()` - Combines the current validator with another validator using logical AND.
- `FormBuilderValidator.or()` - Combines the current validator with another validator using logical OR.
- `FormBuilderValidator.when()` - Adds a condition to apply the validator only if the condition is met.
- `FormBuilderValidator.unless()` - Adds a condition to apply the validator only if the condition is not met.
- `FormBuilderValidator.transform()` - Transforms the value before applying the validator.
- `FormBuilderValidator.skipWhen()` - Skips the validator if the condition is met.
- `FormBuilderValidator.log()` - Logs the value during the validation process.
- `FormBuilderValidator.withErrorMessage()` - Overrides the error message of the current validator.
