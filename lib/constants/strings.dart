// ignore_for_file: avoid_classes_with_only_static_members
class Strings {
  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Cancel';

  // Logout
  static const String logout = 'Sign Out';
  static const String logoutAreYouSure =
      'Are you sure that you want to Sign Out?';
  static const String logoutFailed = 'Sign Out failed';

  // Sign In Page
  static const String signIn = 'Sign in';
  static const String signInWithEmailPassword =
      'Sign in with email and password';
  static const String goAnonymous = 'Go anonymous';
  static const String or = 'or';
  static const String signInFailed = 'Sign in failed';

  // Home page
  static const String homePage = 'Home Page';

  // Jobs page
  static const String jobs = 'Jobs';

  // Entries page
  static const String entries = 'Entries';

  // Account page
  static const String account = 'Account';
  static const String accountPage = 'Account Settings';

  // Assign TBR Page

  static CompanyStrings companyStrings = CompanyStrings();
  static TechnicianStrings technicianStrings = TechnicianStrings();
  static TBRStrings tbrStrings = TBRStrings();

  // Add Overview Page
  static const String overview = 'Overview';

  // Add app page
  static const String app = 'App';

  // Question Edit Page
  static QuestionStrings questionStrings = QuestionStrings();

  // Errors
  static const String error = 'An error has occurred';

  // Misc
  static const String placeHolder = 'placeholder';
}

class CompanyStrings {
  CompanyStrings();
  // Add Company Page
  final String addCompany = 'Add Company';
  final String company = 'Company';
}

class TechnicianStrings {
  TechnicianStrings();
  // Create Tech Account Page
  final String createTech = 'Create Technician';
  final String technician = 'Technician';
}

class TBRStrings {
  TBRStrings();
  final String assignTbr = 'Assign TBR';
  final String header = 'Assigned TBR Data';
  final String dueDate = 'Due Date';
  final String questionEdit = 'Questions';
  final String meetingDate = 'Meeting Date';
  final String status = 'Status';
  final String type = 'Type';
}

class QuestionStrings {
  QuestionStrings();
  final String header = 'Question Data';
  final String category = 'Category';
  final String benefits = 'Benefits / Bus. Value';
  final String questionText = 'Question Text';
  final String questionPriority = 'Question Priority';
  final String type = 'Type';
  final String whyAreWeAsking = 'Why are we asking?';
  final String createQuestion = 'Make new Question';
}
