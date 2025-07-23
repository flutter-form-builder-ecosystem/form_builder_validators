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
Validators.num(
  Validators.between(
    1,
    100,
    minInclusive: true,
    maxInclusive: true,
    betweenMsg: (_, __, ___, ____, _____) => 'Value must be between 1 and 100',
  ),
  (_)=>'Value must be between 1 and 100',
);
```
- `FormBuilderValidators.unique([v1, v2, v3], errorText:'some error')`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/collection/unique_validator.dart#L32), thus, a custom validator should be implemented.
  - Example: 


```dart
// TODO use the `satisfy` validator.
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
Validators.string(
  Validators.match(
      RegExp(r'^[a-zA-Z0-9_\-\.]+$'),
      matchMsg: (_)=>'invalid file name',
  ),
  (_)=>'invalid file name',
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
Validators.string(
  Validators.match(
    RegExp(r'^[a-zA-Z0-9!#$&^_-]+\/[a-zA-Z0-9!#$&^_-]+$'),
    matchMsg: (_)=>'error text'
  ),
  (_)=>'error text',
);
```
- `FormBuilderValidators.path()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/file/path_validator.dart#L46). Something close would be:
```dart
// Old API:
FormBuilderValidators.path(
  errorText: 'error text',
);

// New API:
Validators.string(
  Validators.match(
    RegExp(r'^((\/|\\|[a-zA-Z]:\/)?([^<>:"|?*]+(\/|\\)?)+)$'),
    matchMsg: (_)=>'error text'
  ),
  (_)=>'error text',
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
- `FormBuilderValidators.creditCardCVC()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/finance/credit_card_cvc_validator.dart#L29). Something close would be:
```dart
// Old API:
FormBuilderValidators.creditCardCVC(
  errorText: 'invalid CVC number'
);

// New API:
Validators.and([
  Validators.int(null, (_)=>'invalid CVC number'),
  Validators.equalLength(3, equalLengthMsg: (_, __)=>'invalid CVC number'),
]);
```
- `FormBuilderValidators.creditCardExpirationDate()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/finance/credit_card_expiration_date_validator.dart#L52).
- `FormBuilderValidators.creditCard()`
```dart
// Old API:
FormBuilderValidators.creditCard(
  errorText: 'invalid credit card',
);

// New API:
Validators.creditCard(
  creditCardMsg: 'invalid credit card',
);

```

- `FormBuilderValidators.iban()`
```dart
// Old API:
// OBS.: There is a bug in the regex parameter. It is not used at all.
FormBuilderValidators.iban(errorText: 'invalid iban');

// New API:
Validators.iban(ibanMsg: (_)=>'invalid iban');
```

### Identity validators

- `FormBuilderValidators.city()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/city_validator.dart#L53). Something close would be:
```dart
// Old API:
FormBuilderValidators.city(
  regex: RegExp(r'^[A-Z][a-zA-Z\s]+$'),
  citiesWhitelist: ['CityA', 'CityB', 'CityC'],
  citiesBlacklist: ['CityD', 'CityE'],
  errorText: 'invalid city',
);

// New API (expects input as String):
Validators.string(
  Validators.and([
    Validators.match(
      RegExp(r'^[A-Z][a-zA-Z\s]+$'),
      matchMsg: (_)=>'invalid city'
    ),
    Validators.inList(
      ['CityA', 'CityB', 'CityC'],
      inListMsg: (_, __) => 'invalid city',
    ),
    Validators.notInList(
      ['CityD', 'CityE'],
      notInListMsg: (_, __) => 'invalid city',
    ),
  ]),
  (_)=>'invalid city',
);
```

- `FormBuilderValidators.country()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/country_validator.dart#L42). Something close would be:
```dart
// Old API:
FormBuilderValidators.country(
  countryWhitelist: ['CountryA', 'CountryB', 'CountryC'],
  countryBlacklist: ['CountryD', 'CountryE'],
  errorText: 'invalid country',
);

// New API (expects input as String):
Validators.string(
  Validators.and([
    Validators.inList(
      ['CountryA', 'CountryB', 'CountryC'],
      inListMsg: (_, __) => 'invalid country',
    ),
    Validators.notInList(
      ['CountryD', 'CountryE'],
      notInListMsg: (_, __) => 'invalid country',
    ),
  ]),
  (_)=>'invalid country',

);
```

- `FormBuilderValidators.firstName()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/firstname_validator.dart#L53). Something close would be:
```dart
// Old API:
FormBuilderValidators.firstName(
  regex: RegExp(r'^[A-Z][a-zA-Z]+$'),
  firstNameWhitelist: ['NameA', 'NameB', 'NameC'],
  firstNameBlacklist: ['NameD', 'NameE'],
  errorText: 'invalid name',
);

// New API (expects input as String):
Validators.string(
  Validators.and([
    Validators.match(
      RegExp(r'^[A-Z][a-zA-Z]+$'),
      matchMsg: (_)=>'invalid name'
    ),
    Validators.inList(
      ['NameA', 'NameB', 'NameC'],
      inListMsg: (_, __) => 'invalid name',
    ),
    Validators.notInList(
      ['NameD', 'NameE'],
      notInListMsg: (_, __) => 'invalid name',
    ),
  ]),
  (_)=>'invalid name',
);
```
- `FormBuilderValidators.lastName()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/lastname_validator.dart#L53). Something close would be:
```dart
// Old API:
FormBuilderValidators.lastName(
  regex: RegExp(r'^[A-Z][a-zA-Z]+$'),
  lastNameWhitelist: ['NameA', 'NameB', 'NameC'],
  lastNameBlacklist: ['NameD', 'NameE'],
  errorText: 'invalid name',
);

// New API (expects input as String):
Validators.string(
  Validators.and([
    Validators.match(
      RegExp(r'^[A-Z][a-zA-Z]+$'),
      matchMsg: (_)=>'invalid name'
    ),
    Validators.inList(
      ['NameA', 'NameB', 'NameC'],
      inListMsg: (_, __) => 'invalid name',
    ),
    Validators.notInList(
      ['NameD', 'NameE'],
      notInListMsg: (_, __) => 'invalid name',
    ),
  ]),
  (_)=>'invalid name',
);
```
- `FormBuilderValidators.passport()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/passport_number_validator.dart#L53). Something close would be:
```dart
// Old API:
FormBuilderValidators.passport(
  regex: RegExp(r'^[A-Za-z0-9]{6,9}$'),
  passportNumberNameWhitelist: ['PassA', 'PassB', 'PassC'],
  passportNumberNameBlacklist: ['PassD', 'PassE'],
  errorText: 'invalid passport',
);

// New API (expects input as String):
Validators.string(
  Validators.and([
    Validators.match(
      RegExp(r'^[A-Za-z0-9]{6,9}$'),
      matchMsg: (_)=>'invalid passport'
    ),
    Validators.inList(
      ['PassA', 'PassB', 'PassC'],
      inListMsg: (_, __) => 'invalid passport',
    ),
    Validators.notInList(
      ['PassD', 'PassE'],
      notInListMsg: (_, __) => 'invalid passport',
    ),
  ]),
  (_)=>'invalid passport',
);
```
- `FormBuilderValidators.password()`
```dart
// Old API:
FormBuilderValidators.password(
  minLength: 1,
  maxLength: 32,
  minUppercaseCount: 2,
  minLowercaseCount: 2,
  minNumberCount: 2,
  minSpecialCharCount: 2,
  errorText: 'error text',
);

// New API:
Validators.password(
  minLength: 1,
  maxLength: 32,
  minUppercaseCount: 2,
  minLowercaseCount: 2,
  minNumberCount: 2,
  minSpecialCharCount: 2,
  passwordMsg:(_) => 'error text',
);
```
- `FormBuilderValidators.ssn()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/ssn_validator.dart#L47)  
- `FormBuilderValidators.state()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/state_validator.dart#L53). Something close would be:
```dart
// Old API:
FormBuilderValidators.state(
  regex: RegExp(r'^[A-Z][a-zA-Z\s]+$'),
  stateWhitelist: ['stateA', 'stateB', 'stateC'],
  stateBlacklist: ['stateD', 'stateE'],
  errorText: 'invalid state',
);

// New API (expects input as String):
Validators.string(
  Validators.and([
    Validators.match(
      RegExp(r'^[A-Z][a-zA-Z\s]+$'),
      matchMsg: (_)=>'invalid state'
    ),
    Validators.inList(
      ['stateA', 'stateB', 'stateC'],
      inListMsg: (_, __) => 'invalid state',
    ),
    Validators.notInList(
      ['stateD', 'stateE'],
      notInListMsg: (_, __) => 'invalid state',
    ),
  ]),
  (_)=>'invalid state',
);
```
- `FormBuilderValidators.street()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/street_validator.dart#L53). Something close would be:
```dart
// Old API:
FormBuilderValidators.street(
  regex: RegExp(r'^[A-Z0-9][a-zA-Z0-9\s]*$'),
  streetWhitelist: ['streetA', 'streetB', 'streetC'],
  streetBlacklist: ['streetD', 'streetE'],
  errorText: 'invalid street',
);

// New API (expects input as String):
Validators.string(
  Validators.and([
    Validators.match(
      RegExp(r'^[A-Z0-9][a-zA-Z0-9\s]*$'),
      matchMsg: (_)=>'invalid street'
    ),
    Validators.inList(
      ['streetA', 'streetB', 'streetC'],
      inListMsg: (_, __) => 'invalid street',
    ),
    Validators.notInList(
      ['streetD', 'streetE'],
      notInListMsg: (_, __) => 'invalid street',
    ),
  ]),
  (_)=>'invalid street',
);
```
- `FormBuilderValidators.username()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/username_validator.dart#L71). Something close would be:
```dart
// Old API:
FormBuilderValidators.username(
  minLength:4,
  maxLength:10,
  allowNumbers:true,
  allowUnderscore:false,
  allowDots:false,
  allowDash:false,
  allowSpace:false,
  allowSpecialChar:false,
  errorText: 'invalid username',
);

// New API:
Validators.string(
  Validators.and([
    Validators.minLength(4, minLengthMsg: (_, __)=>'invalid username'),
    Validators.maxLength(10, minLengthMsg: (_, __)=>'invalid username'),
    Validators.hasMaxNumericChars(10, minLengthMsg: (_, __)=>'invalid username'),

  ]),
  (_)=>'invalid username',
);


```
- `FormBuilderValidators.zipCode()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/identity/zip_code_validator.dart#L43). Something close would be:
```dart
// Old API:
FormBuilderValidators.zipCode(
  errorText: 'error text',
);

// New API:
Validators.string(
  Validators.match(
    RegExp(r'^\d{5}(?:[-\s]\d{4})?$'),
    matchMsg: (_)=>'error text'
  ),
  (_)=>'error text',
);
```


### Network validators

- `FormBuilderValidators.email()`
```dart
// Old API:
FormBuilderValidators.email(
  regex: emailRegex,
  errorText: 'invalid email',
);

// New API:
Validators.email(
  regex: emailRegex,
  emailMsg: (_)=>'invalid email',
);
```

- `FormBuilderValidators.ip()`
```dart
// For IPv4
// Old API:
FormBuilderValidators.ip(
  regex: ipRegex,
  errorText: 'invalid ipV4',
);

// New API:
Validators.ip(
  regex: ipRegex,
  emailMsg: (_)=>'invalid ipV4',
);

// For IPv6
// Old API:
FormBuilderValidators.ip(
  version: 6
  regex: ipRegex,
  errorText: 'invalid ipV4',
);

// New API:
Validators.ip(
  version: IpVersion.iPv6,
  regex: ipRegex,
  emailMsg: (_)=>'invalid ipV4',
);
```

- `FormBuilderValidators.latitude()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/network/latitude_validator.dart#L40). But something close would be: 
```dart
// Old API:
FormBuilderValidators.latitude();

// New API:
Validators.transformAndValidate(
  (String input) => input.replaceAll(',', '.'),
  next: Validators.double(Validators.between(-90, 90)),
);

```

- `FormBuilderValidators.longitude()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/network/longitude_validator.dart#L40). But something close would be:
```dart
// Old API:
FormBuilderValidators.longitude();

// New API:
Validators.transformAndValidate(
  (String input) => input.replaceAll(',', '.'),
  next: Validators.double(Validators.between(-180, 180)),
);

```

- `FormBuilderValidators.macAddress()`
```dart
// Old API
FormBuilderValidators.macAddress(
  regex: regex,
  errorText: 'error text'
);

// New API equivalent
Validators.macAddress(
  isMacAddress: (input) => regex.hasMatch(input),
  macAddressMsg: (_) => 'error text'
);
```

- `FormBuilderValidators.phoneNumber()`
```dart
// Old API
FormBuilderValidators.phoneNumber();

// New API 
Validators.phoneNumber();
```

- `FormBuilderValidators.portNumber()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/network/port_number_validator.dart#L40). But, something close would be:
```dart
// Old API
FormBuilderValidators.portNumber(
  min: min,
  max: max,
  errorText: 'error text'
);


// New API:
Validators.int(
  Validators.between(min, max, betweenMsg: (_, __, ___, ____, _____)=>'error text'), 
  (_)=>'error text',
);
```

- `FormBuilderValidators.url()` 
```dart
// Old API
FormBuilderValidators.url();

// New API equivalent
Validators.url();
```


### Numeric validators

- `FormBuilderValidators.between()`
```dart
// Old API
FormBuilderValidators.between(min, max, errorText: 'error msg');

// New API equivalent
Validators.num(
  Validators.between(min, max, betweenMsg:(_, __, ___, ____, _____)=>'error msg'),
  (_)=>'error msg',
);
```

- `FormBuilderValidators.evenNumber()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/numeric/even_number_validator.dart#L29). But, something close would be:
```dart
// Old API
FormBuilderValidators.evenNumber(errorText: 'error text');


// New API:
Validators.int(
  Validators.satisfy((input)=>input % 2 == 0, satisfyMsg: (_)=>'error text'), 
  (_)=>'error text',
);
```
- `FormBuilderValidators.integer()`: the radix is not supported.
```dart
// Old API
FormBuilderValidators.integer(errorText: 'error text');

// New API (close):
Validators.int(null,(_)=> 'error text');
```

- `FormBuilderValidators.max()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/numeric/max_validator.dart#L40). But, something close would be:
```dart
// Old API (inclusive: true)
FormBuilderValidators.max(n, inclusive:true, errorText:'error msg');

// New API (close):
Validators.num(
  Validators.lessThanOrEqualTo(n, lessThanOrEqualMsg: (_, __)=>'error msg'),
  (_)=>'error msg',
);

//------------------------------------------------------------------------------

// Old API (inclusive: false)
FormBuilderValidators.max(n, inclusive:false, errorText:'error msg');

// New API (close):
Validators.num(
  Validators.lessThan(n, lessThanMsg: (_, __)=>'error msg'),
  (_)=>'error msg',
);
```

- `FormBuilderValidators.min()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/numeric/min_validator.dart#L40). But, something close would be:
```dart
// Old API (inclusive: true)
FormBuilderValidators.min(n, inclusive:true, errorText:'error msg');

// New API (close):
Validators.num(
  Validators.greaterThanOrEqualTo(n, greaterThanOrEqualMsg: (_, __)=>'error msg'),
  (_)=>'error msg',
);

//------------------------------------------------------------------------------

// Old API (inclusive: false)
FormBuilderValidators.min(n, inclusive:false, errorText:'error msg');

// New API (close):
Validators.num(
  Validators.greaterThan(n, greaterThanMsg: (_, __)=>'error msg'),
  (_)=>'error msg',
);
```

- `FormBuilderValidators.negativeNumber()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/numeric/negative_number_validator.dart#L29). But, something close would be:
```dart
// Old API:
FormBuilderValidators.negativeNumber(errorText:'error text');

// New API (close):
Validators.num(
  Validators.lessThan(0, lessThanMsg:(_, __)=>'error text'),
  (_)=>'error msg',
);
```


- `FormBuilderValidators.notZeroNumber()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/numeric/not_zero_number_validator.dart#L29). But, something close would be:
```dart
// Old API:
FormBuilderValidators.notZeroNumber(errorText:'error text');

// New API (close):
Validators.num(
  Validators.notEqual(0, notEqualMsg: (_, __)=>'error text'),
  (_)=>'error text',
);
```

- `FormBuilderValidators.numeric()`:
```dart
// Old API
FormBuilderValidators.numeric(errorText: 'error text');

// New API:
Validators.num(null, (_)=>'error text');
```

- `FormBuilderValidators.oddNumber()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/numeric/odd_number_validator.dart#L29). But, something close would be:
```dart
// Old API
FormBuilderValidators.oddNumber(errorText: 'error text');


// New API:
Validators.int(
  Validators.satisfy((input)=>input % 2 == 1, satisfyMsg: (_)=>'error text'), 
  (_)=>'error text',
);

```
- `FormBuilderValidators.positiveNumber()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/numeric/positive_number_validator.dart#L29). But, something close would be:
```dart
// Old API:
FormBuilderValidators.positiveNumber(errorText:'error text');

// New API (close):
Validators.num(
  Validators.greaterThan(0, greaterThanMsg:(_, __)=>'error text'),
  (_)=>'error msg',
);
```
- `FormBuilderValidators.primeNumber()`: there is no equivalent to [this validator](). But, something close would be:
```dart
// Old API
FormBuilderValidators.primeNumber(errorText: 'error text');


// New API:
bool isPrime(int number) {
  if (number <= 1) return false;
  for (int i = 2; i * i <= number; i++) {
    if (number % i == 0) return false;
  }
  return true;
}

Validators.int(
  Validators.satisfy((input)=>isPrime(input), satisfyMsg: (_)=>'error text'), 
  (_)=>'error text',
);
```

### String validators
For the following group of validators, it is expected to receive a `String` as user input. Thus, if your form widget does not guarantee a `String` input (e.g. it may receive an `Object`), you must wrap the equivalent validator with the type validator for strings (`Validators.string`). 

- `FormBuilderValidators.alphabetical()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/string/alphabetical_validator.dart#L45). But, something close would be:
```dart
// Old API:
FormBuilderValidators.alphabetical(errorText:'error text');

// New API (close):
Validators.match(
  RegExp(r'^[a-zA-Z]+$'),
  matchMsg: (_)=>'error text'
);
```

- `FormBuilderValidators.contains()`
```dart
// Old API:
FormBuilderValidator.contains(
  'substring', 
  caseSensitive: false,
  errorText:'error text',
);

// New API:
Validators.contains(
  'substring', 
  caseSensitive:false,
  containsMsg: (_, __)=>'error text',
);
```
- `FormBuilderValidators.endsWith()`
```dart
// Old API:
FormBuilderValidator.endsWith(
  'suffix', 
  errorText:'error text',
);

// New API:
Validators.endsWith(
  'suffix', 
  endsWithMsg: (_, __)=>'error text',
);
```

- `FormBuilderValidators.lowercase()`
```dart
// Old API:
FormBuilderValidator.lowercase(
  errorText:'error text',
);

// New API:
Validators.lowercase(
  lowercaseMsg: (_)=>'error text',
);
```

- `FormBuilderValidators.matchNot()`
```dart
// Old API:
FormBuilderValidator.matchNot(
  regex,
  errorText:'error text',
);

// New API:
Validators.notMatch(
  regex,
  notMatchMsg: (_)=>'error text',
);
```


- `FormBuilderValidators.match()`
```dart
// Old API:
FormBuilderValidator.match(
  regex,
  errorText:'error text',
);

// New API:
Validators.match(
  regex,
  matchMsg: (_)=>'error text',
);
```

- `FormBuilderValidators.maxWordsCount()`
```dart
// Old API:
FormBuilderValidator.maxWordsCount(
  10,
  errorText:'error text',
);

// New API:
Validators.maxWordCount(
  10,
  maxWordCountMsg: (_, __)=>'error text',
);
```

- `FormBuilderValidators.minWordsCount()`
```dart
// Old API:
FormBuilderValidator.minWordsCount(
  10,
  errorText:'error text',
);

// New API:
Validators.minWordCount(
  10,
  minWordCountMsg: (_, __)=>'error text',
);
```

- `FormBuilderValidators.singleLine()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/string/single_line_validator.dart#L29). But, something close would be:
```dart
// Old API:
FormBuilderValidators.singleLine(errorText:'error text');

// New API:
Validators.satisfy(
  (input)=> !input.contains('\n') && !input.contains('\r'),
  satisfyMsg: (_)=> 'error text',
);
```


- `FormBuilderValidators.startsWith()`
```dart
// Old API:
FormBuilderValidator.startsWith(
  'suffix', 
  errorText:'error text',
);

// New API:
Validators.startsWith(
  'suffix', 
  startsWithMsg: (_, __)=>'error text',
);
```

- `FormBuilderValidators.uppercase()`
```dart
// Old API:
FormBuilderValidator.uppercase(
  errorText:'error text',
);

// New API:
Validators.uppercase(
  uppercaseMsg: (_)=>'error text',
);
```


### Use-case validators

- `FormBuilderValidators.base64()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/usecase/base64_validator.dart#L31). Something close would be:
```dart
// Old API:
FormBuilderValidator.base64(
  errorText: 'error text',
);

// New API (equivalent):
bool isBase64(String value) {
    try {
      base64Decode(value);
      return true;
    } catch (e) {
      return false;
    }
}

Validators.satisfy(
  (input)=>isBase64(input), satisfyMsg: (_)=>'error text',
); 
```
- `FormBuilderValidators.colorCode()`
```dart
// Old API:
FormBuilderValidator.colorCode();

// New API:
Validators.colorCode();
```

- `FormBuilderValidators.duns()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/usecase/duns_validator.dart#L41). The equivalent would be:
```dart
// Old API:
FormBuilderValidator.duns(
  errorText: 'error text',
);

// New API:
Validators.match(
  RegExp(r'^\d{9}$'),
  matchMsg: (_)=>'error text',
);
```

- `FormBuilderValidators.isbn()`
```dart
// Old API:
FormBuilderValidator.isbn(
  errorText: 'error text',
);

// New API:
Validators.isbn(
  isbnMsg: (_)=> 'error text',
);
```
- `FormBuilderValidators.json()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/usecase/json_validator.dart#L31) 
```dart
// Old API:
FormBuilderValidator.json(
  errorText: 'error text',
);

// New API (equivalent):
bool isJson(String value) {
    try {
      jsonDecode(value);
      return true;
    } catch (e) {
      return false;
    }
}

Validators.satisfy(
  (input)=>isJson(input), satisfyMsg: (_)=>'error text',
); 
```
- `FormBuilderValidators.languageCode()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/usecase/language_code_validator.dart#L51).
```dart
// Old API:
FormBuilderValidators.languageCode(
  regex: regex,
  languageCodeWhitelist: ['val1', 'val2', 'val3'],
  languageCodeBlacklist: ['val4', 'val5'],
  errorText: 'invalid language code',
);

// New API (expects input as String):
Validators.and([
  Validators.match(
    regex,
    matchMsg: (_)=>'invalid language code'
  ),
  Validators.inList(
    ['val1', 'val2', 'val3'],
    inListMsg: (_, __) => 'invalid language code',
  ),
  Validators.notInList(
    ['val1', 'val2', 'val3'],
    notInListMsg: (_, __) => 'invalid language code',
  ),
]);
```

- `FormBuilderValidators.licensePlate()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/usecase/licenseplate_validator.dart#L52).
```dart
// Old API:
FormBuilderValidators.licensePlate(
  regex: regex,
  licensePlateWhitelist: ['val1', 'val2', 'val3'],
  licensePlateBlacklist: ['val4', 'val5'],
  errorText: 'invalid license plate',
);

// New API (expects input as String):
Validators.and([
  Validators.match(
    regex,
    matchMsg: (_)=>'invalid license plate'
  ),
  Validators.inList(
    ['val1', 'val2', 'val3'],
    inListMsg: (_, __) => 'invalid license plate',
  ),
  Validators.notInList(
    ['val1', 'val2', 'val3'],
    notInListMsg: (_, __) => 'invalid license plate',
  ),
]);
```
- `FormBuilderValidators.uuid()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/usecase/uuid_validator.dart#L47).
```dart
// Old API:
FormBuilderValidator.uuid(
  errorText: 'error text',
);

// New API:
Validators.match(
  RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  ),
  matchMsg: (_)=>'error text',
);
```

- `FormBuilderValidators.vin()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/eafb7662827fe938034be6d2081c9d2844a46c10/lib/src/usecase/vin_validator.dart#L52).
```dart
// Old API:
FormBuilderValidators.vin(
  regex: regex,
  licensePlateWhitelist: ['val1', 'val2', 'val3'],
  licensePlateBlacklist: ['val4', 'val5'],
  errorText: 'invalid vin',
);

// New API (expects input as String):
Validators.and([
  Validators.match(
    regex,
    matchMsg: (_)=>'invalid vin'
  ),
  Validators.inList(
    ['val1', 'val2', 'val3'],
    inListMsg: (_, __) => 'invalid vin',
  ),
  Validators.notInList(
    ['val1', 'val2', 'val3'],
    notInListMsg: (_, __) => 'invalid vin',
  ),
]);
```



### Extension method validators

Used for chaining and combining multiple validators.

- `FormBuilderValidator.and()`: use `Validators.and` instead.
- `FormBuilderValidator.or()`: use `Validators.or` instead.
- `FormBuilderValidator.when()`: use `Validators.validateIf` instead.
- `FormBuilderValidator.unless()`: use `Validators.skipIf`
- `FormBuilderValidator.transform()`: use `Validators.transformAndValidate` instead.
- `FormBuilderValidator.skipWhen()`: use `Validators.skipIf` instead.
- `FormBuilderValidator.log()`: use `Validators.debugPrintValidator` instead
- `FormBuilderValidator.withErrorMessage()`: there is no equivalent in the new api. 
