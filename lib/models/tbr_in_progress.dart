import 'dart:io';
import 'package:accountmanager/models/question.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'tbr_in_progress.g.dart';

@HiveType(typeId: 1)
class TBRinProgress {
  @HiveField(0)
  List<Question>? allQuestions; // 0, question1
  @HiveField(1)
  late List<String?> sections;
  @HiveField(2)
  late Map<String, List<String?>>
      categories; // "section name", List<"category name">
  @HiveField(3)
  late Map<String, Map<String, double>>
      percentages; // "section name", "category name",
  @HiveField(4)
  double totalPercent = 0;
  @HiveField(5)
  Map<String?, List<bool>?>? answers; // question ID: 0,0,0    yes, no, n/a
  @HiveField(6)
  late Map<String?, Map<String, List<int?>>>
      colorScheme; //section: category: List<Colors>
  @HiveField(7)
  Map<String?, String>? adminComment; // category:
  @HiveField(8)
  Map<String?, String>? tamNotes;
  @HiveField(9)
  bool showSubmitButton = false;
  @HiveField(10)
  String? id;
  TBRinProgress();

  factory TBRinProgress.fromMap(
      Map<String, dynamic>? map, String id, List<Question>? questions) {
    print('inside TBRinProgress fromMap');

    final TBRinProgress tbrInProgress = TBRinProgress();
    // ignore: prefer_initializing_formals
    tbrInProgress.id = id;
    tbrInProgress.initialize(questions, id);

    if (map != null) {
      final Map<String, dynamic> temp =
          Map<String, List<dynamic>>.from(map['answers']);
      // final Map<String, List<bool>> temp =
      //     map['answers'] as Map<String, List<bool>>;
      final Map<String?, List<bool>?> temp2 = {};
      final List<String> keys = temp.keys.toList();
      for (var i = 0; i < keys.length; i++) {
        print(keys[i]);
        final List<bool> tempArray = [true, true, true];
        for (var j = 0; j < 3; j++) {
          if (temp[keys[i]][j].toString() == 'true') {
            tempArray[j] = true;
          } else {
            tempArray[j] = false;
          }
        }
        temp2[keys[i]] = tempArray;
      }
      // temp.forEach((key, value) {
      //   print(key);
      //   final List<bool> tempArray = [true, true, true];
      //   for (var i = 0; i < value.length; i++) {
      //     if (value[i].toString() == 'true') {
      //       tempArray[i] = true;
      //     } else {
      //       tempArray[i] = false;
      //     }
      //   }
      //   temp2[key] = tempArray;
      // });

      tbrInProgress.answers = temp2;

      Map<String?, dynamic> tempMap =
          map['adminComment'] as Map<String, dynamic>;

      tbrInProgress.adminComment =
          tempMap.map((key, dynamic value) => MapEntry(key, value.toString()));
      tempMap = map['tamNotes'] as Map<String, dynamic>;
      tbrInProgress.tamNotes =
          tempMap.map((key, dynamic value) => MapEntry(key, value.toString()));
    }

    return tbrInProgress;
  }

  void initialize(List<Question>? allQuestionsIn, String idx) {
    allQuestions = allQuestionsIn;
    sections = createSectionList(allQuestions!);
    categories = createCategoryMap(sections, allQuestions);
    answers = createAnswerMap(allQuestions!);
    percentages = createPercentagesMap(categories);
    colorScheme = generateColors(allQuestions!);
    adminComment = initializeComments(allQuestions!);
    tamNotes = initializeComments(allQuestions!);
    id = idx;
    // id = DateTime.now().toUtc().microsecondsSinceEpoch.toString();
  }

  Map<String?, String> initializeComments(List<Question> allQuestions) {
    final Map<String?, String> returnedMap = {};
    for (final Question question in allQuestions) {
      returnedMap[question.id] = '';
    }
    return returnedMap;
  }

  List<String?> createSectionList(List<Question> questionList) {
    final List<String?> temp = [];
    questionList.sort((a, b) => a.section!.compareTo(b.section!));
    for (final Question question in questionList) {
      temp.add(question.section);
    }
    final Set sectionSet = temp.toSet();
    return sectionSet.toList() as List<String?>;
  }

  Map<String, List<String?>> createCategoryMap(
      List<String?> sections, List<Question>? questions) {
    final Map<String, List<String?>> mapSectionsWithCategories = {};
    for (final String? section in sections) {
      final List<Question> questionOneSectionCategories =
          questions!.where((element) => element.section == section).toList();
      final List<String?> thisSectionCategories = [];
      for (final question in questionOneSectionCategories) {
        thisSectionCategories.add(question.category);
      }
      final Set categorySet = thisSectionCategories.toSet();
      final List<String?> uniqueSectionCategories =
          categorySet.toList() as List<String?>;
      uniqueSectionCategories.sort((a, b) => a!.compareTo(b!));
      mapSectionsWithCategories[section!.toLowerCase()] =
          uniqueSectionCategories;
    }
    return mapSectionsWithCategories;
  }

  Map<String, Map<String, double>> createPercentagesMap(
      Map<String, List<String?>> categories) {
    final Map<String, Map<String, double>> finalMap = {};
    for (final String sectkey in categories.keys) {
      final List<String?> sections = categories[sectkey]!;
      final Map<String, double> catMap = {};
      for (final String? catkey in sections) {
        catMap[catkey!.toLowerCase()] = 0.0;
      }
      catMap['total'] = 0.0;
      finalMap[sectkey] = catMap;
    }
    return finalMap;
  }

  List<Question> getQuestions({String? sectionIn, String? categoryIn}) {
    final List<Question> sectionFiltered =
        allQuestions!.where((element) => element.section == sectionIn).toList();
    final List<Question> categoryFiltered = sectionFiltered
        .where((element) => element.category == categoryIn)
        .toList();
    return categoryFiltered;
  }

  Map<String?, List<bool>?> createAnswerMap(List<Question> questionList) {
    final Map<String?, List<bool>?> returnedAnswers = {};
    for (final Question question in questionList) {
      returnedAnswers[question.id] = [false, false, false];
    }
    return returnedAnswers;
  }

  Map<String, String?> advancePage(
      {required String section, String? category}) {
    final Map<String, String?> newSectionCategory = {};
    final List<String?> currentCategories = categories[section.toLowerCase()]!;
    // case, end of categories
    if (currentCategories.indexOf(category) == currentCategories.length - 1) {
      // case, end of categories, and end of sections
      if (sections.indexOf(section) == sections.length - 1) {
        newSectionCategory['section'] = section;
        newSectionCategory['category'] = category;
      }
      // advance section, category to first
      else {
        final String newSection = sections[sections.indexOf(section) + 1]!;
        newSectionCategory['section'] = newSection;
        newSectionCategory['category'] =
            categories[newSection.toLowerCase()]![0];
      }
    }
    // keep section, advance category
    else {
      newSectionCategory['section'] = section;
      newSectionCategory['category'] = categories[section.toLowerCase()]![
          categories[section.toLowerCase()]!.indexOf(category) + 1];
    }
    return newSectionCategory;
  }

  Map<String, String?> recedePage({required String section, String? category}) {
    final Map<String, String?> newSectionCategory = {};
    final List<String?> currentCategories = categories[section.toLowerCase()]!;
    // case, beginning of categories
    if (currentCategories.indexOf(category) == 0) {
      // case, beginning of categories, beginning of sections
      if (sections.indexOf(section) == 0) {
        newSectionCategory['section'] = section;
        newSectionCategory['category'] = category;
      }
      // recede a section and set category to end of list
      else {
        final String newSection = sections[sections.indexOf(section) - 1]!;
        newSectionCategory['section'] = newSection;
        newSectionCategory['category'] = categories[newSection.toLowerCase()]![
            categories[newSection.toLowerCase()]!.length - 1];
      }
    }
    // keep section, and recede a category
    else {
      newSectionCategory['section'] = section;
      newSectionCategory['category'] = categories[section.toLowerCase()]![
          categories[section.toLowerCase()]!.indexOf(category) - 1];
    }
    return newSectionCategory;
  }

  Map<String?, Map<String, List<int?>>> generateColors(
      List<Question> questions) {
    final Map<String?, Map<String, List<int?>>> wholeColorScheme = {};
    for (final Question question in questions) {
      final Map<String, List<int?>> returnedMap = {};
      if (question.goodBadAnswer == 'N = Bad') {
        returnedMap['borderColorList'] = [
          4280902399,
          4280902399,
          4280902399
          // Colors.blue,
          // Colors.blue,
          // Colors.blue
        ];
        returnedMap['selectedColorList'] = [
          4278190080,
          4294967295,
          4278190080
          // Colors.black,
          // Colors.white,
          // Colors.black
        ];
        // returnedMap['fillColorList'] = [Colors.green, Colors.red, Colors.grey];
        returnedMap['fillColorList'] = [4284922730, 4293874512, 4290624957];

        returnedMap['hoverColorList'] = [
          4291356361,
          4294954450,
          4292927712
          // Colors.green[100],
          // Colors.red[100],
          // Colors.grey[300]
        ];
      } else {
        returnedMap['borderColorList'] = [
          4280902399,
          4280902399,
          4280902399
          // Colors.blue,
          // Colors.blue,
          // Colors.blue
        ];
        returnedMap['selectedColorList'] = [
          4278190080,
          4278190080,
          4278190080
          // Colors.black,
          // Colors.black,
          // Colors.black
        ];
        returnedMap['fillColorList'] = [
          4284922730,
          4284922730,
          4290624957
          // Colors.green,
          // Colors.green,
          // Colors.grey
        ];

        returnedMap['hoverColorList'] = [
          4291356361,
          4294954450,
          4292927712
          // Colors.green[100],
          // Colors.green[100],
          // Colors.grey[300]
        ];
      }
      wholeColorScheme[question.id] = returnedMap;
    }
    return wholeColorScheme;
  }

  void updatePercentages() {
    int intOverAllTotal = 0;
    int intOverAllTally = 0;

    for (final String? sectionName in sections) {
      int sectTotal = 0;
      int sectTally = 0;
      int catTally = 0;
      // double catPercent;
      for (final String? catName in categories[sectionName!.toLowerCase()]!) {
        // This questions a list of question in the section and category
        final List<Question> questionsSectCat = allQuestions!.where((element) {
          if (element.section == sectionName && element.category == catName) {
            print(element);
            return true;
          }
          return false;
        }).toList();
        // This gets a list of answered Question in the secitn and category
        final List<Question> answeredQuestionsSectCat = questionsSectCat
            .where((element) =>
                answers![element.id].toString() != '[false, false, false]')
            .toList();
        catTally = answeredQuestionsSectCat.length;
        sectTally = sectTally + catTally;
        sectTotal = sectTotal + questionsSectCat.length;

        final double catPercent = catTally / questionsSectCat.length;
        percentages[sectionName.toLowerCase()]![catName!.toLowerCase()] =
            catPercent;
      }
      final double sectPercent = sectTally / sectTotal;
      percentages[sectionName.toLowerCase()]!['total'] = sectPercent;
      intOverAllTally += sectTally;
      intOverAllTotal += sectTotal;
    }
    totalPercent = intOverAllTally / intOverAllTotal;
    checkIfCanSubmit();
  }

  void checkIfCanSubmit() {
    bool canSubmit = true;
    for (final String? section in sections) {
      if (percentages[section!.toLowerCase()]!['total'] != 1) {
        canSubmit = false;
      }
    }

    showSubmitButton = canSubmit;
  }

  Question? getQuestionFromId(String? id) {
    for (int i = 0; i < allQuestions!.length; i++) {
      if (allQuestions![i].id == id) {
        return allQuestions![i];
      }
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> mapToSend = <String, dynamic>{};
    mapToSend['answers'] = answers;
    mapToSend['adminComment'] = adminComment;
    mapToSend['tamNotes'] = tamNotes;
    mapToSend['id'] = id;
    return mapToSend;
  }
}
