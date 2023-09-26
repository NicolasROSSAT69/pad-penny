import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/user_model.dart';

class AddSpendPage extends StatefulWidget {
  const AddSpendPage({super.key});

  @override
  State<AddSpendPage> createState() => _AddSpendPageState();
}

class _AddSpendPageState extends State<AddSpendPage> {

  //pour le validator des champs
  final _formKey = GlobalKey<FormState>();

  final valueController = TextEditingController();
  final commentController = TextEditingController();
  String selectedCategory = 'Autre';
  String selectedPersonFor = 'Les deux';
  String selectedTag = 'Ponctuel';
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    valueController.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userModel = Provider.of<UserModel>(context);
    List<String> names = userModel.userName.split(' ');

    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
          key: _formKey, // Pour le validator
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Montant',
                        labelStyle: GoogleFonts.poppins(),
                        hintText: 'Entre le montant de la dépense',
                        hintStyle: GoogleFonts.poppins(),
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Tu dois compléter ce texte";
                      }
                      return null;
                    },
                    controller: valueController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Commentaire',
                        labelStyle: GoogleFonts.poppins(),
                        hintText: 'Entre le commentaire de la dépense',
                        hintStyle: GoogleFonts.poppins(),
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Tu dois compléter ce texte";
                      }
                      return null;
                    },
                    controller: commentController,
                  ),
                ),
                //SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(value: 'Essence', child: Text("Essence", style: GoogleFonts.poppins())),
                        DropdownMenuItem(value: 'Alimentaire', child: Text("Alimentaire", style: GoogleFonts.poppins())),
                        DropdownMenuItem(value: 'Loisir', child: Text("Loisir", style: GoogleFonts.poppins())),
                        DropdownMenuItem(value: 'Autre', child: Text("Autre", style: GoogleFonts.poppins()))
                      ],
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Type',
                          labelStyle: GoogleFonts.poppins()
                      ),
                      value: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      }
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(value: names[0], child: Text(names[0], style: GoogleFonts.poppins())),
                        DropdownMenuItem(value: 'Les deux', child: Text("Les deux", style: GoogleFonts.poppins()))
                      ],
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Pour',
                          labelStyle: GoogleFonts.poppins()
                      ),
                      value: selectedPersonFor,
                      onChanged: (value) {
                        setState(() {
                          selectedPersonFor = value!;
                        });
                      }
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(value: 'Tous les mois', child: Text("Tous les mois", style: GoogleFonts.poppins())),
                        DropdownMenuItem(value: 'Ponctuel', child: Text("Ponctuel", style: GoogleFonts.poppins()))
                      ],
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Type de dépense',
                          labelStyle: GoogleFonts.poppins()
                      ),
                      value: selectedTag,
                      onChanged: (value) {
                        setState(() {
                          selectedTag = value!;
                        });
                      }
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: DateTimeFormField(
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.black45),
                      errorStyle: const TextStyle(color: Colors.redAccent),
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.event_note),
                      labelText: 'Choisir une date',
                      labelStyle: GoogleFonts.poppins()
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        // Pour le validator
                        if (_formKey.currentState!.validate()){

                          //Récupérer la valeur des champs
                          final value = valueController.text;
                          final comment = commentController.text;

                          //Afficher un message temporaire
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Ajout en cours..."))
                          );
                          //Pour fermer le clavier
                          FocusScope.of(context).requestFocus(FocusNode());

                          //Ajout dans la BDD
                          CollectionReference eventsRef = FirebaseFirestore.instance.collection("spend");
                          eventsRef.add({
                            'value': value,
                            'comment': comment,
                            'category': selectedCategory,
                            'personfor': selectedPersonFor,
                            'tag': selectedTag,
                            'uid': userModel.userId,
                            'date': selectedDate,
                            'payfor': userModel.userName.split(" ")[0]
                          });
                          selectedDate = DateTime.now();
                          selectedCategory = "Autre";
                          commentController.text = "";
                          valueController.text = "";
                          selectedTag = 'Ponctuel';

                          setState(() {}); // rafraîchir la vue
                        }
                      },
                      child: Text("Ajouter", style: GoogleFonts.poppins())
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

