class FirestorePath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  static String jobs(String uid) => 'users/$uid/jobs';
  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';

  //__________________________
  static String technicians() => 'technicians';
  static String technician(String technicianId) => 'technicians/$technicianId';

  //__________________________
  static String companies() => 'companies';
  static String company(String companyId) => 'companies/$companyId';
  //__________________________
  static String questionnaireType() => 'questionnaireTypes';

  //__________________________
  static String assignedtbrs() => 'assignedTbr';
  static String assignedtbr(String assignedTbrId) =>
      'assignedTbr/$assignedTbrId';
}
