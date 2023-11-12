import 'package:flutter/material.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/message_ext/new_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);
  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final size = AppStateScope.of(context).miscData['media_query'].size;
    Map userData = AppStateScope.of(context).userData;
    //TODO: fill this stuff in
    Widget? bodyCont() {
      return const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'this will be search bar',
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'this will be MessageList',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    PreferredSizeWidget? appBar() {}
    Widget? bottomNav() {}
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      primary: true,
      body: bodyCont(),
      appBar: appBar(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
