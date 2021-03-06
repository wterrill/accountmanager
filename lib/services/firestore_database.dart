import 'dart:async';

import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/models/business_reasons.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/tbr.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/packages/firestore_service/firestore_service.dart';
import 'package:accountmanager/services/firestore_path.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({this.uid, this.id});
  // : assert(uid != null, 'Cannot create FirestoreDatabase with null uid');
  final String? uid;
  final String? id;

  final _service = FirestoreService.instance;

  // Future<void> setEntry(Entry entry) => _service.setData(
  //       path: FirestorePath.entry(uid, entry.id),
  //       data: entry.toMap(),
  //     );

  Future<void> saveUserInfo(String? uid, Map<String, String> data) {
    print('inside saveUserInfo');
    return _service.setData(
      path: FirestorePath.user(uid),
      data: data,
    );
  }

  // Future<void> deleteEntry(Entry entry) =>
  //     _service.deleteData(path: FirestorePath.entry(uid, entry.id));

  // Future<void> setJob(Job job) => _service.setData(
  //       path: FirestorePath.job(uid, job.id),
  //       data: job.toMap(),
  //     );

  Future<void> sendEmail(
      // this method uses the email extension in firestore.  Therefore, the email
      // just needs to be posted in the 'mail' collection in the database.
      {required List<String> toList,
      required String from,
      required String body,
      required String subject}) {
    final Map<String, dynamic> data = <String, dynamic>{
      'message': <String, dynamic>{'html': body, 'subject': subject},
      'to': toList
    };
    return _service.setData(
      path: FirestorePath.mail(),
      data: data,
    );
  }

  // Future<void> deleteJob(Job job) async {
  //   // delete where entry.jobId == job.jobId
  //   final allEntries = await entriesStream(job: job).first;
  //   for (final entry in allEntries) {
  //     if (entry.jobId == job.id) {
  //       await deleteEntry(entry);
  //     }
  //   }
  //   // delete job
  //   await _service.deleteData(path: FirestorePath.job(uid, job.id));
  // }

  // Stream<Job> jobStream({@required String jobId}) => _service.documentStream(
  //       path: FirestorePath.job(uid, jobId),
  //       builder: (data, documentId) => Job.fromMap(data, documentId),
  //     );

  // Stream<List<Job>> jobsStream() => _service.collectionStream(
  //       path: FirestorePath.jobs(uid),
  //       builder: (data, documentId) => Job.fromMap(data, documentId),
  //     );

  // Stream<List<Entry>> entriesStream({Job job}) =>
  //     _service.collectionStream<Entry>(
  //       path: FirestorePath.entries(uid),
  //       queryBuilder: job != null
  //           ? (query) => query.where('CompanyId', isEqualTo: job.id)
  //           : null,
  //       builder: (data, documentID) => Entry.fromMap(data, documentID),
  //       sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
  //     );

  // Future<void> setTechnician(Technician technician) => _service.setData(
  //       path: FirestorePath.technician(technician.id),
  //       data: technician.toMap(),
  //     );

  Future<void> deleteTechnician(Technician technician) async {
    await _service.deleteData(path: FirestorePath.user(technician.id));
  }

  Stream<List<Technician>> technicianStream() => _service.collectionStream(
        path: FirestorePath.users(),
        builder: (data, id) => Technician.fromMap(data, id),
      );

  Future<void> setCompany(Company company) => _service.setData(
        path: FirestorePath.company(company.id),
        data: company.toMap(),
      );

  Future<void> deleteCompany(Company company) async {
    await _service.deleteData(path: FirestorePath.company(company.id));
  }

  Future<void> setTBR(AssignedTBR assignedTbr) {
    print('inside setTBR');
    return _service.setData(
      path: FirestorePath.assignedtbr(assignedTbr.id),
      data: assignedTbr.toMap()!,
    );
  }

  Future<void> setEvaluation(TBRinProgress tbrInProgress, String id) =>
      _service.setData(
        path: FirestorePath.completedTBR(id),
        data: tbrInProgress.toMap(),
      );

  Future<void> deleteTBR(AssignedTBR assignedTbr) async {
    await _service.deleteData(path: FirestorePath.assignedtbr(assignedTbr.id));
  }

  Stream<List<Company>> companyStream() => _service.collectionStream(
        path: FirestorePath.companies(),
        builder: (data, id) => Company.fromMap(data, id),
      );

  Stream<List<QuestionnaireType>> questionnaireTypeStream() =>
      _service.collectionStream(
        path: FirestorePath.questionnaireType(),
        builder: (data, id) => QuestionnaireType.fromMap(data),
      );
  Stream<List<AssignedTBR>> assignedTbrStream() => _service.collectionStream(
        path: FirestorePath.assignedtbrs(),
        builder: (data, id) => AssignedTBR.fromMap(data, id),
      );

  Stream<TBRinProgress> completedTbrStream(
      {String? completedTbrId, List<Question>? questions}) {
    print('inside completedTbrStream');
    return _service.documentStream(
      path: FirestorePath.completedTBR(completedTbrId),
      builder: (data, documentId) {
        print(data);
        return TBRinProgress.fromMap(data, documentId, questions);
      },
    );
  }

  Stream<List<Question>> questionStream() => _service.collectionStream(
        path: FirestorePath.questions(),
        builder: (data, id) => Question.fromMap(data, id),
      );

  Stream<List<Reason>> businessReasonsStream() => _service.collectionStream(
        path: FirestorePath.businessReasons(),
        builder: (data, id) {
          print(data);
          return Reason.fromMap(data);
        },
      );
}
