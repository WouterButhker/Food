import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:student/src/models/settings_model.dart';
import 'package:student/src/theme/app_localizations.dart';
import 'package:student/src/widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("settings")),
      ),

      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(AppLocalizations.of(context).translate("theme")),
            leading: Icon(Icons.wb_sunny),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return _ThemeSelector();
                  });
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate("language")),
            leading: Icon(Icons.language),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return _LanguageSelector();
                  });
            },
          ),
        ],
      ),
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsModel(),
      child: AlertDialog(
        title: Text(AppLocalizations.of(context).translate("theme")),
        content: Consumer<SettingsModel>(
          builder: (context, settingsModel, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile(
                  title: Text(AppLocalizations.of(context).translate("light")),
                  value: "Light",
                  groupValue: settingsModel.theme,
                  onChanged: (val) {
                    settingsModel.setTheme(val, context);
                  },
                ),
                RadioListTile(
                  title: Text(AppLocalizations.of(context).translate("dark")),
                  value: "Dark",
                  groupValue: settingsModel.theme,
                  onChanged: (val) {
                    settingsModel.setTheme(val, context);
                  },
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsModel(),
      child: AlertDialog(
        title: Text(AppLocalizations.of(context).translate("select_language")),
        content: Consumer<SettingsModel>(
          builder: (context, settingsModel, child) {
            return Container(
              width: 300, // TODO: magic number
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: <Widget>[
                  RadioListTile(
                    title: Text(AppLocalizations.of(context).translate("en")),
                    value: "en",
                    groupValue: settingsModel.language,
                    onChanged: (val) {
                      settingsModel.setLanguage(val, context);
                    },
                  ),
                  RadioListTile(
                    title: Text(AppLocalizations.of(context).translate("nl")),
                    value: "nl",
                    groupValue: settingsModel.language,
                    onChanged: (val) {
                      settingsModel.setLanguage(val, context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
