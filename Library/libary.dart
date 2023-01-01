import 'package:flutter/material.dart';
import 'librarypayment.dart';

class libary extends StatefulWidget {
  const libary({Key? key}) : super(key: key);

  @override
  State<libary> createState() => _libaryState();
}

class _libaryState extends State<libary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Libary"),
        backgroundColor: Colors.lightGreen,
        elevation: 20,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/librarypayment.jpg",
            height: 150,
          ),
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const librarypayment()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text(" Library Payment")
          ),
          const SizedBox (height: 50,),

        ],
      ),
    );
  }
}
