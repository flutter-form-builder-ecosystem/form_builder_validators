import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart'
    show Validators, Validator;

/// alias for Validators class.
typedef V = Validators;

/// Represents the home page of the application.
class GenericExamplesPage extends StatelessWidget {
  /// Constructs a new instance of the [GenericExamplesPage] class.
  const GenericExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generic Examples')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Composing multiple validators
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.always,
                validator: V.isRequired(
                  V.and(<Validator<String>>[
                    V.isNum(
                      V.lessThan(70),
                      (_) => 'La edad debe ser numérica.',
                    ),

                    /// Include your own custom `FormFieldValidator` function, if you want
                    /// Ensures positive values only. We could also have used `FormBuilderValidators.min( 0)` instead
                    (String? val) {
                      if (val != null) {
                        final int? number = int.tryParse(val);
                        // todo bug here: if it is not int, it accepts negative
                        // numbers
                        if (number == null) return null;
                        if (number < 0) return 'We cannot have a negative age';
                      }
                      return null;
                    },
                  ]),
                ),
              ),
              // Required Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Required Field',
                  prefixIcon: Icon(Icons.star),
                ),
                validator: V.isRequired(),
                autofillHints: const <String>[AutofillHints.name],
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Numeric Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Numeric Field',
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: V.isRequired(V.isNum()),
                autofillHints: const <String>[AutofillHints.oneTimeCode],
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              /* TODO implement the email and url validator
              // Email Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email Field',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: v.email(),
                autofillHints: const <String>[AutofillHints.email],
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              // URL Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'URL Field',
                  prefixIcon: Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
                validator: v.url(),
                autofillHints: const <String>[AutofillHints.url],
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
               */
              // Min Length Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Min Length Field',
                  prefixIcon: Icon(Icons.text_fields),
                ),
                validator: V.isRequired(V.minLength(5)),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Max Length Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Max Length Field',
                  prefixIcon: Icon(Icons.text_fields),
                ),
                validator: V.isRequired(V.maxLength(10)),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Min Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Min Value Field',
                  prefixIcon: Icon(Icons.exposure_neg_1),
                ),
                keyboardType: TextInputType.number,
                validator: V.isRequired(V.isNum(V.greaterThan(10))),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Max Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Max Value Field',
                  prefixIcon: Icon(Icons.exposure_plus_1),
                ),
                keyboardType: TextInputType.number,
                validator: V.isRequired(V.isNum(V.lessThan(100))),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Equal Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Equal Field',
                  prefixIcon: Icon(Icons.check),
                ),
                validator: V.isEqual('test'),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              /* TODO implement contains substring
              // Contains Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contains "test"',
                  prefixIcon: Icon(Icons.search),
                ),
                validator: FormBuilderValidators.contains('test'),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),

               */
              // Match Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Match Pattern',
                  prefixIcon: Icon(Icons.pattern),
                ),
                validator: V.isRequired(V.match(RegExp(r'^[a-zA-Z0-9]+$'))),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              /* TODO implement id, uuid, credit cart, and phone number validators
              // IP Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'IP Field',
                  prefixIcon: Icon(Icons.computer),
                ),
                keyboardType: TextInputType.number,
                validator: v.ip(),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),

              // UUID Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'UUID Field',
                  prefixIcon: Icon(Icons.code),
                ),
                validator: v.uuid(),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Credit Card Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Credit Card Field',
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.creditCard(),
                autofillHints: const <String>[AutofillHints.creditCardNumber],
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Phone Number Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number Field',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: FormBuilderValidators.phoneNumber(),
                autofillHints: const <String>[AutofillHints.telephoneNumber],
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
              ),
               */
              // Password Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password Field',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: V.isRequired(V.password()),
                autofillHints: const <String>[AutofillHints.password],
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Custom Validators Example
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Custom Age Validator',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                validator: V.isRequired(
                  V.isNum(V.and(<Validator<num>>[V.between(0, 120)])),
                ),
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.always,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
