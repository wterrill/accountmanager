import 'package:accountmanager/app/home/models/question.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

void main() {
  print('STARTED question_model_test.dart');
  group('fromMap tests', () {
    test('null data', () {
      final question = Question.fromMap(null, 'abc');
      expect(question, null);
    });
    test('question with all properties', () {
      final question1 = Question.fromMap(const {
        'Benefits / Business Value added Dec 2020': 'placeholder1',
        'Category': 'placeholder2',
        'Customer Approved Project': 'placeholder3',
        'Estimated Labor Price': 'placeholder4',
        'Estimated MRR Increase': 'placeholder5',
        'Estimated Product Price': 'placeholder6',
        'How to?': 'placeholder7',
        'Project Type': 'placeholder8',
        'Question Name': 'placeholder9',
        'Question Priority': 'placeholder10',
        'Question Text': 'placeholder11',
        'ROAD MAP = Month / Year [mm/yyyy]': 'placeholder12',
        'Section': 'placeholder13',
        'Sys Admin Notes': 'placeholder14',
        'Sys Admin Review Aligned (Y/N)': true,
        'TAM Recommendations': 'placeholder16',
        'TAM Review': 'placeholder17',
        'Total Project Estimate': 'placeholder18',
        'Type': 'placeholder19',
        'Why Are We Asking?': 'placeholder20',
        'id': 'placeholder21'
      }, 'placeholder21');
      const question2 = Question(
        benefitsBusinessValue: 'placeholder1',
        category: 'placeholder2',
        customerApprovedProject: 'placeholder3',
        estimatedLaborPrice: 'placeholder4',
        estimatedMRRIncrease: 'placeholder5',
        estimatedProductPrice: 'placeholder6',
        howTo: 'placeholder7',
        projectType: 'placeholder8',
        questionName: 'placeholder9',
        questionPriority: 'placeholder10',
        questionText: 'placeholder11',
        roadMap: 'placeholder12',
        section: 'placeholder13',
        sysAdminNotes: 'placeholder14',
        sysAdminReviewAligned: true,
        goodBadAnswer: 'placeholder15',
        tamRecommendations: 'placeholder16',
        tamReview: 'placeholder17',
        totalProjectEstimate: 'placeholder18',
        type: 'placeholder19',
        whyAreWeAsking: 'placeholder20',
        id: 'placeholder21',
      );
      expect(question1, question2);
    });

    test('missing question text', () {
      final question = Question.fromMap(const {}, 'abc');
      expect(question, null);
    });
  });

  group('toMap', () {
    final questionGoodMap = {
      'Benefits / Business Value added Dec 2020': 'placeholder1',
      'Category': 'placeholder2',
      'Customer Approved Project': 'placeholder3',
      'Estimated Labor Price': 'placeholder4',
      'Estimated MRR Increase': 'placeholder5',
      'Estimated Product Price': 'placeholder6',
      'How to?': 'placeholder7',
      'Project Type': 'placeholder8',
      'Question Name': 'placeholder9',
      'Question Priority': 'placeholder10',
      'Question Text': 'placeholder11',
      'ROAD MAP = Month / Year [mm/yyyy]': 'placeholder12',
      'Section': 'placeholder13',
      'Sys Admin Notes': 'placeholder14',
      'Sys Admin Review Aligned (Y/N)': true,
      'TAM Recommendations': 'placeholder16',
      'TAM Review': 'placeholder17',
      'Total Project Estimate': 'placeholder18',
      'Type': 'placeholder19',
      'Why Are We Asking?': 'placeholder20',
      'id': 'placeholder21'
    };
    const question = Question(
      benefitsBusinessValue: 'placeholder1',
      category: 'placeholder2',
      customerApprovedProject: 'placeholder3',
      estimatedLaborPrice: 'placeholder4',
      estimatedMRRIncrease: 'placeholder5',
      estimatedProductPrice: 'placeholder6',
      howTo: 'placeholder7',
      projectType: 'placeholder8',
      questionName: 'placeholder9',
      questionPriority: 'placeholder10',
      questionText: 'placeholder11',
      roadMap: 'placeholder12',
      section: 'placeholder13',
      sysAdminNotes: 'placeholder14',
      sysAdminReviewAligned: true,
      goodBadAnswer: 'placeholder15',
      tamRecommendations: 'placeholder16',
      tamReview: 'placeholder17',
      totalProjectEstimate: 'placeholder18',
      type: 'placeholder19',
      whyAreWeAsking: 'placeholder20',
      id: 'placeholder21',
    );
    test('valid map', () {
      expect(question.toMap(), questionGoodMap);
    });
  });

  group('equality', () {
    final questionGoodMap = {
      'Benefits / Business Value added Dec 2020': 'placeholder1',
      'Category': 'placeholder2',
      'Customer Approved Project': 'placeholder3',
      'Estimated Labor Price': 'placeholder4',
      'Estimated MRR Increase': 'placeholder5',
      'Estimated Product Price': 'placeholder6',
      'How to?': 'placeholder7',
      'Project Type': 'placeholder8',
      'Question Name': 'placeholder9',
      'Question Priority': 'placeholder10',
      'Question Text': 'placeholder11',
      'ROAD MAP = Month / Year [mm/yyyy]': 'placeholder12',
      'Section': 'placeholder13',
      'Sys Admin Notes': 'placeholder14',
      'Sys Admin Review Aligned (Y/N)': true,
      'TAM Recommendations': 'placeholder16',
      'TAM Review': 'placeholder17',
      'Total Project Estimate': 'placeholder18',
      'Type': 'placeholder19',
      'Why Are We Asking?': 'placeholder20',
      'id': 'placeholder21'
    };
    final questionBadMap = {
      'Benefits / Business Value added Dec 2020': 'BAD_BAD_BAD',
      'Category': 'placeholder2',
      'Customer Approved Project': 'placeholder3',
      'Estimated Labor Price': 'placeholder4',
      'Estimated MRR Increase': 'placeholder5',
      'Estimated Product Price': 'placeholder6',
      'How to?': 'placeholder7',
      'Project Type': 'placeholder8',
      'Question Name': 'placeholder9',
      'Question Priority': 'placeholder10',
      'Question Text': 'placeholder11',
      'ROAD MAP = Month / Year [mm/yyyy]': 'placeholder12',
      'Section': 'placeholder13',
      'Sys Admin Notes': 'placeholder14',
      'Sys Admin Review Aligned (Y/N)': true,
      'TAM Recommendations': 'placeholder16',
      'TAM Review': 'placeholder17',
      'Total Project Estimate': 'placeholder18',
      'Type': 'placeholder19',
      'Why Are We Asking?': 'placeholder20',
      'id': 'placeholder21'
    };

    test('same properties, equality returns true', () {
      const question1 = Question(
        benefitsBusinessValue: 'placeholder1',
        category: 'placeholder2',
        customerApprovedProject: 'placeholder3',
        estimatedLaborPrice: 'placeholder4',
        estimatedMRRIncrease: 'placeholder5',
        estimatedProductPrice: 'placeholder6',
        howTo: 'placeholder7',
        projectType: 'placeholder8',
        questionName: 'placeholder9',
        questionPriority: 'placeholder10',
        questionText: 'placeholder11',
        roadMap: 'placeholder12',
        section: 'placeholder13',
        sysAdminNotes: 'placeholder14',
        sysAdminReviewAligned: true,
        goodBadAnswer: 'placeholder15',
        tamRecommendations: 'placeholder16',
        tamReview: 'placeholder17',
        totalProjectEstimate: 'placeholder18',
        type: 'placeholder19',
        whyAreWeAsking: 'placeholder20',
        id: 'placeholder21',
      );
      final Question question2 =
          Question.fromMap(questionGoodMap, 'placeholder21');
      expect(question1 == question2, true);
    });
    test('different properties, equality returns false', () {
      const question1 = Question(
        benefitsBusinessValue: 'placeholder1',
        category: 'placeholder2',
        customerApprovedProject: 'placeholder3',
        estimatedLaborPrice: 'placeholder4',
        estimatedMRRIncrease: 'placeholder5',
        estimatedProductPrice: 'placeholder6',
        howTo: 'placeholder7',
        projectType: 'placeholder8',
        questionName: 'placeholder9',
        questionPriority: 'placeholder10',
        questionText: 'placeholder11',
        roadMap: 'placeholder12',
        section: 'placeholder13',
        sysAdminNotes: 'placeholder14',
        sysAdminReviewAligned: true,
        goodBadAnswer: 'placeholder15',
        tamRecommendations: 'placeholder16',
        tamReview: 'placeholder17',
        totalProjectEstimate: 'placeholder18',
        type: 'placeholder19',
        whyAreWeAsking: 'placeholder20',
        id: 'placeholder21',
      );
      final Question question2 =
          Question.fromMap(questionBadMap, 'placeholder21');
      expect(question1 == question2, false);
    });
  });

  group('props test', () {
    test('different properties, equality returns false', () {
      const question = Question(
        benefitsBusinessValue: 'placeholder1',
        category: 'placeholder2',
        customerApprovedProject: 'placeholder3',
        estimatedLaborPrice: 'placeholder4',
        estimatedMRRIncrease: 'placeholder5',
        estimatedProductPrice: 'placeholder6',
        howTo: 'placeholder7',
        projectType: 'placeholder8',
        questionName: 'placeholder9',
        questionPriority: 'placeholder10',
        questionText: 'placeholder11',
        roadMap: 'placeholder12',
        section: 'placeholder13',
        sysAdminNotes: 'placeholder14',
        sysAdminReviewAligned: true,
        goodBadAnswer: 'placeholder15',
        tamRecommendations: 'placeholder16',
        tamReview: 'placeholder17',
        totalProjectEstimate: 'placeholder18',
        type: 'placeholder19',
        whyAreWeAsking: 'placeholder20',
        id: 'placeholder21',
      );
      List<Object> propsExpectedBAD = [
        'placeholder21',
        'placeholder1',
        'placeholder2',
        'placeholder3',
        'placeholder4',
        'placeholder5',
        'placeholder6',
        'placeholder7',
        'placeholder8',
        'placeholder9',
        'placeholder10',
        'placeholder11',
        'placeholder12',
        'placeholder13',
        'placeholder14',
        false,
        'placeholder16',
        'placeholder17',
        'placeholder18',
        'placeholder19',
        'placeholder20',
      ];

      expect(listEquals(question.props, propsExpectedBAD), false);
    });

    test('same properties, equality returns true', () {
      const question = Question(
        benefitsBusinessValue: 'placeholder1',
        category: 'placeholder2',
        customerApprovedProject: 'placeholder3',
        estimatedLaborPrice: 'placeholder4',
        estimatedMRRIncrease: 'placeholder5',
        estimatedProductPrice: 'placeholder6',
        howTo: 'placeholder7',
        projectType: 'placeholder8',
        questionName: 'placeholder9',
        questionPriority: 'placeholder10',
        questionText: 'placeholder11',
        roadMap: 'placeholder12',
        section: 'placeholder13',
        sysAdminNotes: 'placeholder14',
        sysAdminReviewAligned: true,
        goodBadAnswer: 'placeholder15',
        tamRecommendations: 'placeholder16',
        tamReview: 'placeholder17',
        totalProjectEstimate: 'placeholder18',
        type: 'placeholder19',
        whyAreWeAsking: 'placeholder20',
        id: 'placeholder21',
      );
      List<Object> propsExpectedGOOD = [
        'placeholder21',
        'placeholder1',
        'placeholder2',
        'placeholder3',
        'placeholder4',
        'placeholder5',
        'placeholder6',
        'placeholder7',
        'placeholder8',
        'placeholder9',
        'placeholder10',
        'placeholder11',
        'placeholder12',
        'placeholder13',
        'placeholder14',
        true,
        'placeholder16',
        'placeholder17',
        'placeholder18',
        'placeholder19',
        'placeholder20',
      ];
      expect(listEquals(question.props, propsExpectedGOOD), true);
    });
  });
}
