import 'searchbook.dart';
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
    home: const booksdetail(),
  ));
}

class booksdetail extends StatefulWidget {
  const booksdetail({Key? key}) : super(key: key);

  @override
  State<booksdetail> createState() => _booksdetailState();
}

class _booksdetailState extends State<booksdetail> {
  TextEditingController AuthorName = TextEditingController();
  TextEditingController BookID = TextEditingController();
  TextEditingController BookLocation = TextEditingController();
  TextEditingController BookName = TextEditingController();
  TextEditingController BookPrice = TextEditingController();
  TextEditingController BookStatus = TextEditingController();
  TextEditingController PublishingYear = TextEditingController();

  final style = const TextStyle( fontWeight: FontWeight.bold);
  final CollectionReference _book =
  FirebaseFirestore.instance.collection('BooksDetail');

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
                    controller: AuthorName,
                    decoration: const InputDecoration(labelText: 'Author Name'),
                  ),
                  TextField(
                    controller: BookID,
                    decoration: const InputDecoration(
                      labelText: 'Book ID',
                    ),
                  ),
                  TextField(
                    controller: BookLocation,
                    decoration: const InputDecoration(
                      labelText: 'Book Location',
                    ),
                  ),
                  TextField(
                    controller: BookName,
                    decoration: const InputDecoration(
                      labelText: 'Book Name',
                    ),
                  ),
                  TextField(
                    controller: BookPrice,
                    decoration: const InputDecoration(
                      labelText: 'Book Price',
                    ),
                  ),
                  TextField(
                    controller: BookStatus,
                    decoration: const InputDecoration(
                      labelText: 'Book Status',
                    ),
                  ),
                  TextField(
                    controller: PublishingYear,
                    decoration: const InputDecoration(
                      labelText: 'Publishing Year',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text( 'Create'),
                    onPressed: () async {
                      final String authorName = AuthorName.text;
                      final String bookID = BookID.text;
                      final String bookLocation = BookLocation.text;
                      final String bookName = BookName.text;
                      final String bookPrice = BookPrice.text;
                      final String bookStatus = BookStatus.text;
                      final int? publishingYear =
                      int.tryParse(PublishingYear.text);
                      if (PublishingYear != null) {

                        await _book
                            .add({"AuthorName": authorName, "BookID": bookID, "BookLocation":bookLocation, "BookName":bookName, "BookPrice":bookPrice, "BookStatus":bookStatus, "PublishingYear":publishingYear});
                        AuthorName.text = '';
                        BookID.text = '';
                        BookLocation.text = '';
                        BookName.text = '';
                        BookPrice.text = '';
                        BookStatus.text = '';
                        PublishingYear.text = '';
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
    await _book.doc(user).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully deleted a book")));
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async{
    if (documentSnapshot != null){
      AuthorName.text = documentSnapshot['AuthorName'].toString();
      BookID.text = documentSnapshot['BookID'].toString();
      BookLocation.text = documentSnapshot['BookLocation'].toString();
      BookName.text = documentSnapshot['BookName'].toString();
      BookPrice.text = documentSnapshot['BookPrice'].toString();
      BookStatus.text = documentSnapshot['BookStatus'].toString();
      PublishingYear.text = documentSnapshot['PublishingYear'].toString();
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
                    controller: AuthorName,
                    decoration: const InputDecoration(labelText: 'Author Name'),
                  ),
                  TextField(
                    controller: BookID,
                    decoration: const InputDecoration(
                      labelText: 'Book ID',
                    ),
                  ),
                  TextField(
                    controller: BookLocation,
                    decoration: const InputDecoration(
                      labelText: 'Book Location',
                    ),
                  ),
                  TextField(
                    controller: BookName,
                    decoration: const InputDecoration(
                      labelText: 'Book Name',
                    ),
                  ),
                  TextField(
                    controller: BookPrice,
                    decoration: const InputDecoration(
                      labelText: 'Book Price',
                    ),
                  ),
                  TextField(
                    controller: BookStatus,
                    decoration: const InputDecoration(
                      labelText: 'Book Status',
                    ),
                  ),
                  TextField(
                    controller: PublishingYear,
                    decoration: const InputDecoration(
                      labelText: 'Publishing Year',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text( 'Update'),
                    onPressed: () async {
                      final String authorName = AuthorName.text;
                      final String bookID = BookID.text;
                      final String bookLocation = BookLocation.text;
                      final String bookName = BookName.text;
                      final String bookPrice = BookPrice.text;
                      final String bookStatus = BookStatus.text;
                      final int? publishingYear =
                      int.tryParse(PublishingYear.text);
                      if (PublishingYear != null) {

                        await _book
                            .doc(documentSnapshot!.id)
                            .update({"AuthorName": authorName, "BookID": bookID, "BookLocation":bookLocation, "BookName":bookName, "BookPrice":bookPrice, "BookStatus":bookStatus, "PublishingYear":publishingYear});
                        AuthorName.text = '';
                        BookID.text = '';
                        BookLocation.text = '';
                        BookName.text = '';
                        BookPrice.text = '';
                        BookStatus.text = '';
                        PublishingYear.text = '';
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
        title: const Text("Books Detail"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const searchbook()));
          }, icon: const Icon(Icons.search))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("BooksDetail").snapshots(),
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
                          Text("Book Name : "+snapshot.data!.docs[i]['BookName'],style: GoogleFonts.roboto(
                            textStyle: style,
                            fontSize: 15,
                          ),),

                          const SizedBox(height: 20,),
                          Text("Book ID : "+snapshot.data!.docs[i]['BookID']),
                          const SizedBox(height: 20,),
                          Text("Author Name : "+snapshot.data!.docs[i]['AuthorName']),
                          const SizedBox(height: 20,),
                          Text("Book Location : "+snapshot.data!.docs[i]['BookLocation']),
                          const SizedBox(height: 20,),
                          Text("Book Price : "+snapshot.data!.docs[i]['BookPrice']),
                          const SizedBox(height: 20,),
                          Text("Book Status : "+snapshot.data!.docs[i]['BookStatus']),
                          const SizedBox(height: 20,),
                          Text("Publishing Year : "+snapshot.data!.docs[i]['PublishingYear'].toString()),

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
