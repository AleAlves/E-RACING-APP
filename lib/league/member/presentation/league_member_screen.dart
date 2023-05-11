import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../member/presentation/league_member_view_model.dart';
import '../../member/presentation/navigation/league_member_navigation.dart';

class LeagueMemberScreen extends StatefulWidget {
  const LeagueMemberScreen({Key? key}) : super(key: key);

  @override
  _LeagueMemberScreenState createState() => _LeagueMemberScreenState();
}

class _LeagueMemberScreenState extends State<LeagueMemberScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueMemberViewModel>();

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => scaffold());

  @override
  Widget scaffold() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: TextWidget(
          text: viewModel.title,
          style: Style.paragraph,
        ),
      ),
      body: navigate(),
    );
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget navigate() {
    return LeagueMemberNavigation.flow(viewModel);
  }
}
