import 'package:accountmanager/app/home/models/question.dart';

class TBRinProgress {
  final List<Question> allQuestions;
  List<String> sections;
  Map<String, List<String>> categories;
  Map<String, List<bool>> answers;
  TBRinProgress({this.allQuestions}) {
    sections = createSectionList(allQuestions);
    categories = createCategoryMap(sections, allQuestions);
    answers = createAnswerMap(allQuestions);
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

  Map<String, List<bool>> createAnswerMap(List<Question> questionList) {
    final Map<String, List<bool>> returnedAnswers = {};
    for (final Question question in questionList) {
      returnedAnswers[question.id] = [false, false, false];
    }
    return returnedAnswers;
  }

  Map<String, String> advancePage({String section, String category}) {
    final Map<String, String> newSectionCategory = {};
    final List<String> currentCategories = categories[section.toLowerCase()];
    // case, end of categories
    if (currentCategories.indexOf(category) == currentCategories.length - 1) {
      // case, end of categories, and end of sections
      if (sections.indexOf(section) == sections.length - 1) {
        newSectionCategory['section'] = section;
        newSectionCategory['category'] = category;
      }
      // advance section, category to first
      else {
        final String newSection = sections[sections.indexOf(section) + 1];
        newSectionCategory['section'] = newSection;
        newSectionCategory['category'] =
            categories[newSection.toLowerCase()][0];
      }
    }
    // keep section, advance category
    else {
      newSectionCategory['section'] = section;
      newSectionCategory['category'] = categories[section.toLowerCase()]
          [categories[section.toLowerCase()].indexOf(category) + 1];
    }
    return newSectionCategory;
  }

  Map<String, String> recedePage({String section, String category}) {
    Map<String, String> newSectionCategory = {};
    final List<String> currentCategories = categories[section.toLowerCase()];
    // case, beginning of categories
    if (currentCategories.indexOf(category) == 0) {
      // case, beginning of categories, beginning of sections
      if (sections.indexOf(section) == 0) {
        newSectionCategory['section'] = section;
        newSectionCategory['category'] = category;
      }
      // recede a section and set category to end of list
      else {
        final String newSection = sections[sections.indexOf(section) - 1];
        newSectionCategory['section'] = newSection;
        newSectionCategory['category'] = categories[newSection.toLowerCase()]
            [categories[newSection.toLowerCase()].length - 1];
      }
    }
    // keep section, and recede a category
    else {
      newSectionCategory['section'] = section;
      newSectionCategory['category'] = categories[section.toLowerCase()]
          [categories[section.toLowerCase()].indexOf(category) - 1];
    }
    return newSectionCategory;
  }
}
