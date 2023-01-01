import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: searchdonators(),
  ));
}

class searchdonators extends StatefulWidget {
  const searchdonators({Key? key}) : super(key: key);

  @override
  State<searchdonators> createState() => _searchdonatorsState();
}

class _searchdonatorsState extends State<searchdonators> {

  TextEditingController donatorsID = TextEditingController();
  Map? map;

  findDonatorsInFirebase() async{
    if(donatorsID.text.isNotEmpty){
      await FirebaseFirestore.instance.collection("BooksDonators").where("DonatorsID",isEqualTo: donatorsID.text).get().then((value){
        for(var i in value.docs){
          setState(() {
            map = i.data();
            print(map);
          });
        }
      });
    }
    if(map?['DonatorsID']== donatorsID.text){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(
        BookID: map?['BookID'],
        BooksQuantity: map?['BooksQuantity'],
        DonatorsID: map?['DonatorsID'],
        Email: map?['Email'],
        Name: map?['Name'],
        PhoneNumber: map?['PhoneNumber'].toString(),



      )));
    }else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Data Not Found in Database"),
            content: Text("Donators ID :${donatorsID.text}"),
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
        title: const Text("Search Donators"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/images.png",
            height: 200,
          ),
          TextField(
            controller: donatorsID,
            decoration: InputDecoration(
                labelText: "Search Donators",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            findDonatorsInFirebase();
          }, child: const Text("Search ")),
          const SizedBox(height: 20,),
          const Text("Noted : Please search by using the Donators ID !!",style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  String? BookID,BooksQuantity,DonatorsID,Email,Name ,PhoneNumber;
  PaymentPage({this.BookID,this.BooksQuantity,this.DonatorsID,this.Email,this.Name,this.PhoneNumber});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donators Detail"),
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
                          const Icon(Icons.done_all),
                          Text("  Donators ID: $DonatorsID",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.numbers),
                          Text("  Books Quantity: $BooksQuantity",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.email),
                          Text("  Email: $Email",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          Text("  Name: $Name",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.phone),
                          Text("  Phone Number: $PhoneNumber",style: const TextStyle(fontSize: 20),),
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