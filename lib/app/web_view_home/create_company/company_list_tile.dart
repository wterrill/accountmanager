import 'package:accountmanager/models/company.dart';
import 'package:flutter/material.dart';

class CompanyListTile extends StatelessWidget {
  const CompanyListTile(
      {Key? key, required this.company, this.onTap, this.trailing})
      : super(key: key);
  final Company company;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(company.name!),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
