import 'dart:convert';

class Question {
  final String benefitsBusinessValue;
  final String category;
  final String customerApprovedProject;
  final String estimatedLaborPrice;
  final String estimatedMRRIncrease;
  final String estimatedProductPrice;
  final String howTo;
  final String projectType;
  final String questionName;
  final String questionPrioirity;
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

  Question({
    this.benefitsBusinessValue,
    this.category,
    this.customerApprovedProject,
    this.estimatedLaborPrice,
    this.estimatedMRRIncrease,
    this.estimatedProductPrice,
    this.howTo,
    this.projectType,
    this.questionName,
    this.questionPrioirity,
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
    String questionPrioirity,
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
      questionPrioirity: questionPrioirity ?? this.questionPrioirity,
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

  Map<String, dynamic> toMap() {
    return {
      'benefitsBusinessValue': benefitsBusinessValue,
      'category': category,
      'customerApprovedProject': customerApprovedProject,
      'estimatedLaborPrice': estimatedLaborPrice,
      'estimatedMRRIncrease': estimatedMRRIncrease,
      'estimatedProductPrice': estimatedProductPrice,
      'howTo': howTo,
      'projectType': projectType,
      'questionName': questionName,
      'questionPrioirity': questionPrioirity,
      'questionText': questionText,
      'roadMap': roadMap,
      'section': section,
      'sysAdminNotes': sysAdminNotes,
      'sysAdminReviewAligned': sysAdminReviewAligned,
      'tamRecommendations': tamRecommendations,
      'tamReview': tamReview,
      'totalProjectEstimate': totalProjectEstimate,
      'type': type,
      'whyAreWeAsking': whyAreWeAsking,
      'id': id,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Question(
      benefitsBusinessValue: map['benefitsBusinessValue'],
      category: map['category'],
      customerApprovedProject: map['customerApprovedProject'],
      estimatedLaborPrice: map['estimatedLaborPrice'],
      estimatedMRRIncrease: map['estimatedMRRIncrease'],
      estimatedProductPrice: map['estimatedProductPrice'],
      howTo: map['howTo'],
      projectType: map['projectType'],
      questionName: map['questionName'],
      questionPrioirity: map['questionPrioirity'],
      questionText: map['questionText'],
      roadMap: map['roadMap'],
      section: map['section'],
      sysAdminNotes: map['sysAdminNotes'],
      sysAdminReviewAligned: map['sysAdminReviewAligned'],
      tamRecommendations: map['tamRecommendations'],
      tamReview: map['tamReview'],
      totalProjectEstimate: map['totalProjectEstimate'],
      type: map['type'],
      whyAreWeAsking: map['whyAreWeAsking'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(benefitsBusinessValue: $benefitsBusinessValue, category: $category, customerApprovedProject: $customerApprovedProject, estimatedLaborPrice: $estimatedLaborPrice, estimatedMRRIncrease: $estimatedMRRIncrease, estimatedProductPrice: $estimatedProductPrice, howTo: $howTo, projectType: $projectType, questionName: $questionName, questionPrioirity: $questionPrioirity, questionText: $questionText, roadMap: $roadMap, section: $section, sysAdminNotes: $sysAdminNotes, sysAdminReviewAligned: $sysAdminReviewAligned, tamRecommendations: $tamRecommendations, tamReview: $tamReview, totalProjectEstimate: $totalProjectEstimate, type: $type, whyAreWeAsking: $whyAreWeAsking, id: $id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Question &&
        o.benefitsBusinessValue == benefitsBusinessValue &&
        o.category == category &&
        o.customerApprovedProject == customerApprovedProject &&
        o.estimatedLaborPrice == estimatedLaborPrice &&
        o.estimatedMRRIncrease == estimatedMRRIncrease &&
        o.estimatedProductPrice == estimatedProductPrice &&
        o.howTo == howTo &&
        o.projectType == projectType &&
        o.questionName == questionName &&
        o.questionPrioirity == questionPrioirity &&
        o.questionText == questionText &&
        o.roadMap == roadMap &&
        o.section == section &&
        o.sysAdminNotes == sysAdminNotes &&
        o.sysAdminReviewAligned == sysAdminReviewAligned &&
        o.tamRecommendations == tamRecommendations &&
        o.tamReview == tamReview &&
        o.totalProjectEstimate == totalProjectEstimate &&
        o.type == type &&
        o.whyAreWeAsking == whyAreWeAsking &&
        o.id == id;
  }

  @override
  int get hashCode {
    return benefitsBusinessValue.hashCode ^
        category.hashCode ^
        customerApprovedProject.hashCode ^
        estimatedLaborPrice.hashCode ^
        estimatedMRRIncrease.hashCode ^
        estimatedProductPrice.hashCode ^
        howTo.hashCode ^
        projectType.hashCode ^
        questionName.hashCode ^
        questionPrioirity.hashCode ^
        questionText.hashCode ^
        roadMap.hashCode ^
        section.hashCode ^
        sysAdminNotes.hashCode ^
        sysAdminReviewAligned.hashCode ^
        tamRecommendations.hashCode ^
        tamReview.hashCode ^
        totalProjectEstimate.hashCode ^
        type.hashCode ^
        whyAreWeAsking.hashCode ^
        id.hashCode;
  }
}
