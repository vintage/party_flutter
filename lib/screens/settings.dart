import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zgadula/components/flag_image.dart';
import 'package:zgadula/localizations.dart';
import 'package:zgadula/services/language.dart';

import 'package:zgadula/store/settings.dart';
import 'package:zgadula/store/language.dart';
import 'package:zgadula/screens/tutorial.dart';

class SettingsScreen extends StatelessWidget {
  Widget buildAppBar(context) {
    return SliverAppBar(
      titleSpacing: 8.0,
      floating: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      title: Text(
        AppLocalizations.of(context).settingsHeader,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.help),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TutorialScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildContent(context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: ScopedModelDescendant<SettingsModel>(
        builder: (context, child, model) {
          return Column(
            children: <Widget>[
              SwitchListTile(
                title: Text(AppLocalizations.of(context).settingsAccelerometer),
                value: model.isRotationControlEnabled,
                onChanged: (bool value) {
                  model.toggleRotationControl();
                },
                secondary: Icon(Icons.screen_rotation),
              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context).settingsAudio),
                value: model.isAudioEnabled,
                onChanged: (bool value) {
                  model.toggleAudio();
                },
                secondary: Icon(Icons.music_note),
              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context).settingsVibrations),
                value: model.isVibrationEnabled,
                onChanged: (bool value) {
                  model.toggleVibration();
                },
                secondary: Icon(Icons.vibration),
              ),
              ScopedModelDescendant<LanguageModel>(
                builder: (context, child, model) {
                  return ListTile(
                    title: Text(AppLocalizations.of(context).settingsLanguage),
                    leading: Icon(Icons.flag),
                    trailing: DropdownButton(
                      value: model.language,
                      items: LanguageService.getCodes()
                          .map(
                            (code) => DropdownMenuItem(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: FlagImage(country: code),
                              ),
                              Text(code.toUpperCase()),
                            ],
                          ),
                          value: code,
                        ),
                      )
                          .toList(),
                      onChanged: (dynamic language) {
                        model.changeLanguage(language);
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                buildContent(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}
