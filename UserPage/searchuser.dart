import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
  home: searchuser(),
  ));
}

class searchuser extends StatefulWidget {
  const searchuser({Key? key}) : super(key: key);

  @override
  State<searchuser> createState() => _searchuserState();
}

class _searchuserState extends State<searchuser> {
  TextEditingController name = TextEditingController();
  Map? map;

  findUserInFirebase() async{
    if(name.text.isNotEmpty){
     await FirebaseFirestore.instance.collection("User").where("name",isEqualTo: name.text).get().then((value){
        for(var i in value.docs){
          setState(() {
            map = i.data();
            print(map);
          });
        }
      });
    }
    if(map?['name']== name.text){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>NextPage(
        name: map?['name'],
        email: map?['email'],
        password: map?['password'],
        phonenumber: map?['phonenumber'].toString(),

      )));
    }else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("User Not Found in Database"),
            content: Text("User Name :${name.text}"),
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
        title: Text("Search User"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/searchuser.png",
            height: 200,
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(
              labelText: "Search User",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            findUserInFirebase();
          }, child: Text("Search User ")),
          SizedBox(height: 20,),
          Text("Noted : Please search user by using the name of user !!",style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
 String? name,email,password,phonenumber;
 NextPage({this.name,this.email,this.password,this.phonenumber});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail"),
      ),
      body: ListView(
        children: [
      Container(
      padding: EdgeInsets.all(10),
      width: 200,
      height: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/people.png')
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
                Text("  Name: "+name.toString(), style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
          SizedBox(height: 50,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.email),
                Text("  Email: "+email.toString(),style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
           SizedBox(height: 50,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.password),
                Text("  Password: "+password.toString(),style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
          SizedBox(height: 50,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.phone),
                Text("  Phone Number: "+phonenumber.toString(),style: TextStyle(fontSize: 20),),
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

