import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/user_model.dart';

class MySpend extends StatefulWidget {
  const MySpend({super.key});

  @override
  State<MySpend> createState() => _MySpendState();
}

class _MySpendState extends State<MySpend> {
  @override
  Widget build(BuildContext context) {

    final userModel = Provider.of<UserModel>(context);
    List<String> names = userModel.userName.split(' ');

    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("spend")
            .where('uid', isEqualTo: userModel.userId)
            //.where('personfor', whereIn: [names[0], 'Les deux'])
            .where('personfor', isEqualTo: names[0])
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

          return Column(
            children: [
              /*Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                child: OutlinedButton(
                    onPressed: () {

                    },
                    child: const Text("Ajouter une dépense"),
                ),
              ),*/
              Expanded(
                child: ListView.builder(
                  itemCount: spends.length,
                  itemBuilder: (context, index) {

                    final spend = spends[index];
                    final category = spend['category'];
                    final comment = spend['comment'].toString().toUpperCase();
                    //final personfor = spend['personfor'].toString();
                    final tag = spend['tag'].toString().toUpperCase();
                    var value = double.parse(spend['value'].toString());

                    // Diviser la valeur par 2 si personfor est égal à "Les deux"
                    /*if (personfor == 'Les deux') {
                      value = value / 2;
                    }*/

                    return Card(
                      child: ListTile(
                        leading: Text("${value.toStringAsFixed(2)} €", style: GoogleFonts.poppins()),
                        title: Text('$category', style: GoogleFonts.poppins()),
                        subtitle: Text('$comment, $tag', style: GoogleFonts.poppins()),
                        trailing: const Icon(Icons.info),
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
    /*Column(
      children: [
        const Text("Mes dépenses"),
        Consumer<UserModel>(
          builder: (context, userModel, child) {
          return Text("Utilisateur: ${userModel.userId}");
        },
        )
      ],
    );*/
  }
}