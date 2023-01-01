import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: searchpayment(),
  ));
}

class searchpayment extends StatefulWidget {
  const searchpayment({Key? key}) : super(key: key);

  @override
  State<searchpayment> createState() => _searchpaymentState();
}

class _searchpaymentState extends State<searchpayment> {
  TextEditingController ID = TextEditingController();
  Map? map;

  findUserInFirebase() async{
    if(ID.text.isNotEmpty){
      await FirebaseFirestore.instance.collection("UserPayment").where("PaymentID",isEqualTo: ID.text).get().then((value){
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
        Borrower: map?['Borrower'],
        Librarian: map?['Librarian'],
        Date: map?['Date'],
        PaymentDetail: map?['PaymentDetail'],
        PaymentID: map?['PaymentID'].toString(),
        Price: map?['Price'],

      )));
    }else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Data Not Found in Database"),
            content: Text("Payment ID :${ID.text}"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('OK'))
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
        title: Text("Search Payment ID"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/asd.png",
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
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            findUserInFirebase();
          }, child: Text("Search Payment ")),
          SizedBox(height: 20,),
          Text("Noted : Please search by using the Payment ID !!",style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  String? Borrower,Date, Librarian, PaymentDetail,PaymentID, Price;
  PaymentPage({this.Borrower,this.Date,this.Librarian,this.PaymentDetail,this.PaymentID,this.Price});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Detail"),
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              width: 200,
              height: 650,
              decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/sdf.jpg')
                ),
                color: Colors.amberAccent,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_rounded),
                          Text("  Borrower: "+Borrower.toString(), style: TextStyle(fontSize: 25),),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.account_box),
                          Text("  Librarian: "+Librarian.toString(),style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.payment),
                          Text("  Payment ID: "+PaymentID.toString(),style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.payments),
                          Text("  Payment Detail: "+PaymentDetail.toString(),style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.price_change_rounded),
                          Text("  Price: "+Price.toString(),style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.date_range),
                          Text("  Payment Date: "+Date.toString(),style: TextStyle(fontSize: 20),),
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