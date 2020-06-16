import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'languages_screen.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool lockInBackground = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: 'Account',
              tiles: [
                SettingsTile(
                  title: 'Phone number',
                  leading: Icon(Icons.phone),
                ),
                SettingsTile(
                  title: 'Email',
                  leading: Icon(Icons.email),
                ),
                SettingsTile(
                  title: 'Sign out',
                  leading: Icon(Icons.exit_to_app),
                ),
              ],
            ),
            SettingsSection(
              title: 'Common',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LanguagesScreen(),
                      ),
                    );
                  },
                ),
                SettingsTile(
                  title: 'Change password',
                  leading: Icon(MdiIcons.formTextboxPassword),
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => // change password screen,
                    //   ),
                    // );
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'Misc',
              tiles: [
                SettingsTile(
                  title: 'Terms of Service',
                  leading: Icon(Icons.description),
                ),
                SettingsTile(
                  title: 'Privacy',
                  leading: Icon(Icons.security),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
