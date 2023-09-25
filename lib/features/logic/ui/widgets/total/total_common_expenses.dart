import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../auth/providers/user_model.dart';
import 'card_total.dart';

class TotalCommonExpenses extends StatefulWidget {
  const TotalCommonExpenses({super.key});

  @override
  State<TotalCommonExpenses> createState() => _TotalCommonExpensesState();
}

class _TotalCommonExpensesState extends State<TotalCommonExpenses> {
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    List<String> names = userModel.userName.split(' ');

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("spend")
          .where('uid', isEqualTo: userModel.userId)
          .where('personfor', isEqualTo: "Les deux")
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text("Erreur: ${snapshot.error}");
        }

        if (!snapshot.hasData) {
          return const Text("Pas de données disponibles");
        }

        double totalValue = 0;
        snapshot.data!.docs.forEach((document) {
          totalValue += double.parse(document['value']) ?? 0;
        });

        return CardTotal(
          leadingIcon: Icons.functions,
          title: 'Total des dépenses partagées',
          trailingText: '${totalValue.toStringAsFixed(2)} €',
          currentValue: totalValue,
          maxValue: 2600,
        );
      },
    );
  }
}
