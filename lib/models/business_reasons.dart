import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Reason extends Equatable {
  final String name;
  final List<String> data;

  const Reason({required this.name, required this.data});

  Reason copyWith({
    Map<String, List<String>>? reasons,
  }) {
    return Reason(name: name, data: data);
  }

  @override
  List<Object?> get props => [name, data];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'data': data};
  }

  factory Reason.fromMap(Map<String, dynamic>? map) {
    const Reason errorQuestion = Reason(name: 'Error', data: <String>['error']);

    if (map == null) return errorQuestion;

    if (map['name'] == null) {
      return errorQuestion;
    }

    final List<String> data = [];
    for (int i = 0; i < map.length - 1; i++) {
      data.add(map[i.toString()]);
    }

    return Reason(name: map['name'], data: data);
  }

  String toJson() => json.encode(toMap());

  factory Reason.fromJson(String source) =>
      Reason.fromMap(json.decode(source) as Map<String, dynamic>?);
}
