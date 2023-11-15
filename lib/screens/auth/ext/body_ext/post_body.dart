import 'package:dungeon_master_death_dealer/screens/auth/ext/post_ext/post_edit.dart';
import 'package:flutter/material.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);
  @override
  PostBodyState createState() => PostBodyState();
}

class PostBodyState extends State<PostBody> {

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _mediaAccess() async {}

  // Future<void> _cameraAccess() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget currentMediaView() {
      return SizedBox(
        height: size.height * 0.5,
        width: size.width,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white54,
          ),
        ),
      );
    }

    Widget utilityBar() {
      return SizedBox(
        height: size.height * 0.065,
        width: size.width,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      );
    }

    Widget mediaGrid() {
      return DecoratedBox(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: GridView.builder(
          addRepaintBoundaries: false,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          // primary: true,
          shrinkWrap: true,
          itemCount: 48,
          itemBuilder: (BuildContext context, int index) =>
              // _localImages[index])
              const Card(
            child: Text('assets'),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
          ),
        ),
      );
    }

    PreferredSizeWidget appBar() {
      return PreferredSize(
        preferredSize: Size(size.width, size.height * 0.15),
        child: SizedBox(
          height: size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white70,
                    ),
                  ),
                  const Text(
                    'New post',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const PostEditing(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.east,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget bodyContent() {
      return SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              currentMediaView(),
              utilityBar(),
              mediaGrid(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(),
      body: bodyContent(),
    );
  }
}
