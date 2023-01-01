import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meow_librarian/firstpage.dart';
import 'package:meow_librarian/helper.dart';
import 'register.dart';
final auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(

      primarySwatch: Colors.blue,
    ),
    home: auth.currentUser == null ? const librarian() : const firstpage(),
  ));
}

class librarian extends StatefulWidget {
  const librarian({Key? key}) : super(key: key);

  @override
  State<librarian> createState() => _librarianState();
}

class _librarianState extends State<librarian> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 20),
        children:   [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/libary cat.jpg",
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
                    "Login to Librarian System",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: authService.email,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Librarian Email",
                        hintText: "Please enter your librarian Email",
                        prefixIcon: Icon(Icons.verified_user, color: Colors.black,)
                    ),
                  ),
                  const SizedBox(height: 20,),

                  SizedBox(
                    height: 60,
                    child: TextFormField(
                      controller: authService.password,
                      obscureText: hideText,
                      keyboardType: TextInputType.visiblePassword,
                      decoration:  InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.password, color: Colors.black,),
                          suffix: IconButton(onPressed: (){setState(() {hideText = !hideText;
                          });
                          },
                            icon: Icon(hideText ? Icons.visibility_off : Icons.visibility),
                          )
                      ),

                    ),
                  ),
                  const SizedBox(height: 20,),

                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white70,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)
                    ),
                      onPressed: (){
                        if(authService.email != "" && authService.password != ""){
                          authService.login(context);
                        }
                      },
                      child: const Text(
                          "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 2,
                        ),
                      )
                  ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont't have Account ?",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const register()));
                      }, child: const Text("Register Account")),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  resetpassword()));
                      }, child: const Text("Reset Password"))
                    ],
                  ),
                ],
              )
          )
        ],
      ),

    );
  }
}

class resetpassword extends StatelessWidget {
 TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Reset Page", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Padding(
              padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Enter Your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async{
           await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> librarian()));
            });
          }, child: Text("Reset Password"))
        ],
      ),
    );
  }
}

