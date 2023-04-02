import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/country_picker_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/profile/presentation/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileWidget extends StatefulWidget {
  final ProfileViewModel vm;

  const ProfileWidget(this.vm, {Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  late String password = "";
  late String? country = "BR";

  @override
  void initState() {
    widget.vm.fetchProfile();
    _nameController.text = widget.vm.profileModel?.name ?? '';
    _surnameController.text = widget.vm.profileModel?.surname ?? '';
    _mailController.text = widget.vm.profileModel?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        scrollable: false,
        body: content(),
        state: widget.vm.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Form(
      child: signinForm(),
      key: _formKey,
    );
  }

  Widget signinForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const SpacingWidget(LayoutSize.size16),
              InputTextWidget(
                  enabled: true,
                  label: 'Name',
                  icon: Icons.person,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty == true) {
                      return 'valid name needed';
                    }
                    return null;
                  }),
              const SpacingWidget(LayoutSize.size16),
              InputTextWidget(
                  enabled: true,
                  label: 'Surname',
                  icon: Icons.person,
                  controller: _surnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty == true) {
                      return 'valid surname needed';
                    }
                    return null;
                  }),
              const SpacingWidget(LayoutSize.size16),
              CountryPickerWidget(
                onCountrySelected: (code) {
                  country = code;
                },
              ),
            ],
          ),
          ButtonWidget(
            enabled: true,
            type: ButtonType.primary,
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                widget.vm.udpate(_nameController.text, _surnameController.text,
                    _mailController.text, country ?? '');
              }
            },
            label: "Update",
          )
        ],
      ),
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
