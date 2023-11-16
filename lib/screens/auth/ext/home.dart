import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/home_body.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/search_body.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/post_body.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/activity_body.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/profile_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String bodyNav = 'home';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    PreferredSizeWidget? appBarContent() {
      return PreferredSize(
        preferredSize: Size(
          size.width,
          size.height * 0.15,
        ),
        child: SizedBox(
          height: size.height * 0.11,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black,
              // boxShadow: [
              //     color: Color.fromARGB(255, 94, 146, 172),
              //     offset: Offset.fromDirection(90, 0.35)
                
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.04,
                      ),
                      child: Text(
                        'DM: DD',
                        style: GoogleFonts.dancingScript(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            // wordSpacing: 0.75,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const PostBody(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.control_point_sharp,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              bodyNav = 'activity';
                            });
                          },
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            AppStateWidget.of(context).toMessages();
                          },
                          icon: const Icon(
                            Icons.message_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

// TODO: definite visit some whiteboarding on specifically what screens and features are going to be utilized, UI, UX, all that good stuff, i really want to have an active game mode, socials[ maybe stories too?? ], text game mode, etc etc WHITEBOARD

    Widget? bodyContent() {
      switch (bodyNav) {
        case 'home':
          return const HomeBody();
        case 'activity':
          return const ActivityBody();
        // case 'post':
        //   return Navigator.of(context).push(MaterialPageRoute(
        //       builder: (BuildContext context) => const PostBody()));
        case 'profile':
          return const ProfileBody();
        case 'search':
          return const SearchBody();
        default:
          return const HomeBody();
      }
    }

    Widget? bottomNav() {
      return SizedBox(
        height: size.height * 0.061,
        width: size.width,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            // TODO: conditionally render active Icons
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    bodyNav = 'home';
                  });
                  print('homeNavIcon Pressed');
                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    bodyNav = 'search';
                  });
                  print('searchNavIcon Pressed');
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const PostBody(),
                    ),
                  );
                  // setState(() {
                  //   bodyNav = 'post';
                  // });
                  print('newPostNavIcon Pressed');
                },
                icon: const Icon(
                  Icons.control_point_sharp,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    bodyNav = 'activity';
                  });
                  print('activityNavIcon Pressed');
                },
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    bodyNav = 'profile';
                  });
                  print('profileNavIcon Pressed');
                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      primary: true,
      appBar: appBarContent(),
      body: bodyContent(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
