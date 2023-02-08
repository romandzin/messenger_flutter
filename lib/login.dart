import 'package:flutter/material.dart';
import 'package:messenger_flutter/main.dart';
import 'package:messenger_flutter/registration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Padding(padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(height: MediaQuery.of(context).size.height,
                                  child: Column(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Войти в аккаунт", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                                        Row(mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("Нет аккаунта?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                                TextButton(style: TextButton.styleFrom(minimumSize: const Size(40, 10), padding: EdgeInsets.all(5.0)),
                                                    onPressed: () => {
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegistrationScreen()))
                                                },
                                                    child: Text("Создать", style: TextStyle(color: Color.fromRGBO(92, 119, 242, 10), fontSize: 18)))
                                          ],
                                        ),
                                        const Padding(padding: EdgeInsets.only(top: 10.0),
                                          child: TextField(decoration: InputDecoration(hintText: "E-mail", border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 4, color: Colors.black, style: BorderStyle.solid),
                                              borderRadius: BorderRadius.all(Radius.circular(8.0))
                                          )
                                          ))),
                                        const Padding(padding: EdgeInsets.only(top: 15.0),
                                          child: TextField(decoration: InputDecoration(hintText: "Пароль", border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 4, color: Colors.black, style: BorderStyle.solid),
                                              borderRadius: BorderRadius.all(Radius.circular(8.0))
                                          )
                                          ))),
                                        TextButton(onPressed: () => {
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainPage()))
                                        }, child: Text("Забыли пароль?", style: TextStyle(color: Color.fromRGBO(92, 119, 242, 10))))]
                                  ))),
                            Align(alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40), backgroundColor: Color.fromRGBO(92, 119, 242, 10)),
                                  onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainPage()))},
                                  child: const Text("Войти", style: TextStyle(fontSize: 18),),),))
                          ],
                    )))
          ],
        )
    );
  }
}
