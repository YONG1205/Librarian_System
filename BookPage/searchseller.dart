import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: searchseller(),
  ));
}

class searchseller extends StatefulWidget {
  const searchseller({Key? key}) : super(key: key);

  @override
  State<searchseller> createState() => _searchsellerState();
}

class _searchsellerState extends State<searchseller> {
  TextEditingController sellerID = TextEditingController();
  Map? map;

  findSellerInFirebase() async{
    if(sellerID.text.isNotEmpty){
      await FirebaseFirestore.instance.collection("BooksSeller").where("SellerID",isEqualTo: sellerID.text).get().then((value){
        for(var i in value.docs){
          setState(() {
            map = i.data();
            print(map);
          });
        }
      });
    }
    if(map?['SellerID']== sellerID.text){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(
        SellerID: map?['SellerID'],
        Address: map?['Address'],
        Email: map?['Email'],
        Name: map?['Name'],
        PhoneNumber: map?['PhoneNumber'].toString(),



      )));
    }else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Seller Not Found in Database"),
            content: Text("Seller ID :${sellerID.text}"),
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
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Search Seller"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/images.png",
            height: 200,
          ),
          TextField(
            controller: sellerID,
            decoration: InputDecoration(
                labelText: "Search Seller",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            findSellerInFirebase();
          }, child: const Text("Search ")),
          const SizedBox(height: 20,),
          const Text("Noted : Please search by using the Seller ID !!",style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  String? SellerID,Address,Email,Name ,PhoneNumber;
  PaymentPage({this.SellerID,this.Address,this.Email,this.Name,this.PhoneNumber});
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
                          const Icon(Icons.person),
                          Text("  Seller ID: $SellerID", style: const TextStyle(fontSize: 25),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.place),
                          Text("  Address: $Address",style: const TextStyle(fontSize: 20),),
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
