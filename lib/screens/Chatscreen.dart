import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
 User? loggedinUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController =TextEditingController();
  final _auth=FirebaseAuth.instance;

  late String message;
  final _firestore=FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser()async {
    try{final user=await _auth.currentUser;
    if(user!=null) {
      setState(() {
        loggedinUser = user;
      });
      print(loggedinUser!.email);
    }
    }catch(e){
      print(e);
    }

  }
  void messageStream()async {
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var msg in snapshot.docs){
        print(msg.data());
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: <Widget>[
            StreamBuilder(stream: _firestore.collection('messages').snapshots(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show a loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');}
            else if(snapshot.hasData){
              final messages=snapshot.data?.docs.reversed;
              List<MessageBubble> messagebubbles=[];
              for(var message in messages!){
                final messageText=message.data()['text'];
                final senderText=message.data()['sender'];
                final currentUser=loggedinUser!.email;
                if(currentUser==senderText){
                }
                final messagebubble=MessageBubble(message: messageText, sender: senderText,isMe: currentUser==senderText,);
                messagebubbles.add(messagebubble);
              }
              return Expanded(

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),

                  child: ListView(
                    reverse: true,
                    scrollDirection: Axis.vertical,

                    children: messagebubbles,
                  ),
                ),
              );
            }
            else return Container();
          }),
            
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        message=value;

                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add(({
                        'sender':loggedinUser!.email,
                        'text':message,
                      }));

                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  final String  sender;
  final String message;
  bool isMe;
  MessageBubble({super.key,required this.message,required this.sender, required this.isMe});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child:Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(color: Colors.black38),),


          Material(
            color:isMe? Colors.blue[300]:Colors.green,

            elevation: 5,

            borderRadius:isMe? BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)): BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
            child: Padding(

              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child: Text('$message ',style: TextStyle(fontSize: 20,color: Colors.white),),
            ),

          ),
        ],
      ),
    );

  }
}
