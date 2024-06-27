import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Faker faker = Faker.instance;
  final String customErrorMessage = faker.lorem.sentence();
  group('Email -', () {});
}
