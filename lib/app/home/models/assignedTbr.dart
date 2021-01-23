import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase/firebase.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/app/home/models/questionnaire_type.dart';
import 'package:accountmanager/app/home/models/technician.dart';

import 'Status.dart';

// @immutable
class AssignedTBR {
  //extends Equatable {
  AssignedTBR({
    @required this.id,
    @required this.technician,
    @required this.company,
    @required this.questionnaireType,
    @required this.dueDate,
    @required this.clientMeetingDate,
    @required this.status,
  });
  final String id;
  final Technician technician;
  final Company company;
  final QuestionnaireType questionnaireType;
  final DateTime dueDate;
  final DateTime clientMeetingDate;
  final Status status;
  bool selected;

  // @override
  // List<Object> get props => [
  //       id,
  //       technician,
  //       company,
  //       questionnaireType,
  //       dueDate,
  //       clientMeetingDate,
  //       status
  //     ];

  // @override
  // bool get stringify => true;

  factory AssignedTBR.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    final String companyName = data['company_name'] as String;
    final String companyId = data['company_id'] as String;
    final String technicianId = data['technician_id'] as String;
    final String technicianName = data['technician_name'] as String;
    final String questionnaireTypeId = data['questionnaireType_id'] as String;
    final String questionnaireTypeName =
        data['questionnaireType_name'] as String;
    final Timestamp dueDate = data['dueDate'] as Timestamp;
    final Timestamp clientMeetingDate = data['clientMeetingDate'] as Timestamp;
    final int status = data['status'] as int;

    if (companyName == null ||
        companyId == null ||
        technicianId == null ||
        technicianName == null ||
        questionnaireTypeId == null ||
        questionnaireTypeName == null ||
        dueDate == null ||
        clientMeetingDate == null ||
        status == null) {
      return null;
    }
    final Technician tech = Technician(id: technicianId, name: technicianName);
    final Company comp = Company(id: companyId, name: companyName);
    final QuestionnaireType question =
        QuestionnaireType(id: questionnaireTypeId, name: questionnaireTypeName);
    final DateTime dueDateDatetime =
        DateTime.fromMicrosecondsSinceEpoch(dueDate.microsecondsSinceEpoch);
    final DateTime clientMeetingDateDatetime =
        DateTime.fromMicrosecondsSinceEpoch(
            clientMeetingDate.microsecondsSinceEpoch);
    final Status statusObj = Status(statusIndex: status);

    return AssignedTBR(
        id: documentId,
        technician: tech,
        company: comp,
        questionnaireType: question,
        dueDate: dueDateDatetime,
        clientMeetingDate: clientMeetingDateDatetime,
        status: statusObj);
  }

  Map<String, dynamic> toMap() {
    if (company == null ||
        technician == null ||
        questionnaireType == null ||
        dueDate == null ||
        clientMeetingDate == null ||
        status == null) {
      return null;
    } else {
      return {
        'company_name': company.name,
        'company_id': company.id,
        'technician_id': technician.id,
        'technician_name': technician.name,
        'questionnaireType_id': questionnaireType.id,
        'questionnaireType_name': questionnaireType.name,
        'dueDate': dueDate,
        'clientMeetingDate': clientMeetingDate,
        'status': status.statusIndex,
      };
    }
  }

  String getMeetingDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(clientMeetingDate).toString();
  }

  String getDueDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(dueDate).toString();
  }

  // @override
  // String toString() => name;
}
