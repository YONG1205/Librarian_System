import 'package:flutter/material.dart';
import 'userdata.dart';
import 'userpayment.dart';
import 'suggest.dart';

class user extends StatefulWidget {
  const user({Key? key}) : super(key: key);

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("User Detail"),
        backgroundColor: Colors.redAccent,
        elevation: 30,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/person.png",
            height: 150,
          ),
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const userdata()));
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,

              ),
              child: const Text(" User Detail")
          ),
          const SizedBox (height: 50,),

          Image.asset(
            "assets/payment.jpg",
            height: 150,
          ),

          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const userpayment()));
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,

              ),
              child: const Text(" User Payment Detail")
          ),
          const SizedBox (height: 50,),

          Image.asset(
            "assets/suggestion.jpg",
            height: 200,
            width: 300,

          ),

          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const suggestion()));
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
              ),
              child: const Text(" User Suggestion Book")
          ),
          const SizedBox (height: 50,),
        ],
      ),
    );
  }
}
