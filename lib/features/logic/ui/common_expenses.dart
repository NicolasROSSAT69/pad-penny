import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/user_model.dart';

class CommonExpenses extends StatefulWidget {
  const CommonExpenses({super.key});

  @override
  State<CommonExpenses> createState() => _CommonExpensesState();
}

class _CommonExpensesState extends State<CommonExpenses> {
  @override
  Widget build(BuildContext context) {

    final userModel = Provider.of<UserModel>(context);
    List<String> names = userModel.userName.split(' ');

    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("spend")
        //.where('personfor', whereIn: [names[0], 'Les deux'])
            .where('personfor', isEqualTo: 'Les deux')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            print("Erreur: ${snapshot.error}");
          }

          if (!snapshot.hasData) {
            return Text("Aucune dépense", style: GoogleFonts.poppins());
          }

          List<dynamic> spends = [];
          snapshot.data!.docs.forEach((element) {
            spends.add(element);
          });

          double totalValue = 0.0;

          for (var spend in spends) {
            totalValue += double.parse(spend['value'].toString());
          }

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 20),
                child: Text("Total : $totalValue €", style: GoogleFonts.poppins())
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: spends.length,
                  itemBuilder: (context, index) {

                    final spend = spends[index];
                    final category = spend['category'];
                    final comment = spend['comment'].toString().toUpperCase();
                    final tag = spend['tag'].toString().toUpperCase();
                    var value = double.parse(spend['value'].toString());

                    return Card(
                      child: ListTile(
                        leading: Text("${value.toStringAsFixed(2)} €", style: GoogleFonts.poppins()),
                        title: Text('$category', style: GoogleFonts.poppins()),
                        subtitle: Text('$comment, $tag, payé par ${spend['payfor']}', style: GoogleFonts.poppins()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Supprimer',
                          onPressed: () async {
                            final docId = spends[index].id;
                            await FirebaseFirestore.instance.collection('spend').doc(docId).delete();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Dépense supprimée")),
                            );
                            setState(() {}); // rafraîchir la vue
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
