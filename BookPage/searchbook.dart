import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: searchbook(),
  ));
}

class searchbook extends StatefulWidget {
  const searchbook({Key? key}) : super(key: key);

  @override
  State<searchbook> createState() => _searchbookState();
}

class _searchbookState extends State<searchbook> {
  TextEditingController BookID = TextEditingController();
  Map? map;

  findBookInFirebase() async{
    if(BookID.text.isNotEmpty){
      await FirebaseFirestore.instance.collection("BooksDetail").where("BookID",isEqualTo: BookID.text).get().then((value){
        for(var i in value.docs){
          setState(() {
            map = i.data();
            print(map);
          });
        }
      });
    }
    if(map?['BookID']== BookID.text){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(
        BookID: map?['BookID'],
        AuthorName: map?['AuthorName'],
        BookLocation: map?['BookLocation'],
        BookName: map?['BookName'],
        BookPrice: map?['BookPrice'],
        BookStatus: map?['BookStatus'],
        PublishingYear: map?['PublishingYear'].toString(),


      )));
    }else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Book Not Found in Database"),
            content: Text("Book ID :${BookID.text}"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('OK'))
            ],
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Book"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/images.png",
            height: 200,
          ),
          TextField(
            controller: BookID,
            decoration: InputDecoration(
                labelText: "Search Book ID",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            findBookInFirebase();
          }, child: const Text("Search ")),
          const SizedBox(height: 20,),
          const Text("Noted : Please search by using the Book ID !!",style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  String? BookID,AuthorName,BookLocation,BookName,BookPrice ,BookStatus,PublishingYear;
  PaymentPage({this.BookID,this.AuthorName,this.BookLocation,this.BookName,this.BookPrice,this.BookStatus,this.PublishingYear});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Detail"),
      ),
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: 200,
              height: 650,
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.book),
                          Text("  Book ID: $BookID", style: const TextStyle(fontSize: 25),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.book_sharp),
                          Text("  Book Name: $BookName",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          Text("  Author Name: $AuthorName",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.location_on),
                          Text("  Book Location: $BookLocation",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.price_check),
                          Text("  Book Price: $BookPrice",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.book_online),
                          Text("  Book Status: $BookStatus",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.date_range),
                          Text("  Publishing Year: $PublishingYear",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                  ]
              )
          )
        ],

      ),
    );
  }
}