import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: searchlibrarypayment(),
  ));
}


class searchlibrarypayment extends StatefulWidget {
  const searchlibrarypayment({Key? key}) : super(key: key);

  @override
  State<searchlibrarypayment> createState() => _searchlibrarypaymentState();
}

class _searchlibrarypaymentState extends State<searchlibrarypayment> {
  TextEditingController ID = TextEditingController();
  Map? map;

  findUserInFirebase() async{
    if(ID.text.isNotEmpty){
      await FirebaseFirestore.instance.collection("LibraryPayment").where("PaymentID",isEqualTo: ID.text).get().then((value){
        for(var i in value.docs){
          setState(() {
            map = i.data();
            print(map);
          });
        }
      });
    }
    if(map?['PaymentID']== ID.text){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(
        BookID: map?['BookID'],
        BookQuantity: map?['BookQuantity'],
        Date: map?['Date'],
        LibrarianID: map?['LibrarianID'],
        PaymentDetail: map?['PaymentDetail'].toString(),
        PaymentID: map?['PaymentID'],
        Price: map?['Price'],
        SellerID: map?['SellerID'],

      )));
    }else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Data Not Found in Database"),
            content: Text("Payment ID :${ID.text}"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('OK'))
            ],
          )
      );

      // setState(() {
      //   text = "User not found :${name.text}";
      // });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Library Payment"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/images.png",
            height: 200,
          ),
          TextField(
            controller: ID,
            decoration: InputDecoration(
                labelText: "Search Payment ID",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            findUserInFirebase();
          }, child: const Text("Search Payment ")),
          const SizedBox(height: 20,),
          const Text("Noted : Please search by using the Payment ID !!",style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  String? BookID,BookQuantity, Date, LibrarianID,PaymentDetail, PaymentID,Price,SellerID;
  PaymentPage({this.BookID,this.BookQuantity,this.Date,this.LibrarianID,this.PaymentDetail,this.PaymentID,this.Price,this.SellerID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Detail"),
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
                          const Icon(Icons.account_circle_rounded),
                          Text("  Payment ID: $PaymentID", style: const TextStyle(fontSize: 25),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.account_box),
                          Text("  Librarian ID: $LibrarianID",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.book),
                          Text("  Book ID: $BookID",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.sell),
                          Text("  Seller ID: $SellerID",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.payments),
                          Text("  Payment Detail: $PaymentDetail",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.library_books_sharp),
                          Text("  Book Quantity: $BookQuantity",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.date_range),
                          Text("  Date: $Date",style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.price_change_rounded),
                          Text("  Price: $Price",style: const TextStyle(fontSize: 20),),
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