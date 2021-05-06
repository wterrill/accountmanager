import 'package:accountmanager/models/model_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Technician extends Equatable implements DropdownModel {
  const Technician(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email});
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  @override
  List<Object> get props => [id, firstName, lastName, email];

  @override
  bool get stringify => true;

  factory Technician.fromMap(Map<String, dynamic>? data, String documentId) {
    final Technician errorTechnician = Technician(
        id: DateTime.now().toString(),
        firstName: 'Error',
        lastName: 'Error',
        email: 'Error');
    if (data == null) {
      return errorTechnician;
    }
    final firstName = data['firstName'] as String?;
    if (firstName == null) {
      return errorTechnician;
    }
    final lastName = data['lastName'] as String?;
    if (lastName == null) {
      return errorTechnician;
    }

    final email = data['email'] as String?;
    if (email == null) {
      return errorTechnician;
    }
    // final ratePerHour = data['ratePerHour'] as int;
    return Technician(
        id: documentId, firstName: firstName, lastName: lastName, email: email);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'technician_name': firstName, 'technician_id': id};
  }

  @override
  String toString() => '$firstName $lastName';

  String toDeluxeString() => toMap().toString();

  @override
  String toDropDownString() => '$firstName $lastName';
}
