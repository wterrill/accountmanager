import 'package:accountmanager/app/home/models/question.dart';

class TBRinProgress {
  final List<Question> allQuestions;
  List<String> sections;
  Map<String, List<String>> categories;
  TBRinProgress({this.allQuestions}) {
    sections = createSectionList(allQuestions);
    categories = createCategoryMap(sections, allQuestions);
  }

  List<String> createSectionList(List<Question> questionList) {
    final List<String> temp = [];
    questionList.sort((a, b) => a.section.compareTo(b.section));
    for (final Question question in questionList) {
      temp.add(question.section);
    }
    final Set sectionSet = temp.toSet();
    print(sectionSet);
    return sectionSet.toList() as List<String>;
  }

  Map<String, List<String>> createCategoryMap(
      List<String> sections, List<Question> questions) {
    final Map<String, List<String>> mapSectionsWithCategories = {};
    for (final String section in sections) {
      final List<Question> questionOneSectionCategories =
          questions.where((element) => element.section == section).toList();
      final List<String> thisSectionCategories = [];
      for (final question in questionOneSectionCategories) {
        thisSectionCategories.add(question.category);
      }
      final Set categorySet = thisSectionCategories.toSet();
      final List<String> uniqueSectionCategories =
          categorySet.toList() as List<String>;
      uniqueSectionCategories.sort((a, b) => a.compareTo(b));
      mapSectionsWithCategories[section.toLowerCase()] =
          uniqueSectionCategories;
      print(mapSectionsWithCategories);
    }
    print(mapSectionsWithCategories);
    return mapSectionsWithCategories;
  }

  List<Question> getQuestions({String sectionIn, String categoryIn}) {
    final List<Question> sectionFiltered =
        allQuestions.where((element) => element.section == sectionIn).toList();
    final List<Question> categoryFiltered = sectionFiltered
        .where((element) => element.category == categoryIn)
        .toList();
    return categoryFiltered;
  }
}
