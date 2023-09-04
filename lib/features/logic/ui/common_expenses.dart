import 'package:flutter/material.dart';

class CommonExpenses extends StatefulWidget {
  const CommonExpenses({super.key});

  @override
  State<CommonExpenses> createState() => _CommonExpensesState();
}

class _CommonExpensesState extends State<CommonExpenses> {
  @override
  Widget build(BuildContext context) {
    return const Text("Dépenses communes");
  }
}
