class FirestorePath {
  // static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  // static String jobs(String uid) => 'users/$uid/jobs';
  // static String entry(String uid, String entryId) =>
  //     'users/$uid/entries/$entryId';
  // static String entries(String uid) => 'users/$uid/entries';

  //__________________________
  static String technicians() => 'userInfo';
  static String technician(String uid) => 'userInfo/$uid';

  //__________________________
  static String companies() => 'companies';
  static String company(String companyId) => 'companies/$companyId';
  //__________________________
  static String questionnaireType() => 'questionnaireTypes';

  //__________________________
  static String assignedtbrs() => 'assignedTbr';
  static String assignedtbr(String assignedTbrId) =>
      'assignedTbr/$assignedTbrId';

  // _________________________
  static String questions() => 'questionnaire';
  static String question(String questionId) => 'questionnaire/$questionId';
  // _________________________
  // tbrInProgress
  static String completedTBRs() => 'completedTBRs';
  static String completedTBR(String id) => 'completedTBRs/$id';
  // _________________
  static String user(String uid) => 'userInfo/$uid';
  // _________________________
  static String mail() => 'mail/${DateTime.now()}';
}
