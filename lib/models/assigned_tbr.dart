// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';

import 'Status.dart';

// @immutable
class AssignedTBR extends Equatable {
  const AssignedTBR(
      {required this.id,
      required this.technician,
      required this.company,
      required this.questionnaireType,
      required this.dueDate,
      required this.clientMeetingDate,
      required this.status,
      required this.assignedBy});
  final String id;
  final Technician? technician;
  final Company? company;
  final QuestionnaireType? questionnaireType;
  final DateTime? dueDate;
  final DateTime? clientMeetingDate;
  final Status status;
  final String? assignedBy;

  @override
  List<Object?> get props => [
        id,
        technician,
        company,
        questionnaireType,
        dueDate,
        clientMeetingDate,
        status,
        assignedBy
      ];

  @override
  bool get stringify => true;

  factory AssignedTBR.fromMap(Map<String, dynamic>? data, String documentId) {
    AssignedTBR errorAssignedTBR = AssignedTBR(
        id: DateTime.now(),
        technician: Technician(
            id: DateTime.now(),
            firstName: 'Error',
            lastName: 'Error',
            email: 'Error'),
        company: Company(id: DateTime.now(), name: 'Error'),
        questionnaireType: QuestionnaireType(id: 'Error', name: 'Error'),
        dueDate: DateTime.now(),
        clientMeetingDate: DateTime.now(),
        status: Status(statusIndex: 1),
        assignedBy: 'Error');
    if (data == null) {
      return errorAssignedTBR;
    }

    final String? companyName = data['company_name'] as String?;
    final String? companyId = data['company_id'] as String?;
    final String? technicianId = data['technician_id'] as String?;
    final String? technicianFirstName = data['technician_firstName'] as String?;
    final String? technicianLastName = data['technician_lastName'] as String?;
    final String? technicianEmail = data['technician_email'] as String?;
    final String? questionnaireTypeId = data['questionnaireType_id'] as String?;
    final String? questionnaireTypeName =
        data['questionnaireType_name'] as String?;
    final Timestamp? dueDate = data['dueDate'] as Timestamp?;
    final Timestamp? clientMeetingDate =
        data['clientMeetingDate'] as Timestamp?;
    final int? status = data['status'] as int?;
    final String? assignedBy = data['assignedBy'] as String?;

    if (companyName == null ||
        companyId == null ||
        technicianId == null ||
        technicianFirstName == null ||
        technicianLastName == null ||
        technicianEmail == null ||
        questionnaireTypeId == null ||
        questionnaireTypeName == null ||
        dueDate == null ||
        clientMeetingDate == null ||
        status == null ||
        assignedBy == null) {
      return errorAssignedTBR;
    }
    final Technician tech = Technician(
      id: technicianId,
      firstName: technicianFirstName,
      lastName: technicianLastName,
      email: technicianEmail,
    );
    final Company comp = Company(id: companyId, name: companyName);
    final QuestionnaireType question =
        QuestionnaireType(id: questionnaireTypeId, name: questionnaireTypeName);
    final DateTime dueDateDatetime =
        DateTime.fromMicrosecondsSinceEpoch(dueDate.microsecondsSinceEpoch);
    final DateTime clientMeetingDateDatetime =
        DateTime.fromMicrosecondsSinceEpoch(
            clientMeetingDate.microsecondsSinceEpoch);
    final Status statusObj = Status(statusIndex: status);
    final String assignedByObj = assignedBy;

    return AssignedTBR(
        id: documentId,
        technician: tech,
        company: comp,
        questionnaireType: question,
        dueDate: dueDateDatetime,
        clientMeetingDate: clientMeetingDateDatetime,
        status: statusObj,
        assignedBy: assignedByObj);
  }

  Map<String, dynamic>? toMap() {
    if (company == null ||
        technician == null ||
        questionnaireType == null ||
        dueDate == null ||
        clientMeetingDate == null ||
        status == null ||
        assignedBy == null) {
      return null;
    } else {
      return <String, dynamic>{
        'company_name': company!.name,
        'company_id': company!.id,
        'technician_id': technician!.id,
        'technician_firstName': technician!.firstName,
        'technician_lastName': technician!.lastName,
        'technician_email': technician!.email,
        'questionnaireType_id': questionnaireType!.id,
        'questionnaireType_name': questionnaireType!.name,
        'dueDate': dueDate,
        'clientMeetingDate': clientMeetingDate,
        'status': status.statusIndex,
        'assignedBy': assignedBy
      };
    }
  }

  String getMeetingDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(clientMeetingDate!).toString();
  }

  String getDueDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(dueDate!).toString();
  }
}
