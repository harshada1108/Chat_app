import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/Chatscreen.dart';
class Registration_screen extends StatefulWidget {
  const Registration_screen({super.key});

  @override
  State<Registration_screen> createState() => _Registration_screenState();
}

class _Registration_screenState extends State<Registration_screen> {
  final  _auth=FirebaseAuth.instance;
  late String email;
  late  String password;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag:'logo',
              child: Container(
                height: 200,
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
            SizedBox(height: 48,),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,

              onChanged: (value) {
                email=value;
                //Do something with the user input.
              },
              decoration: InputDecoration(

                hintText: 'Enter your email',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(

              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value){

                password=value;
              },
              decoration: InputDecoration(

                hintText: 'enter your password',

                contentPadding:
                EdgeInsets.symmetric(horizontal: 20,vertical:10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),

            ),
            SizedBox(height: 24,),
            Padding(padding: EdgeInsets.symmetric(vertical: 16),
              child: Material(
                elevation: 5,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: MaterialButton(
                  onPressed: ()async {
                   try {
                     final newUser = await _auth.createUserWithEmailAndPassword(
                         email: email, password: password);
                     if(newUser!=null){
                       Navigator.pushNamed(context,'Chatscreen' );
                     }
                   }catch(e){
                     print(e);
                   }

                    Navigator.pushNamed(context,'Chatscreen');
                  },
                  minWidth: 200,
                  height: 42,
                  child: Text('Register'),
                ),
              ),)



          ],
        ),
      ),
    );
  }
}
