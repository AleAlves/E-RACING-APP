import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/home/presentation/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/ui/view_state.dart';
import 'router/home_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<HomeViewModel>();

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
          style: Style.subtitle,
        ),
        actions: [
          notifications(),
        ],
      ),
      body: navigate(),
    );
  }

  Widget notifications() {
    return Stack(
      children: [
        ButtonWidget(
            enabled: true,
            icon: Icons.notifications_none,
            type: ButtonType.iconShapeless,
            onPressed: () {
              viewModel.goToPushNotifications();
            }),
        viewModel.notificationsCount == null ||
                viewModel.notificationsCount == "0"
            ? Container()
            : Positioned(
                left: -5,
                top: 2,
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: TextWidget(
                            text: viewModel.notificationsCount,
                            style: Style.paragraph,
                            color: Theme.of(context).colorScheme.onSecondary,
                            weight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget navigate() {
    return HomeNavigation.flow(viewModel);
  }
}
