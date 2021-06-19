import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class BusinessReasons extends Equatable {
  final Map<String, List<String>>? reasons;

  const BusinessReasons({
    this.reasons,
  });

  BusinessReasons copyWith({
    Map<String, List<String>>? reasons,
  }) {
    return BusinessReasons(
      reasons: reasons ?? this.reasons,
    );
  }

  @override
  List<Object?> get props => [reasons];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reasons': reasons,
    };
  }

  factory BusinessReasons.fromMap(Map<String, dynamic>? map, String? id) {
    const BusinessReasons errorQuestion =
        BusinessReasons(reasons: <String, List<String>>{
      'error': ['error']
    });

    if (map == null || id == null) return errorQuestion;

    if (map['Question Text'] == null) {
      return errorQuestion;
    }

    return BusinessReasons(
      reasons: map['reasons'] as Map<String, List<String>>,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessReasons.fromJson(String source) => BusinessReasons.fromMap(
      json.decode(source) as Map<String, dynamic>?, null);
}
