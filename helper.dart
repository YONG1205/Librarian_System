import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meow_librarian/firstpage.dart';
import 'package:meow_librarian/main.dart';




class AuthService{
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  void login(context)async{
    try{
      await auth.signInWithEmailAndPassword(email: email.text, password: password.text)
          .then((value) =>
      {
        print("Librarian is Login"),
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>firstpage()), (route) => false)
      });
    }catch(e){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Login Fail"),
              content: Text(e.toString()),
            );
          }
      );
    }
  }

  void Register(context)async{
    TextEditingController liname = name;
    TextEditingController liaddress = address;
    TextEditingController liphonenumber = phonenumber;
    if(liname.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Librarian Name is Empty"),
      ));
    }else if(liaddress.text.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text("Address is Empty"),
       ));
     }else if(liphonenumber.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Phone Number is Empty"),
      ));
    }else{
      try{

        await auth
            .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
            .then((value)  {
          print("Librarian Is Registered");
          firestore.collection("Librarian").add({
            "Email":email.text,
            "Password":password.text,
            "Librarian":name.text,
            "Address":address.text,
            "PhoneNumber":phonenumber.text,
            "uid":auth.currentUser!.uid,
          });
          Navigator.pop(context);
        });

      }catch(e){
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Register Fail"),
                content: Text(e.toString()),
              );
            }
        );
      }
    }

  }

  void logout(context)async{
    await auth.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>librarian()), (route) => false);
  }

  void verifyEmail()async{
    final user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification();
  }

}




