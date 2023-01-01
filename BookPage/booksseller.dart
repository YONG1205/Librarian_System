
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meow_librarian/BookPage/searchseller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const seller(),
  ));
}

class seller extends StatefulWidget {
  const seller({Key? key}) : super(key: key);

  @override
  State<seller> createState() => _sellerState();
}

class _sellerState extends State<seller> {
  TextEditingController Address = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController SellerID = TextEditingController();
  final style = const TextStyle( fontWeight: FontWeight.bold);
  final CollectionReference _seller =
  FirebaseFirestore.instance.collection('BooksSeller');

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: SellerID,
                    decoration: const InputDecoration(labelText: 'Seller ID'),
                  ),
                  TextField(
                    controller: Name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextField(
                    controller: Email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: Address,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                  ),
                  TextField(
                    controller: PhoneNumber,
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
                      final String sellerID = SellerID.text;
                      final String address = Address.text;
                      final String email = Email.text;
                      final String name = Name.text;
                      final int? phoneNumber =
                      int.tryParse(PhoneNumber.text);
                      if (PhoneNumber != null) {

                        await _seller
                            .doc(Name.text)
                            .set({"SellerID": sellerID, "Address":address, "Email":email, "Name":name, "PhoneNumber":phoneNumber});
                        SellerID.text = '';
                        Address.text = '';
                        Email.text = '';
                        Name.text = '';
                        PhoneNumber.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );

        });
  }

  Future<void> delete(String user) async{
    await _seller.doc(user).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully deleted a book")));
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async{
    if (documentSnapshot != null){
      SellerID.text = documentSnapshot['SellerID'].toString();
      Address.text = documentSnapshot['Address'].toString();
      Email.text = documentSnapshot['Email'].toString();
      Name.text = documentSnapshot['Name'].toString();
      PhoneNumber.text = documentSnapshot['PhoneNumber'].toString();
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: Name,
                    decoration: const InputDecoration(labelText: 'Donators Name'),
                  ),
                  TextField(
                    controller: SellerID,
                    decoration: const InputDecoration(
                      labelText: 'Seller ID',
                    ),
                  ),
                  TextField(
                    controller: Address,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                  ),
                  TextField(
                    controller: Email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: PhoneNumber,
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
                      final String sellerID = SellerID.text;
                      final String address = Address.text;
                      final String email = Email.text;
                      final String name = Name.text;
                      final int? phoneNumber =
                      int.tryParse(PhoneNumber.text);
                      if (PhoneNumber != null) {

                        await _seller
                            .doc(documentSnapshot!.id)
                            .update({"SellerID": sellerID, "Address":address, "Email":email, "Name":name, "PhoneNumber":phoneNumber});
                        SellerID.text = '';
                        Address.text = '';
                        Email.text = '';
                        Name.text = '';
                        PhoneNumber.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
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
        backgroundColor: Colors.yellowAccent,
        title: const Text("Books Seller"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const searchseller()));
          }, icon: const Icon(Icons.search))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("BooksSeller").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,i) {
                    final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[i];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: 200,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(4.0,4.0),
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
                          Text("Seller Name : "+snapshot.data!.docs[i]['Name'],style: GoogleFonts.roboto(
                            textStyle: style,
                            fontSize: 15,
                          ),),

                          const SizedBox(height: 20,),
                          Text("Seller ID : "+snapshot.data!.docs[i]['SellerID']),
                          const SizedBox(height: 20,),
                          Text("Address : "+snapshot.data!.docs[i]['Address']),
                          const SizedBox(height: 20,),
                          Text("Email : "+snapshot.data!.docs[i]['Email']),
                          const SizedBox(height: 20,),
                          Text("Phone Number : "+snapshot.data!.docs[i]['PhoneNumber'].toString()),
                        ],
                      ),
                    );
                  });
            }else{
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }
}
