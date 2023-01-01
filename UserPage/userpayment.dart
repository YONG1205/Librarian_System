import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'searchuserpayment.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const userpayment(),
  ));
}

class userpayment extends StatefulWidget {
  const userpayment({Key? key}) : super(key: key);

  @override
  State<userpayment> createState() => _userpaymentState();
}

class _userpaymentState extends State<userpayment> {
  TextEditingController borrowerController = TextEditingController();
  TextEditingController librarianController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController idController = TextEditingController();

  final style = TextStyle( fontWeight: FontWeight.bold);
  final CollectionReference _userpayment =
  FirebaseFirestore.instance.collection('UserPayment');


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
                  controller: idController,
                  decoration: const InputDecoration(
                    labelText: 'Payment ID',
                  ),
                ),
                TextField(
                  controller: borrowerController,
                  decoration: const InputDecoration(labelText: 'Borrower Name'),
                ),
                TextField(
                  controller: librarianController,
                  decoration: const InputDecoration(
                    labelText: 'Librarian Name',
                  ),
                ),
                TextField(
                  controller: paymentController,
                  decoration: const InputDecoration(
                    labelText: 'Payment Detail',
                  ),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Payment Date',
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                  child: const Text( 'Create'),
                  onPressed: () async {
                    final String borrower = borrowerController.text;
                    final String librarian = librarianController.text;
                    final String payment = paymentController.text;
                    final String price = priceController.text;
                    final String date = dateController.text;
                    final String paymentid = idController.text;
                    int.tryParse(idController.text);
                    if (paymentid != null) {

                      await _userpayment
                          .add({"Borrower": borrower, "Librarian": librarian, "PaymentDetail":payment, "Price":price, "Date":date, "PaymentID":paymentid});
                      borrowerController.text = '';
                      librarianController.text = '';
                      paymentController.text = '';
                      priceController.text = '';
                      dateController.text = '';
                      idController.text = '';
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
    await _userpayment.doc(user).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully deleted a data")));
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async{
    if (documentSnapshot != null){
      borrowerController.text = documentSnapshot['Borrower'].toString();
      librarianController.text = documentSnapshot['Librarian'].toString();
      paymentController.text = documentSnapshot['PaymentDetail'].toString();
      priceController.text = documentSnapshot['Price'].toString();
      dateController.text = documentSnapshot['Date'].toString();
      idController.text = documentSnapshot['PaymentID'].toString();
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
                  controller: idController,
                  decoration: const InputDecoration(
                    labelText: 'Payment ID',
                  ),
                ),
                TextField(
                  controller: borrowerController,
                  decoration: const InputDecoration(labelText: 'Borrower Name'),
                ),
                TextField(
                  controller: librarianController,
                  decoration: const InputDecoration(
                    labelText: 'Librarian Name',
                  ),
                ),
                TextField(
                  controller: paymentController,
                  decoration: const InputDecoration(
                    labelText: 'Payment Detail',
                  ),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Payment Date',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String borrower = borrowerController.text;
                    final String librarian = librarianController.text;
                    final String payment = paymentController.text;
                    final String price = priceController.text;
                    final String date = dateController.text;
                    final String paymentid = idController.text;
                    int.tryParse(idController.text);
                    if (paymentid != null) {

                      await _userpayment
                          .doc(documentSnapshot!.id)
                          .update({"Borrower": borrower, "Librarian": librarian, "PaymentDetail":payment, "Price":price, "Date":date, "PaymentID":paymentid});
                      borrowerController.text = '';
                      librarianController.text = '';
                      paymentController.text = '';
                      priceController.text = '';
                      dateController.text = '';
                      idController.text = '';
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
        title: Text("User Payment Detail"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const searchpayment()));
          }, icon: Icon(Icons.search))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("UserPayment").snapshots(),
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
                      height: 270,
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
                          Text("Borrower Name : "+snapshot.data!.docs[i]['Borrower'],style: GoogleFonts.roboto(
                            textStyle: style,
                            fontSize: 15,
                          ),),
                          SizedBox(height: 10,),
                          Text("Patment ID : "+snapshot.data!.docs[i]['PaymentID'].toString()),
                          SizedBox(height: 20,),
                          Text("Librarian Name : "+snapshot.data!.docs[i]['Librarian']),
                          SizedBox(height: 20,),
                          Text("Payment Detail : "+snapshot.data!.docs[i]['PaymentDetail']),
                          SizedBox(height: 20,),
                          Text("Price : "+snapshot.data!.docs[i]['Price'].toString()),
                          SizedBox(height: 20,),
                          Text("Date : "+snapshot.data!.docs[i]['Date'].toString()),
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
