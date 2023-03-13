import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/common/constants.dart';

import 'package:room_finder_flutter/providers/chatmessage.dart';

import 'package:room_finder_flutter/utils/RFColors.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:room_finder_flutter/utils/RFImages.dart';

class RFChatGPTFragment extends StatefulWidget {
  @override
  State<RFChatGPTFragment> createState() => _RFChatGPTFragmentState();
}

Future<String> generateResponse(String prompt) async {
  const apiKey = apiSecetKey;

  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "text-davinci-003",
      "prompt": prompt,
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );
  print(jsonDecode(utf8.decode(response.bodyBytes)));

  // Do something with the response
  Map<String, dynamic> newresponse =
  jsonDecode(utf8.decode(response.bodyBytes));

  return newresponse['choices'][0]['text'];
}

class _RFChatGPTFragmentState extends State<RFChatGPTFragment> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  void init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Chat with HappyHome',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 45,
                decoration: BoxDecoration(color: Colors.orange,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16))

                )),
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: t7view_color,
                  borderRadius: BorderRadius.circular(8),
                  //     border: Border(
                  //   top: BorderSide(color: Color(0xFFDFDFDF)),
                  //   left: BorderSide(color: Color(0xFFDFDFDF)),
                  //   right: BorderSide(color: Color(0xFF7F7F7F)),
                  //   bottom: BorderSide(color: Color(0xFF7F7F7F)),
                  // )
                ),
                child: Row(
                  children: [
                    _buildInput(),
                    _buildSubmit(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        maxLines: 5,
        minLines: 1,
        controller: _textController,
        decoration: InputDecoration(
          icon: Icon(Icons.question_answer_outlined, color: rf_primaryColor),
          fillColor: t7view_color,
          hintText: 'Hãy viết gì đó.....',
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        child: IconButton(
          icon: Icon(
            Icons.send_rounded,
            color: rf_primaryColor,
          ),
          onPressed: () async {
            setState(
                  () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textController.text;
            _textController.clear();
            Future.delayed(Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            generateResponse(input).then((value) {
              setState(() {
                isLoading = false;
                _messages.add(
                  ChatMessage(
                    text: value,
                    chatMessageType: ChatMessageType.bot,
                  ),
                );
              });
            });
            _textController.clear();
            Future.delayed(Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  ListView _buildList() {
    return ListView.builder(
        itemCount: _messages.length,
        controller: _scrollController,
        itemBuilder: ((context, index) {
          var message = _messages[index];
          return ChatMessageWidget(
            text: message.text,
            chatMessageType: message.chatMessageType,
          );
        }));
  }
}

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  ChatMessageWidget(
      {Key? key, required this.text, required this.chatMessageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: chatMessageType == ChatMessageType.bot
          ? Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Image.asset(rf_logo_happyhome),
          ),
          10.width,
          Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              color: Colors.grey
              // gradient: LinearGradient(
              //   colors: [
              //     Color(0xFF4285F4),
              //     Color(0xFFDB4437),
              //     Color(0xFFF4B400),
              //     Color(0xFF0F9D58),
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
            ),

            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
             color: Colors.blue
            ),

            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
          10.width,
          CircleAvatar(
            child: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
