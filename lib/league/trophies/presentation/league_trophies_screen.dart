import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/trophies/presentation/router/league_trophies_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'league_trophies_view_model.dart';

class LeagueTrophiesScreen extends StatefulWidget {
  const LeagueTrophiesScreen({Key? key}) : super(key: key);

  @override
  _LeagueTrophiesScreenState createState() => _LeagueTrophiesScreenState();
}

class _LeagueTrophiesScreenState extends State<LeagueTrophiesScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueTrophiesViewModel>();

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
    super.initState();
  }

  @override
  Widget navigate() {
    return LeagueTrophiesNavigator.flow(viewModel);
  }
}
