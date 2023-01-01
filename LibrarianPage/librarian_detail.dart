import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meow_librarian/helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class librariandetail extends StatefulWidget {


  @override
  State<librariandetail> createState() => _librariandetailState();
}

class _librariandetailState extends State<librariandetail> {
  final currentUser = FirebaseAuth.instance;
  final CollectionReference _librarian =
  FirebaseFirestore.instance.collection('Librarian');
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> update([DocumentSnapshot? documentSnapshot]) async{
    if (documentSnapshot != null){
      nameController.text = documentSnapshot['Librarian'].toString();
      addressController.text = documentSnapshot['Address'].toString();
      phoneController.text = documentSnapshot['PhoneNumber'].toString();
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
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
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
                    final String address = addressController.text;
                    final int? phonenumber =
                    int.tryParse(phoneController.text);
                    if (phonenumber != null) {

                      await _librarian
                          .doc(documentSnapshot!.id)
                          .update({"Librarian": name, "Address":address, "PhoneNumber":phonenumber});
                      nameController.text = '';
                      emailController.text = '';
                      addressController.text = '';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Librarian Profile"),
        actions: [
          IconButton(onPressed: (){
            AuthService authService = AuthService();
            authService.logout(context);
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Librarian")
            .where("uid", isEqualTo: currentUser.currentUser!.uid)
            .snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, i){
                final DocumentSnapshot documentSnapshot =
                snapshot.data!.docs[i];
                var data = snapshot.data!.docs[i];
            return ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://people.com/thmb/27HP6m5b0tgdxNLVZ13dPzbxXds=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(999x0:1001x2):format(webp)/zappa-the-cat-9-b65e4c7056694231bfacdbcab1355bab.jpg"
                                )
                            )
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 10,),
                 Center(
                  child: Text(
                    data['Librarian'],
                    style: const TextStyle(
                      color: Colors.black,fontSize: 24, fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: const Text(
                    "Personal Detail",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.yellow
                            ),
                            child: const Icon(FontAwesomeIcons.faceGrinStars, color: Colors.black,),
                          ),
                          title: Text(data['Librarian'], style: Theme.of(context).textTheme.bodyText1,),
                        ),
                        const Divider(
                          height: 0.6,
                          color: Colors.black87,
                        ),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.yellow
                            ),
                            child: const Icon(Icons.email_outlined, color: Colors.black,),
                          ),
                          title: Text(data['Email'], style: Theme.of(context).textTheme.bodyText1,),
                        ),
                        const Divider(
                          height: 0.6,
                          color: Colors.black87,
                        ),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black
                            ),
                            child: const Icon(Icons.place, color: Colors.yellow,),
                          ),
                          title: Text(data['Address'], style: Theme.of(context).textTheme.bodyText1,),
                        ),
                        const Divider(
                          height: 0.6,
                          color: Colors.black87,
                        ),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black
                            ),
                            child: const Icon(Icons.phone, color: Colors.yellow,),
                          ),
                          title: Text(data['PhoneNumber'].toString(), style: Theme.of(context).textTheme.bodyText1,),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: const Text(
                    "Setting",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ListTile(
                  onTap: ()=> update(documentSnapshot),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black
                    ),
                    child: const Icon(Icons.update, color: Colors.yellow,),
                  ),
                  title: Text("Update Profile", style: Theme.of(context).textTheme.bodyText1,),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: const Icon(FontAwesomeIcons.angleRight, size: 18.0,color: Colors.grey,),
                  ),
                ),

              ],
            );
          });
        }else{
          return const CircularProgressIndicator();
        }
      })

    );
  }
}

