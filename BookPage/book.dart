import 'package:flutter/material.dart';
import 'package:meow_librarian/BookPage/booksseller.dart';
import 'package:meow_librarian/BookPage/donators.dart';
import 'booksdetail.dart';

class book extends StatefulWidget {
  const book({Key? key}) : super(key: key);

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Book"),
        backgroundColor: Colors.amberAccent,
        elevation: 20,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/books.jpg",
            height: 200,

          ),
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const booksdetail()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,

              ),
              child: const Text(" Books Detail")
          ),
          const SizedBox (height: 50,),

          Image.asset(
            "assets/donatebook.jpg",
            height: 150,
          ),

          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const donators()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,

              ),
              child: const Text(" Books Donators")
          ),
          const SizedBox (height: 50,),

          Image.asset(
            "assets/seller.jpg",
            height: 150,
          ),

          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const seller()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text("Books Seller")
          ),
          const SizedBox (height: 50,),
        ],
      ),
    );
  }
}
