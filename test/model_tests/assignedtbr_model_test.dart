import 'package:accountmanager/models/Status.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

void main() {
  print('STARTED create_assignedtbr_test.dart');
  group('fromMap tests', () {
    test('null data', () {
      final assignedtbr = AssignedTBR.fromMap(null, 'id');
      expect(assignedtbr, null);
    });
    test('AssignedTBR with all properties from Map and direct', () {
      final Map<String, dynamic> fromFirebase = {
        'company_name': 'a company',
        'company_id': 'an id',
        'technician_id': 'a techs id',
        'technician_name': 'a techs name',
        'questionnaireType_id': 'TBR id',
        'questionnaireType_name': 'TBR',
        'dueDate':
            Timestamp.fromDate(DateTime.parse('2021-01-30T00:00:00.000')),
        'clientMeetingDate': Timestamp.fromDate(DateTime.parse(
            '2021-01-30T00:00:00.000')), // 'January 30, 2021 at 12:00:00 AM UTC-3',
        'status': 0,
        'assignedBy': 'a@b.com'
      };
      final assignedtbr = AssignedTBR.fromMap(fromFirebase, 'abc');

      final assignedtbr2 = AssignedTBR(
          id: 'abc',
          technician: const Technician(name: 'a techs name', id: 'a techs id'),
          company: const Company(id: 'an id', name: 'a company'), //'a company',
          questionnaireType: const QuestionnaireType(name: 'TBR', id: 'TBR id'),
          dueDate: DateTime.parse('2021-01-30T00:00:00.000'),
          clientMeetingDate: DateTime.parse('2021-01-30T00:00:00.000'),
          status: Status(statusIndex: 0),
          assignedBy: 'a@b.com');
      expect(assignedtbr == assignedtbr2, true);
    });

    test('missing technician should be null', () {
      final Map<String, dynamic> fromFirebase = {
        'company_name': 'a company',
        'company_id': 'an id',
        // 'technician_id': 'a techs id',
        // 'technician_name': 'a techs name',
        'questionnaireType_id': 'TBR id',
        'questionnaireType_name': 'TBR',
        'dueDate':
            Timestamp.fromDate(DateTime.parse('2021-01-30T00:00:00.000')),
        'clientMeetingDate': Timestamp.fromDate(DateTime.parse(
            '2021-01-30T00:00:00.000')), // 'January 30, 2021 at 12:00:00 AM UTC-3',
        'status': 0,
        'assignedBy': 'a@b.com'
      };

      final badAssignedTBR = AssignedTBR.fromMap(fromFirebase, 'abc');
      expect(badAssignedTBR, null);
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      final assignedtbr1 = AssignedTBR(
          id: 'abc',
          technician: const Technician(name: 'a techs name', id: 'a techs id'),
          company: const Company(id: 'an id', name: 'a company'), //'a company',
          questionnaireType: const QuestionnaireType(name: 'TBR', id: 'TBR id'),
          dueDate: DateTime.parse('2021-01-30T00:00:00.000'),
          clientMeetingDate: DateTime.parse('2021-01-30T00:00:00.000'),
          status: Status(statusIndex: 0),
          assignedBy: 'a@b.com');
      final assignedtbr2 = AssignedTBR(
          id: 'abc',
          technician: const Technician(name: 'a techs name', id: 'a techs id'),
          company: const Company(id: 'an id', name: 'a company'), //'a company',
          questionnaireType: const QuestionnaireType(name: 'TBR', id: 'TBR id'),
          dueDate: DateTime.parse('2021-01-30T00:00:00.000'),
          clientMeetingDate: DateTime.parse('2021-01-30T00:00:00.000'),
          status: Status(statusIndex: 1), // <--  Different
          assignedBy: 'a@b.com');

      expect(assignedtbr1 == assignedtbr2, false);
    });
    test('same properties, equality returns true', () {
      final assignedtbr1 = AssignedTBR(
          id: 'abc',
          technician: const Technician(name: 'a techs name', id: 'a techs id'),
          company: const Company(id: 'an id', name: 'a company'), //'a company',
          questionnaireType: const QuestionnaireType(name: 'TBR', id: 'TBR id'),
          dueDate: DateTime.parse('2021-01-30T00:00:00.000'),
          clientMeetingDate: DateTime.parse('2021-01-30T00:00:00.000'),
          status: Status(statusIndex: 0),
          assignedBy: 'a@b.com');
      final assignedtbr2 = AssignedTBR(
          id: 'abc',
          technician: const Technician(name: 'a techs name', id: 'a techs id'),
          company: const Company(id: 'an id', name: 'a company'), //'a company',
          questionnaireType: const QuestionnaireType(name: 'TBR', id: 'TBR id'),
          dueDate: DateTime.parse('2021-01-30T00:00:00.000'),
          clientMeetingDate: DateTime.parse('2021-01-30T00:00:00.000'),
          status: Status(statusIndex: 0),
          assignedBy: 'a@b.com');
      expect(assignedtbr1 == assignedtbr2, true);
    });
  });

  group('props test', () {
    test('different properties, props equality returns false', () {
      final assignedtbr1 = AssignedTBR(
          id: '123',
          technician: const Technician(name: 'a techs name', id: 'a techs id'),
          company: const Company(id: 'an id', name: 'a company'), //'a company',
          questionnaireType: const QuestionnaireType(name: 'TBR', id: 'TBR id'),
          dueDate: DateTime.parse('2021-01-30T00:00:00.000'),
          clientMeetingDate: DateTime.parse('2021-01-30T00:00:00.000'),
          status: Status(statusIndex: 0),
          assignedBy: 'a@b.com');

      final List<dynamic> constantProps = <dynamic>[
        'abc',
        const Technician(name: 'a techs name', id: 'a techs id'),
        const Company(id: 'an id', name: 'a company'), //'a company',
        const QuestionnaireType(name: 'TBR', id: 'TBR id'),
        DateTime.parse('2021-01-30T00:00:00.000'),
        DateTime.parse('2021-01-30T00:00:00.000'),
        Status(statusIndex: 0),
        'a@b.com'
      ];
      expect(listEquals<dynamic>(assignedtbr1.props, constantProps), false);
    });
    test('same properties, props equality returns true', () {
      final assignedtbr1 = AssignedTBR(
          id: 'abc',
          technician: const Technician(name: 'a techs name', id: 'a techs id'),
          company: const Company(id: 'an id', name: 'a company'), //'a company',
          questionnaireType: const QuestionnaireType(name: 'TBR', id: 'TBR id'),
          dueDate: DateTime.parse('2021-01-30T00:00:00.000'),
          clientMeetingDate: DateTime.parse('2021-01-30T00:00:00.000'),
          status: Status(statusIndex: 0),
          assignedBy: 'a@b.com');

      final List<dynamic> constantProps = <dynamic>[
        'abc',
        const Technician(name: 'a techs name', id: 'a techs id'),
        const Company(id: 'an id', name: 'a company'), //'a company',
        const QuestionnaireType(name: 'TBR', id: 'TBR id'),
        DateTime.parse('2021-01-30T00:00:00.000'),
        DateTime.parse('2021-01-30T00:00:00.000'),
        Status(statusIndex: 0),
        'a@b.com'
      ];
      expect(listEquals<dynamic>(assignedtbr1.props, constantProps), true);
    });
  });
}
