import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meow_librarian/UserPage/searchuserpayment.dart';
import 'searchlp.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const librarypayment(),
  ));
}

class librarypayment extends StatefulWidget {
  const librarypayment({Key? key}) : super(key: key);

  @override
  State<librarypayment> createState() => _librarypaymentState();
}

class _librarypaymentState extends State<librarypayment> {
  TextEditingController bookidController = TextEditingController();
  TextEditingController bookqController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController librarianidController = TextEditingController();
  TextEditingController paymentdetail = TextEditingController();
  TextEditingController paymentid = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController sellerid = TextEditingController();

  final style = TextStyle( fontWeight: FontWeight.bold);
  final CollectionReference _librarypayment =
  FirebaseFirestore.instance.collection('LibraryPayment');


  Future<void> create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
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
                    controller: paymentid,
                    decoration: const InputDecoration(
                      labelText: 'Payment ID',
                    ),
                  ),
                  TextField(
                    controller: bookidController,
                    decoration: const InputDecoration(labelText: 'Book ID'),
                  ),
                  TextField(
                    controller: sellerid,
                    decoration: const InputDecoration(
                      labelText: 'Seller ID',
                    ),
                  ),
                  TextField(
                    controller: librarianidController,
                    decoration: const InputDecoration(
                      labelText: 'Librarian ID',
                    ),
                  ),
                  TextField(
                    controller: bookqController,
                    decoration: const InputDecoration(
                      labelText: 'Book Quantity',
                    ),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Payment Date',
                    ),
                  ),
                  TextField(
                    controller: price,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),
                  TextField(
                    controller: paymentdetail,
                    decoration: const InputDecoration(
                      labelText: 'Payment Detail',
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                    child: const Text( 'Create'),
                    onPressed: () async {
                      final String BookID = bookidController.text;
                      final String Date = dateController.text;
                      final String LibrarianID = librarianidController.text;
                      final String PaymentDetail = paymentdetail.text;
                      final String PaymentID = paymentid.text;
                      final String Price = price.text;
                      final String SellerID = sellerid.text;
                      final int? BookQuantity =
                      int.tryParse(bookqController.text);
                      if (bookqController != null) {

                        await _librarypayment
                            .add({"BookID": BookID, "BookQuantity": BookQuantity, "Date":Date, "LibrarianID":LibrarianID,
                          "PaymentDetail":PaymentDetail, "PaymentID":PaymentID,"Price":Price,"SellerID":SellerID,});
                        bookidController.text = '';
                        librarianidController.text = '';
                        paymentdetail.text = '';
                        paymentid.text = '';
                        dateController.text = '';
                        price.text = '';
                        sellerid.text ='';
                        bookqController.text = '';
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
    await _librarypayment.doc(user).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully deleted a data")));
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async{
    if (documentSnapshot != null){
      bookidController.text = documentSnapshot['BookID'].toString();
      librarianidController.text = documentSnapshot['LibrarianID'].toString();
      paymentdetail.text = documentSnapshot['PaymentDetail'].toString();
      paymentid.text = documentSnapshot['PaymentID'].toString();
      dateController.text = documentSnapshot['Date'].toString();
      price.text = documentSnapshot['Price'].toString();
      sellerid.text = documentSnapshot['SellerID'].toString();
      bookqController.text = documentSnapshot['BookQuantity'].toString();
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
                    controller: paymentid,
                    decoration: const InputDecoration(
                      labelText: 'Payment ID',
                    ),
                  ),
                  TextField(
                    controller: bookidController,
                    decoration: const InputDecoration(labelText: 'Book ID'),
                  ),
                  TextField(
                    controller: sellerid,
                    decoration: const InputDecoration(
                      labelText: 'Seller ID',
                    ),
                  ),
                  TextField(
                    controller: librarianidController,
                    decoration: const InputDecoration(
                      labelText: 'Librarian ID',
                    ),
                  ),
                  TextField(
                    controller: bookqController,
                    decoration: const InputDecoration(
                      labelText: 'Book Quantity',
                    ),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Payment Date',
                    ),
                  ),
                  TextField(
                    controller: price,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),
                  TextField(
                    controller: paymentdetail,
                    decoration: const InputDecoration(
                      labelText: 'Payment Detail',
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                    child: const Text( 'Create'),
                    onPressed: () async {
                      final String BookID = bookidController.text;
                      final String Date = dateController.text;
                      final String LibrarianID = librarianidController.text;
                      final String PaymentDetail = paymentdetail.text;
                      final String PaymentID = paymentid.text;
                      final String Price = price.text;
                      final String SellerID = sellerid.text;
                      final int? BookQuantity =
                      int.tryParse(bookqController.text);
                      if (bookqController != null) {

                        await _librarypayment
                            .doc(documentSnapshot!.id)
                            .update({"BookID": BookID, "BookQuantity": BookQuantity, "Date":Date, "LibrarianID":LibrarianID,
                          "PaymentDetail":PaymentDetail, "PaymentID":PaymentID,"Price":Price,"SellerID":SellerID,});
                        bookidController.text = '';
                        librarianidController.text = '';
                        paymentdetail.text = '';
                        paymentid.text = '';
                        dateController.text = '';
                        price.text = '';
                        sellerid.text ='';
                        bookqController.text = '';
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
        backgroundColor: Colors.lightGreenAccent,
        title: Text("Library Payment Detail"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const searchlibrarypayment()));
          }, icon: Icon(Icons.search))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("LibraryPayment").snapshots(),
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
                      height: 330,
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
                          Text("Payment ID : "+snapshot.data!.docs[i]['PaymentID'],style: GoogleFonts.roboto(
                            textStyle: style,
                            fontSize: 15,
                          ),),
                          SizedBox(height: 10,),
                          Text("Seller ID : "+snapshot.data!.docs[i]['SellerID'].toString()),
                          SizedBox(height: 20,),
                          Text("Librarian ID : "+snapshot.data!.docs[i]['LibrarianID']),
                          SizedBox(height: 20,),
                          Text("Book ID : "+snapshot.data!.docs[i]['BookID']),
                          SizedBox(height: 20,),
                          Text("Payment Detail : "+snapshot.data!.docs[i]['PaymentDetail'].toString()),
                          SizedBox(height: 20,),
                          Text("Book Quantity : "+snapshot.data!.docs[i]['BookQuantity'].toString()),
                          SizedBox(height: 20,),
                          Text("Date : "+snapshot.data!.docs[i]['Date'].toString()),
                          SizedBox(height: 20,),
                          Text("Price : "+snapshot.data!.docs[i]['Price'].toString()),
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
