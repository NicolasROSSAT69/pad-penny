import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../auth/providers/user_model.dart';
import 'card_total.dart';

class TotalMySpend extends StatefulWidget {
  const TotalMySpend({super.key});

  @override
  State<TotalMySpend> createState() => _TotalMySpendState();
}

class _TotalMySpendState extends State<TotalMySpend> {
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    List<String> names = userModel.userName.split(' ');

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("spend")
          .where('uid', isEqualTo: userModel.userId)
          .where('personfor', isEqualTo: names[0])
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

        return Column(
          children: [
            CardTotal(
              leadingIcon: Icons.functions,
              title: 'Total de mes dépenses',
              trailingText: '${totalValue.toStringAsFixed(2)} €',
              currentValue: totalValue,
              maxValue: 1300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureBuilder(
                    future: getFilterMySpend(userModel.userId, names[0], "Loisir"),
                    builder: (BuildContext context, AsyncSnapshot<double> filterSnapshot) {
                      if (filterSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      double filterValue = filterSnapshot.data ?? 0;

                      return Expanded(
                          child: CardTotal(
                            leadingIcon: Icons.local_activity,
                            trailingText: '${(filterValue).toStringAsFixed(2)} €',
                            currentValue: filterValue,
                            maxValue: totalValue,
                          ),
                      );
                    }
                ),
                FutureBuilder(
                    future: getFilterMySpend(userModel.userId, names[0], "Alimentaire"),
                    builder: (BuildContext context, AsyncSnapshot<double> filterSnapshot) {
                      if (filterSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      double filterValue = filterSnapshot.data ?? 0;

                      return Expanded(
                        child: CardTotal(
                          leadingIcon: Icons.food_bank,
                          trailingText: '${(filterValue).toStringAsFixed(2)} €',
                          currentValue: filterValue,
                          maxValue: totalValue,
                        ),
                      );
                    }
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureBuilder(
                    future: getFilterMySpend(userModel.userId, names[0], "Essence"),
                    builder: (BuildContext context, AsyncSnapshot<double> filterSnapshot) {
                      if (filterSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      double filterValue = filterSnapshot.data ?? 0;

                      return Expanded(
                        child: CardTotal(
                          leadingIcon: Icons.local_gas_station,
                          trailingText: '${(filterValue).toStringAsFixed(2)} €',
                          currentValue: filterValue,
                          maxValue: totalValue,
                        ),
                      );
                    }
                ),
                FutureBuilder(
                    future: getFilterMySpend(userModel.userId, names[0], "Autre"),
                    builder: (BuildContext context, AsyncSnapshot<double> filterSnapshot) {
                      if (filterSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      double filterValue = filterSnapshot.data ?? 0;

                      return Expanded(
                        child: CardTotal(
                          leadingIcon: Icons.attach_money,
                          trailingText: '${(filterValue).toStringAsFixed(2)} €',
                          currentValue: filterValue,
                          maxValue: totalValue,
                        ),
                      );
                    }
                )
              ],
            )
          ],
        );
      },
    );
  }
  Future<double> getFilterMySpend(String uid, String name, String filter) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("spend")
        .where('uid', isEqualTo: uid)
        .where('personfor', isEqualTo: "Nicolas")
        .where('category', isEqualTo: filter)
        .get();

    double total = 0.0;
    snapshot.docs.forEach((document) {
      total += double.parse(document['value']) ?? 0;
    });

    return total;
  }
}

