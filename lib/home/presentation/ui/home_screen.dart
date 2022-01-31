import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/presentation/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'home_flow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('E-racing'),
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
    switch (viewModel.state) {
      case ViewState.loading:
        return const LoadingRipple();
      case ViewState.ready:
        switch (viewModel.flow) {
          case HomeFlow.home:
            return  Container();
          case HomeFlow.error:
            return  Container();
          default:
            return Container();
        }
        break;
      case ViewState.error:
        return Container();
      default:
        return Container();
    }
  }
}
