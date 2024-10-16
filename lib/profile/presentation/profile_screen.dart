import 'package:e_racing_app/profile/presentation/navigation/profile_navigation.dart';
import 'package:e_racing_app/profile/presentation/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/ui/component/ui/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  __ProfileScreenState createState() => __ProfileScreenState();
}

class __ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ProfileViewModel vm = ProfileViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: TextWidget(
            text: "Profile",
            style: Style.title,
          )
      ),
      body: Stack(
        children: [
          Observer(builder: (_) {
            return navigation();
          })
        ],
      ),
    );
  }

  Widget navigation() {
    return ProfileNavigation.flow(vm);
  }
}
