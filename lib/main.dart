import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:messenger_flutter/.model/ChatUsersModel.dart';
import 'package:messenger_flutter/login.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '.model/conversationList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

  int _selectedIndex = 0;
  final ScrollController _homeController = ScrollController();

  void createDialog() {

  }

  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "https://xsgames.co/randomusers/avatar.php?g=female", time: "Now"),
    ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "https://xsgames.co/randomusers/avatar.php?g=male", time: "31 Mar"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thank you, It's awesome", imageURL: "https://api.lorem.space/image/face?w=150&h=150", time: "23 Mar"),
  ];

  Widget listViewBody() {
    return ListView.builder(
      itemCount: chatUsers.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      itemBuilder: (context, index){
        return ConversationList(
          name: chatUsers[index].name,
          messageText: chatUsers[index].messageText,
          imageUrl: chatUsers[index].imageURL,
          time: chatUsers[index].time,
          isMessageRead: true
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listViewBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/messages.svg',
            color: Color.fromRGBO(112, 117, 121, 1),),
            activeIcon: SvgPicture.asset('assets/icons/messages.svg',
              color: Color.fromRGBO(92, 119, 242, 10)),
            label: 'Messages',),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/channels.svg',),
            activeIcon: SvgPicture.asset('assets/icons/channels.svg',
            color: Color.fromRGBO(92, 119, 242, 10),),
            label: 'Community',),
          BottomNavigationBarItem(
            label: "Profile",
            icon:CircleAvatar(backgroundColor: Colors.blue,
              maxRadius: 20,
            )),],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          switch (index) {
            case 0:
              if (_selectedIndex == index) {
                _homeController.animateTo(0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,);
              }
              break;
          }
          setState( () {
            _selectedIndex = index;
            },
          );
          },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(135, 116, 225, 1),
        tooltip: 'Создать диалог',
        onPressed: createDialog,
        child: const Icon(Icons.create),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
