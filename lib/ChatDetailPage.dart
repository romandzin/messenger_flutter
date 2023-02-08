import 'dart:convert';

import 'package:flutter/material.dart';

import '.model/ChatMessage.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget{
  final String name;
  final String imageUrl;

  ChatPage({Key? key, required this.name, required this.imageUrl}): super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatPage> {

  late IOWebSocketChannel channel;
  late bool connect;

  String myId = "222";
  String receiverId = "111";


  List<ChatMessage> messages = [];
  TextEditingController messageText = TextEditingController();

  @override
  void initState() {
    messageText.text = "";
    channel = IOWebSocketChannel.connect(Uri.parse("wss://echo.websocket.events"));
    handleChanel();
    super.initState();
  }

  void handleChanel() {
    channel.stream.listen((message) {
      setState(() {
        if (message != "") {
          print(message);
        }
        setState(() {
          messages.add(
              ChatMessage(messageContent: message, messageType: "receiver"));
        });
      });
  }); }

  void sendMessage(String text) {
    setState(() {
      messages.add(
          ChatMessage(messageContent: text, messageType: "sender"));
    });
    channel.sink.add(messageText.text);
    messageText.text = "";
  }

  void receiveMessage(String text) {
    setState(() {
      messageText.text = "";
      messages.add(
          ChatMessage(messageContent: text, messageType: "receiver"));
    });
    channel.sink.add(messageText.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                  maxRadius: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.name, style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w600),),
                      SizedBox(height: 6),
                      Text("Online", style: TextStyle(color: Colors.grey
                          .shade600, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.settings, color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(messages[index].messageContent,
                          style: TextStyle(fontSize: 15),),
                      ),
                    ));
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20,),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: messageText,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () {
                      sendMessage(messageText.text);
                    },
                    child: Icon(Icons.send, color: Colors.white, size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}
