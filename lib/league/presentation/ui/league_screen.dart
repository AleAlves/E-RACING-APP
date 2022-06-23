import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../core/ui/component/ui/share_widget.dart';
import 'league_flow.dart';

class LeagueScreen extends StatefulWidget {
  final LeagueFlow flow;

  const LeagueScreen(this.flow, {Key? key}) : super(key: key);

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueViewModel>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    _disposers.add(reaction((_) => viewModel.league, (LeagueModel? league) {}));
    viewModel.setFlow(widget.flow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Leagues'),
          actions: [
            if (viewModel.share != null)
              ShareWidget(
                model: viewModel.share,
              )
            else
              Container()
          ],
        ),
        body: navigate(),
      );
    });
  }

  @override
  Widget navigate() {
    return LeagueNavigation.flow(viewModel);
  }
}
