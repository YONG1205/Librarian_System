import 'searchuser.dart';
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
    home: const userdata(),
  ));
}


class userdata extends StatefulWidget {
  const userdata({Key? key}) : super(key: key);

  @override
  State<userdata> createState() => _userdataState();
}

class _userdataState extends State<userdata> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final style = TextStyle( fontWeight: FontWeight.bold);
  final CollectionReference _user =
  FirebaseFirestore.instance.collection('User');



  Future<void> create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Create'),
                  onPressed: () async {
                    final String name = nameController.text;
                    final String email = emailController.text;
                    final String password = passwordController.text;
                    final int? phonenumber =
                    int.tryParse(phoneController.text);
                    if (phonenumber != null) {

                      await _user
                          .add({"name": name, "email": email, "password":password, "phonenumber":phonenumber});
                      nameController.text = '';
                      emailController.text = '';
                      passwordController.text = '';
                      phoneController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );

        });
  }

  Future<void> delete(String user) async{
    await _user.doc(user).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully deleted a user")));
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async{
    if (documentSnapshot != null){
      nameController.text = documentSnapshot['name'].toString();
      emailController.text = documentSnapshot['email'].toString();
      passwordController.text = documentSnapshot['password'].toString();
      phoneController.text = documentSnapshot['phonenumber'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String name = nameController.text;
                    final String email = emailController.text;
                    final String password = passwordController.text;
                    final int? phonenumber =
                    int.tryParse(phoneController.text);
                    if (phonenumber != null) {

                      await _user
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "email": email, "password":password, "phonenumber":phonenumber});
                      nameController.text = '';
                      emailController.text = '';
                      passwordController.text = '';
                      phoneController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => create(),
          child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("User Data"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const searchuser()));
          }, icon: Icon(Icons.search))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("User").snapshots(),
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
                height: 200,
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
                        IconButton(onPressed: () => update(documentSnapshot), icon: const Icon(Icons.edit),color: Colors.blue,),
                      ],
                    ),
                    Text("Name : "+snapshot.data!.docs[i]['name'],style: GoogleFonts.roboto(
                      textStyle: style,
                      fontSize: 15,
                    ),),

                    SizedBox(height: 20,),
                    Text("Email : "+snapshot.data!.docs[i]['email']),
                    SizedBox(height: 20,),
                    Text("Password : "+snapshot.data!.docs[i]['password']),
                    SizedBox(height: 20,),
                    Text("Phone Number : "+snapshot.data!.docs[i]['phonenumber'].toString()),
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
