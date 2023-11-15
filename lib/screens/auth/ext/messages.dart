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
    final size = MediaQuery.of(context).size;
    Map userData = AppStateScope.of(context).userData;
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

    PreferredSizeWidget? appBar() {
      return PreferredSize(
        preferredSize: Size(size.width, size.height * 0.15),
        child: SizedBox(
          height: size.height * 0.11,
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        AppStateWidget.of(context).toHome();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      "${userData['username']}",
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // print('Video button pressed');
                      },
                      icon: const Icon(
                        Icons.videocam,
                        color: Colors.white70,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // print('New Message button pressed');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const NewMessage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.library_add,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget? bottomNav() {
      return SizedBox(
        height: size.height * 0.061,
        width: size.width,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: FloatingActionButton(
            splashColor: Colors.transparent,
            backgroundColor: Colors.black,
            onPressed: () {
              print('camera thing pressed');
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 15,
                  ),
                  child: Icon(
                    Icons.photo_camera,
                    size: 32,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  'Camera',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
