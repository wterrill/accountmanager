import 'dart:convert';

class Status {
  final int statusIndex;
  Status({
    this.statusIndex,
  });

  List<String> statusName = ['Assigned', 'In Progress', 'Completed'];

  String getStatusName() => statusName[statusIndex];

  Status copyWith({
    int statusIndex,
  }) {
    return Status(
      statusIndex: statusIndex ?? this.statusIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusIndex': statusIndex,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Status(
      statusIndex: map['statusIndex'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) => Status.fromMap(json.decode(source));

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
