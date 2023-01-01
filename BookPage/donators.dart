import 'package:meow_librarian/BookPage/searchdonators.dart';
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
    home: const donators(),
  ));
}

class donators extends StatefulWidget {
  const donators({Key? key}) : super(key: key);

  @override
  State<donators> createState() => _donatorsState();
}

class _donatorsState extends State<donators> {
  TextEditingController BooksQuantity = TextEditingController();
  TextEditingController BookID = TextEditingController();
  TextEditingController DonatorsID = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();

  final style = const TextStyle( fontWeight: FontWeight.bold);
  final CollectionReference _donators =
  FirebaseFirestore.instance.collection('BooksDonators');

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
                    controller: Name,
                    decoration: const InputDecoration(labelText: 'Donators Name'),
                  ),
                  TextField(
                    controller: BookID,
                    decoration: const InputDecoration(
                      labelText: 'Book ID',
                    ),
                  ),
                  TextField(
                    controller: DonatorsID,
                    decoration: const InputDecoration(
                      labelText: 'Donators ID',
                    ),
                  ),
                  TextField(
                    controller: BooksQuantity,
                    decoration: const InputDecoration(
                      labelText: 'Books Quantity',
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
                    child: const Text( 'Create'),
                    onPressed: () async {
                      final String booksQuantity = BooksQuantity.text;
                      final String bookID = BookID.text;
                      final String donatorsID = DonatorsID.text;
                      final String email = Email.text;
                      final String name = Name.text;
                      final int? phoneNumber =
                      int.tryParse(PhoneNumber.text);
                      if (PhoneNumber != null) {

                        await _donators
                            .add({"BooksQuantity": booksQuantity, "BookID": bookID, "DonatorsID":donatorsID, "Email":email, "Name":name, "PhoneNumber":phoneNumber});
                        BooksQuantity.text = '';
                        BookID.text = '';
                        DonatorsID.text = '';
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
    await _donators.doc(user).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully deleted a book")));
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async{
    if (documentSnapshot != null){
      BooksQuantity.text = documentSnapshot['BooksQuantity'].toString();
      BookID.text = documentSnapshot['BookID'].toString();
      DonatorsID.text = documentSnapshot['DonatorsID'].toString();
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
                    controller: BookID,
                    decoration: const InputDecoration(
                      labelText: 'Book ID',
                    ),
                  ),
                  TextField(
                    controller: DonatorsID,
                    decoration: const InputDecoration(
                      labelText: 'Donators ID',
                    ),
                  ),
                  TextField(
                    controller: BooksQuantity,
                    decoration: const InputDecoration(
                      labelText: 'Books Quantity',
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
                      final String booksQuantity = BooksQuantity.text;
                      final String bookID = BookID.text;
                      final String donatorsID = DonatorsID.text;
                      final String email = Email.text;
                      final String name = Name.text;
                      final int? phoneNumber =
                      int.tryParse(PhoneNumber.text);
                      if (PhoneNumber != null) {

                        await _donators
                            .doc(documentSnapshot!.id)
                            .update({"BooksQuantity": booksQuantity, "BookID": bookID, "DonatorsID":donatorsID, "Email":email, "Name":name, "PhoneNumber":phoneNumber});
                        BooksQuantity.text = '';
                        BookID.text = '';
                        DonatorsID.text = '';
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
        title: const Text("Books Donators"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const searchdonators()));
          }, icon: const Icon(Icons.search))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("BooksDonators").snapshots(),
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
                          Text("Donators Name : "+snapshot.data!.docs[i]['Name'],style: GoogleFonts.roboto(
                            textStyle: style,
                            fontSize: 15,
                          ),),

                          const SizedBox(height: 20,),
                          Text("Book ID : "+snapshot.data!.docs[i]['BookID']),
                          const SizedBox(height: 20,),
                          Text("Donators ID : "+snapshot.data!.docs[i]['DonatorsID']),
                          const SizedBox(height: 20,),
                          Text("Books Quantity : "+snapshot.data!.docs[i]['BooksQuantity']),
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
