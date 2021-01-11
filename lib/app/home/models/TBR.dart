import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/app/home/models/technician.dart';

@immutable
class TBR extends Equatable {
  const TBR({
    @required this.id,
    @required this.name,
    @required this.start,
    @required this.end,
    @required this.technician,
    @required this.company,
    @required this.tbrType,
  });
  final String id;
  final String name;
  final DateTime start;
  final DateTime end;
  final Technician technician;
  final Company company;
  final String tbrType;

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;

  // factory TBR.fromMap(Map<String, dynamic> data, String documentId) {
  //   if (data == null) {
  //     return null;
  //   }
  //   final name = data['name'] as String;
  //   if (name == null) {
  //     return null;
  //   }
  //   return TBR(id: documentId, name: name,);
  // }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
