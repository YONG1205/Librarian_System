
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meow_librarian/helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const register(),
  ));
}

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  AuthService authService = AuthService();
  final firebase = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 30),
        children:   [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/cats.jpg",
                    height: 150,
                  ),
                  const SizedBox(height: 20,),

                  const Text(
                    "Meow Librarian System",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: authService.name,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Librarian Name",
                        hintText: "Please enter librarian Name",
                        prefixIcon: Icon(Icons.verified_user, color: Colors.black,)
                    ),
                    validator: (val){
                      if(val == null || val == ""){
                        return "Please fill in";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: authService.password,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Please enter your password",
                        prefixIcon: Icon(Icons.password, color: Colors.black,)
                    ),
                    validator: (val){
                      if(val == null || val == ""){
                        return "Please fill in";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: authService.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Please enter your email",
                        prefixIcon: Icon(Icons.email, color: Colors.black,)
                    ),
                    validator: (val){
                      if(val == null || val == ""){
                        return "Please fill in";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: authService.address,
                    decoration: const InputDecoration(
                        labelText: "Address",
                        hintText: "Please enter your address",
                        prefixIcon: Icon(Icons.home, color: Colors.black,)
                    ),
                    validator: (val){
                      if(val == null || val == ""){
                        return "Please fill in";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: authService.phonenumber,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        labelText: "Phone Number",
                        hintText: "Please enter your phone number",
                        prefixIcon: Icon(Icons.phone, color: Colors.black,)
                    ),
                    validator: (val){
                      if(val == null || val == ""){
                        return "Please fill in";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  TextButton(
                    onPressed: (){
                      if(authService.email != "" && authService.password != ""){
                        authService.Register(context);
                      }
                    },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(200, 20)
                      ),
                      child: const Text("Register")
                  ),
                  const SizedBox (height: 50,),


                ],
              )
          )
        ],
      ),

    );
  }
}
