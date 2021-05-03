import 'package:accountmanager/models/model_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Company extends Equatable implements DropdownModel {
  const Company({@required this.id, @required this.name});
  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;

  factory Company.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final name = data['company_name'] as String;
    if (name == null) {
      return null;
    }
    return Company(id: documentId, name: name);
  }

  Map<String, dynamic> toMap() {
    return <String, String>{'company_name': name, 'company_id': id};
  }

  @override
  String toString() => name;

  String toDeluxeString() => toMap().toString();

  @override
  String toDropDownString() => name;
}
