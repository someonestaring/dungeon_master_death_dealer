import 'package:flutter/material.dart';

final PageController pageCont = PageController(
  initialPage: 0,
);

final Map initialState = {
  "dateJoined": DateTime,
  "deviceTokens": [],
  "email": '',
  "firstName": 'New',
  "lastActive": DateTime,
  "lastName": 'User',
  'fullName': 'New User',
  "notificationAccess": false,
  "phoneNumber": '',
  "profilePhoto": '',
  "username": 'new_user',
  'birthday': DateTime,
};

final Map miscData = {};

class AppState {
  AppState({
    required this.pageCont,
    required this.userData,
    required this.miscData,
  });
  final PageController pageCont;
  final Map userData;
  final Map miscData;
  AppState copyWith({PageController? pageCont, Map? userData, Map? miscData}) {
    return AppState(
      pageCont: pageCont ?? this.pageCont,
      userData: userData ?? this.userData,
      miscData: miscData ?? this.miscData,
    );
  }
}

class AppStateScope extends InheritedWidget {
  const AppStateScope(this.data, {Key? key, required Widget child})
      : super(key: key, child: child);
  final AppState data;
  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data != oldWidget.data;
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({super.key, required this.child});
  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  AppStateWidgetState createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  AppState data = AppState(
    pageCont: pageCont,
    userData: initialState,
    miscData: {},
  );

  void updateUserData(Map<String, dynamic> newData) {
    setState(() {
      newData.forEach((key, value) {
        if (data.userData.containsKey(key)) {
          data.userData.update(key, (val) => value);
        } else {
          data.userData[key] = value;
        }
      });
    });
  }

  void updateOneKV(key, newVal) {
    setState(() {
      data.userData.update(key, (val) => newVal);
    });
  }

  void updateMiscData(Map newData) {
    setState(() {
      newData.forEach((key, value) {
        if (data.miscData.containsKey(key)) {
          data.miscData.update(key, (val) => value);
        } else {
          data.miscData[key] = value;
        }
      });
    });
  }

  void toHome() {
    pageCont.animateToPage(
      0,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeIn,
    );
  }

  void toMessages() {
    pageCont.animateToPage(
      1,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(data, child: widget.child);
  }
}
