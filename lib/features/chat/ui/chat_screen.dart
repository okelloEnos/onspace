import 'package:flutter/material.dart';
import 'package:onspace/resources/common_widget/curved_card.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text('Chat Screen')),
            CurvedCard(
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 10,
                    left: 10,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Custom Shape Card',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'This is a custom shape card example in Flutter',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
