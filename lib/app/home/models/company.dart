import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Company extends Equatable {
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
    final name = data['name'] as String;
    if (name == null) {
      return null;
    }
    // final ratePerHour = data['ratePerHour'] as int;
    return Company(id: documentId, name: name);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  @override
  String toString() => name;
}
