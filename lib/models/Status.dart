// ignore_for_file: file_names
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Status extends Equatable {
  final int? statusIndex;
  Status({
    this.statusIndex,
  });

  @override
  List<Object?> get props => [
        statusIndex,
      ];

  final List<String> statusName = ['Assigned', 'In Progress', 'Completed'];

  String getStatusName() => statusName[statusIndex!];

  Status copyWith({
    int? statusIndex,
  }) {
    return Status(
      statusIndex: statusIndex ?? this.statusIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, int?>{
      'statusIndex': statusIndex,
    };
  }

  factory Status.fromMap(Map<String, dynamic>? map) {
    Status errorStatus = Status(statusIndex: -1);
    if (map == null) return errorStatus;

    if (map['statusIndex'] == null) return errorStatus;

    return Status(
      statusIndex: map['statusIndex'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) =>
      Status.fromMap(json.decode(source) as Map<String, dynamic>?);

  @override
  String toString() => 'Status(statusIndex: $statusIndex)';

  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is Status && o.statusIndex == statusIndex;
  // }

  // @override
  // int get hashCode => statusIndex.hashCode;
}
