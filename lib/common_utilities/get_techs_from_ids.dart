import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Technician> getTechsFromId(
  List<String> techIds,
  BuildContext context,
) {
  final List<Technician>? technicians = context.read(techniciansProvider).state;
  final List<Technician> returnedTechs = [];
  for (final String id in techIds) {
    for (final Technician tech in technicians!) {
      if (tech.id == id) {
        returnedTechs.add(tech);
      }
    }
  }
  return returnedTechs;
}
