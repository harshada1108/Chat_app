import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});


  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body:Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical:16 ),
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image(
                          image: AssetImage('images/logo.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),


                  Text(
                     'Flash Chat',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
              SizedBox(height: 48,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Registration_screen');
                      //Go to login screen.
                    },
                    minWidth: 150.0,
                    height: 50.0,
                    child: Text(
                      'Register',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  elevation: 5,
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(onPressed: (){
                    Navigator.pushNamed(context, 'LoginScreen');
                  },
                    minWidth: 150,
                    height: 50,
                    child: Text(
                      'Log-in',
                    ),),

                ),)
            ],

          ),
        )
    );
  }
}
