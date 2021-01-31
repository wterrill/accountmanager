import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Question extends Equatable {
  final String benefitsBusinessValue;
  final String category;
  final String customerApprovedProject;
  final String estimatedLaborPrice;
  final String estimatedMRRIncrease;
  final String estimatedProductPrice;
  final String howTo;
  final String projectType;
  final String questionName;
  final String questionPriority;
  final String questionText;
  final String roadMap; //mm/yyyy
  final String section;
  final String sysAdminNotes;
  final bool sysAdminReviewAligned;
  final String tamRecommendations;
  final String tamReview;
  final String totalProjectEstimate;
  final String type;
  final String whyAreWeAsking;
  final String id;

  const Question({
    this.benefitsBusinessValue,
    this.category,
    this.customerApprovedProject,
    this.estimatedLaborPrice,
    this.estimatedMRRIncrease,
    this.estimatedProductPrice,
    this.howTo,
    this.projectType,
    this.questionName,
    this.questionPriority,
    this.questionText,
    this.roadMap,
    this.section,
    this.sysAdminNotes,
    this.sysAdminReviewAligned,
    this.tamRecommendations,
    this.tamReview,
    this.totalProjectEstimate,
    this.type,
    this.whyAreWeAsking,
    this.id,
  });

  Question copyWith({
    String benefitsBusinessValue,
    String category,
    String customerApprovedProject,
    String estimatedLaborPrice,
    String estimatedMRRIncrease,
    String estimatedProductPrice,
    String howTo,
    String projectType,
    String questionName,
    String questionPriority,
    String questionText,
    String roadMap,
    String section,
    String sysAdminNotes,
    bool sysAdminReviewAligned,
    String tamRecommendations,
    String tamReview,
    String totalProjectEstimate,
    String type,
    String whyAreWeAsking,
    String id,
  }) {
    return Question(
      benefitsBusinessValue:
          benefitsBusinessValue ?? this.benefitsBusinessValue,
      category: category ?? this.category,
      customerApprovedProject:
          customerApprovedProject ?? this.customerApprovedProject,
      estimatedLaborPrice: estimatedLaborPrice ?? this.estimatedLaborPrice,
      estimatedMRRIncrease: estimatedMRRIncrease ?? this.estimatedMRRIncrease,
      estimatedProductPrice:
          estimatedProductPrice ?? this.estimatedProductPrice,
      howTo: howTo ?? this.howTo,
      projectType: projectType ?? this.projectType,
      questionName: questionName ?? this.questionName,
      questionPriority: questionPriority ?? this.questionPriority,
      questionText: questionText ?? this.questionText,
      roadMap: roadMap ?? this.roadMap,
      section: section ?? this.section,
      sysAdminNotes: sysAdminNotes ?? this.sysAdminNotes,
      sysAdminReviewAligned:
          sysAdminReviewAligned ?? this.sysAdminReviewAligned,
      tamRecommendations: tamRecommendations ?? this.tamRecommendations,
      tamReview: tamReview ?? this.tamReview,
      totalProjectEstimate: totalProjectEstimate ?? this.totalProjectEstimate,
      type: type ?? this.type,
      whyAreWeAsking: whyAreWeAsking ?? this.whyAreWeAsking,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [
        id,
        benefitsBusinessValue,
        category,
        customerApprovedProject,
        estimatedLaborPrice,
        estimatedMRRIncrease,
        estimatedProductPrice,
        howTo,
        projectType,
        questionName,
        questionPriority,
        questionText,
        roadMap,
        section,
        sysAdminNotes,
        sysAdminReviewAligned,
        tamRecommendations,
        tamReview,
        totalProjectEstimate,
        type,
        whyAreWeAsking
      ];

  Map<String, dynamic> toMap() {
    return {
      'Benefits / Business Value added Dec 2020': benefitsBusinessValue,
      'Category': category,
      'Customer Approved Project': customerApprovedProject,
      'Estimated Labor Price': estimatedLaborPrice,
      'Estimated MRR Increase': estimatedMRRIncrease,
      'Estimated Product Price': estimatedProductPrice,
      'How to?': howTo,
      'Project Type': projectType,
      'Question Name': questionName,
      'Question Priority': questionPriority,
      'Question Text': questionText,
      'ROAD MAP = Month / Year [mm/yyyy]': roadMap,
      'Section': section,
      'Sys Admin Notes': sysAdminNotes,
      'Sys Admin Review Aligned (Y/N)': sysAdminReviewAligned,
      'TAM Recommendations': tamRecommendations,
      'TAM Review': tamReview,
      'Total Project Estimate': totalProjectEstimate,
      'Type': type,
      'Why Are We Asking?': whyAreWeAsking,
      'id': id
    };
  }

  factory Question.fromMap(Map<String, dynamic> map, String id) {
    if (map == null || id == null) return null;

    if (map['Question Text'] == null) {
      return null;
    }

    return Question(
      benefitsBusinessValue: map['Benefits / Business Value added Dec 2020'],
      category: map['Category'],
      customerApprovedProject: map['Customer Approved Project'],
      estimatedLaborPrice: map['Estimated Labor Price'],
      estimatedMRRIncrease: map['Estimated MRR Increase'],
      estimatedProductPrice: map['Estimated Product Price'],
      howTo: map['How to?'],
      projectType: map['Project Type'],
      questionName: map['Question Name'],
      questionPriority: map['Question Priority'],
      questionText: map['Question Text'],
      roadMap: map['ROAD MAP = Month / Year [mm/yyyy]'],
      section: map['Section'],
      sysAdminNotes: map['Sys Admin Notes'],
      sysAdminReviewAligned: map['Sys Admin Review Aligned (Y/N)'],
      tamRecommendations: map['TAM Recommendations'],
      tamReview: map['TAM Review'],
      totalProjectEstimate: map['Total Project Estimate'],
      type: map['Type'],
      whyAreWeAsking: map['Why Are We Asking?'],
      id: (id == null) ? map['id'] : id,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source), null);

  @override
  String toString() {
    return 'Question(benefitsBusinessValue: $benefitsBusinessValue, category: $category, customerApprovedProject: $customerApprovedProject, estimatedLaborPrice: $estimatedLaborPrice, estimatedMRRIncrease: $estimatedMRRIncrease, estimatedProductPrice: $estimatedProductPrice, howTo: $howTo, projectType: $projectType, questionName: $questionName, questionPriority: $questionPriority, questionText: $questionText, roadMap: $roadMap, section: $section, sysAdminNotes: $sysAdminNotes, sysAdminReviewAligned: $sysAdminReviewAligned, tamRecommendations: $tamRecommendations, tamReview: $tamReview, totalProjectEstimate: $totalProjectEstimate, type: $type, whyAreWeAsking: $whyAreWeAsking, id: $id)';
  }

  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is Question &&
  //       o.benefitsBusinessValue == benefitsBusinessValue &&
  //       o.category == category &&
  //       o.customerApprovedProject == customerApprovedProject &&
  //       o.estimatedLaborPrice == estimatedLaborPrice &&
  //       o.estimatedMRRIncrease == estimatedMRRIncrease &&
  //       o.estimatedProductPrice == estimatedProductPrice &&
  //       o.howTo == howTo &&
  //       o.projectType == projectType &&
  //       o.questionName == questionName &&
  //       o.questionPriority == questionPriority &&
  //       o.questionText == questionText &&
  //       o.roadMap == roadMap &&
  //       o.section == section &&
  //       o.sysAdminNotes == sysAdminNotes &&
  //       o.sysAdminReviewAligned == sysAdminReviewAligned &&
  //       o.tamRecommendations == tamRecommendations &&
  //       o.tamReview == tamReview &&
  //       o.totalProjectEstimate == totalProjectEstimate &&
  //       o.type == type &&
  //       o.whyAreWeAsking == whyAreWeAsking &&
  //       o.id == id;
  // }

  // @override
  // int get hashCode {
  //   return benefitsBusinessValue.hashCode ^
  //       category.hashCode ^
  //       customerApprovedProject.hashCode ^
  //       estimatedLaborPrice.hashCode ^
  //       estimatedMRRIncrease.hashCode ^
  //       estimatedProductPrice.hashCode ^
  //       howTo.hashCode ^
  //       projectType.hashCode ^
  //       questionName.hashCode ^
  //       questionPriority.hashCode ^
  //       questionText.hashCode ^
  //       roadMap.hashCode ^
  //       section.hashCode ^
  //       sysAdminNotes.hashCode ^
  //       sysAdminReviewAligned.hashCode ^
  //       tamRecommendations.hashCode ^
  //       tamReview.hashCode ^
  //       totalProjectEstimate.hashCode ^
  //       type.hashCode ^
  //       whyAreWeAsking.hashCode ^
  //       id.hashCode;
  // }
}
