import 'package:flutter/material.dart';

import 'package:form_builder_validators/form_builder_validators.dart'
    show Validators;

/// Alias for [Validators].
typedef V = Validators;

/// Forms which you can use validate granularly to redirect the
/// focus to the first invalid field after submitting.
class FormsWithValidateGranularly extends StatelessWidget {
  const FormsWithValidateGranularly({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validate Granularly')),
      body: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedBloodType;
  late TextEditingController dateOfBirthController;

  static const List<String> validBloodTypeOptions = <String>[
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  @override
  void initState() {
    super.initState();
    dateOfBirthController = TextEditingController();
  }

  @override
  void dispose() {
    dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 512),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  key: Key('full name'),
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: V.isRequired(V.match(RegExp('[A-Z].*'),
                      matchMsg: (_) => 'The name must start with uppercase')),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: Key('email'),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: V.isRequired(V.email()),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: Key('date of birth'),
                  controller: dateOfBirthController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    hintText: 'YYYY-MM-DD',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: V.isRequired(V.isDateTime(V.isInThePast())),
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  onTap: () async {
                    // Add date picker functionality
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    );
                    if (picked != null) {
                      dateOfBirthController.text = picked.toString();
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: Key('height'),
                  decoration: const InputDecoration(
                    labelText: 'Height (m)',
                    hintText: 'Enter your height in meters',
                    prefixIcon: Icon(Icons.height),
                    suffixText: 'm',
                  ),
                  validator: V.isRequired(V.isNum(V.between(0.5, 2.5,
                      betweenMsg: (_, num min, num max, __, ___) =>
                          'Please enter a realistic height [$min-${max}m]'))),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: Key('weight'),
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    hintText: 'Enter your weight in kilograms',
                    prefixIcon: Icon(Icons.monitor_weight),
                    suffixText: 'kg',
                  ),
                  validator: V.isOptional(V.isNum(V.between(20, 300,
                      betweenMsg: (_, num min, num max, ____, _____) =>
                          'weight must be in [$min, ${max}kg]'))),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: Key('phone number'),
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: V.isRequired(),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  key: Key('blood type'),
                  value: selectedBloodType,
                  decoration: const InputDecoration(
                    labelText: 'Blood Type',
                    prefixIcon: Icon(Icons.bloodtype),
                  ),
                  items: validBloodTypeOptions
                      .map((String e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .followedBy(<DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'invalid option 1',
                      child: Text('Invalid option 1'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'invalid option 2',
                      child: Text('Invalid option 2'),
                    ),
                  ]).toList(),
                  validator: V.isRequired(V.containsElement(
                      validBloodTypeOptions,
                      containsElementMsg: (_, List<String> v) =>
                          'The option must be one of: ${v.join(', ')}.')),
                  onChanged: (String? value) {
                    setState(() {
                      selectedBloodType = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    final Iterable<String> invalidFields = _formKey
                        .currentState!
                        .validateGranularly()
                        .map((FormFieldState<Object?> e) => e.widget.key
                            .toString()
                            .replaceAll('[<\'', '')
                            .replaceAll('\'>]', ''));
                    if (invalidFields.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Form submitted successfully!'),
                        duration: Duration(seconds: 2),
                        elevation: 5,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                        backgroundColor: Colors.green,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Invalid fields: ${invalidFields.join(', ')}'),
                        duration: Duration(seconds: 2),
                        elevation: 5,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                        backgroundColor: Colors.green,
                      ));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
