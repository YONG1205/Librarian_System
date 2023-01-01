import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const suggestion(),
  ));
}

class suggestion extends StatefulWidget {
  const suggestion({Key? key}) : super(key: key);

  @override
  State<suggestion> createState() => _suggestionState();
}

class _suggestionState extends State<suggestion> {
  final style = TextStyle( fontWeight: FontWeight.bold);
  final CollectionReference _usersuggest =
  FirebaseFirestore.instance.collection('UserSuggestionBook');

  Future<void> delete(String user) async{
    await _usersuggest.doc(user).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully deleted a data")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("User Suggestion Book"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("UserSuggestionBook").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,i) {
                    final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[i];
                    return Container(
                      padding: EdgeInsets.all(10),
                      width: 200,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(4.0,4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0,-4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: () => delete(documentSnapshot.id), icon: const Icon(Icons.delete),color: Colors.red,),

                            ],
                          ),
                          Text("Book Name : "+snapshot.data!.docs[i]['BookName'],style: GoogleFonts.roboto(
                            textStyle: style,
                            fontSize: 15,
                          ),),

                          SizedBox(height: 20,),
                          Text("User Name : "+snapshot.data!.docs[i]['UserName']),
                          SizedBox(height: 20,),
                          Text("Suggestion Book ID: "+snapshot.data!.docs[i]['SuggestionBookID']),
                          SizedBox(height: 20,),
                          Text("Price : "+snapshot.data!.docs[i]['Price'].toString()),
                          SizedBox(height: 20,),
                          Text("Reason : "+snapshot.data!.docs[i]['Reason'].toString()),
                        ],
                      ),
                    );
                  });
            }else{
              return CircularProgressIndicator();
            }
          }
      ),
    );
  }
}
