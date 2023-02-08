
channelConnect() {
  try {
    channel = IOWebSocketChannel.connect(Uri.parse("wss://echo.websocket.events"));
    channel.stream.listen((message) {
      print(message);
      setState(() {
        if (message == "connected") {
          connect = true;
          setState(() {});
          print("Connection established");
        }
        else if (message == "send:success") {
          print("Message send success");
          setState(() {
            messageText.text = "";
          });
        }
        else if (message == "send:error") {
          print("Message send error");
        }

        setState(() {

        });
      });
    },
        onDone: () {
          print("WebSocket is closed");
          setState(() {
            connect = false;
          });
        },
        onError: (error) {
          print(error.toString());
        }
    );
  } catch(_) {
    print("error on connecting to websocket");
  }
}

Future<void> sendMessage(String message, String id) async {
  if (connect == true) {
    String msg = "";
    setState(() {
      messageText.text = "";
      messages.add(
          ChatMessage(messageContent: message, messageType: "sender"));
    });
    channel.sink.add(msg);
  }
  else {
    channelConnect();
    print("WebSocket is not connected");
  }
}

appBar: AppBar(backgroundColor: Colors.grey.shade600,
toolbarHeight: 25,
flexibleSpace: TextField(
decoration: InputDecoration(
hintText: "Search...",
hintStyle: TextStyle(color: Colors.grey.shade600),
prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
filled: true,
fillColor: Colors.grey.shade100,
contentPadding: EdgeInsets.all(8),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(20),
borderSide: BorderSide(
color: Colors.grey.shade100
)
),
),
),
),