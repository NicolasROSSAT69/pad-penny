import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pad_penny/features/logic/ui/widgets/total/card_total.dart';
import 'package:pad_penny/features/logic/ui/widgets/total/total_common_expenses.dart';
import 'package:pad_penny/features/logic/ui/widgets/total/total_my_spend.dart';

class Totals extends StatefulWidget {
  const Totals({super.key});

  @override
  State<Totals> createState() => _TotalsState();
}

class _TotalsState extends State<Totals> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TotalMySpend(),
        TotalCommonExpenses()
      ],
    );
  }
}
