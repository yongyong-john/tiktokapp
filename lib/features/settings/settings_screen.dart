import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokapp/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  void _onNotificationChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notification = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale("ko"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            // NOTE: AnimatedBuilder를 사용하면 해당 widget에 해당하는 부분만 새로고침 됨
            // AnimatedBuilder(
            //   animation: videoConfig,
            //   builder: (context, child) => SwitchListTile.adaptive(
            //     // value: videoConfig.autoMute,
            //     value: videoConfig.value,
            //     onChanged: (value) {
            //       // videoConfig.toggleAutoMute();
            //       videoConfig.value = !videoConfig.value;
            //     },
            //     title: const Text('Auto Mute'),
            //     subtitle: const Text('Videos will be muted by default.'),
            //   ),
            // ),
            SwitchListTile.adaptive(
              value: context.watch<PlaybackConfigViewModel>().muted,
              onChanged: (value) => context.read<PlaybackConfigViewModel>().setMuted(value),
              title: const Text('Auto Mute'),
              subtitle: const Text('Videos will be muted by default.'),
            ),
            SwitchListTile.adaptive(
              value: context.watch<PlaybackConfigViewModel>().autoPlay,
              onChanged: (value) => context.read<PlaybackConfigViewModel>().setAutoPlay(value),
              title: const Text('Auto Play'),
              subtitle: const Text('Videos will be played by default.'),
            ),
            // NOTE: adaptive는 디바이스 OS에 따라 맞는 UI를 보여줌 Material or Cupertino
            SwitchListTile.adaptive(
              value: _notification,
              onChanged: _onNotificationChanged,
              title: const Text('Enable notification'),
            ),
            CheckboxListTile.adaptive(
              value: _notification,
              onChanged: _onNotificationChanged,
              title: const Text('Enable notification'),
            ),
            ListTile(
              onTap: () async {
                if (!mounted) return;
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2025),
                );
                if (kDebugMode) {
                  print(date);
                }
                if (!mounted) return;
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }
                if (!mounted) return;
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2025),
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text("What is your birthday?"),
            ),
            // NOTE: 해당 Dialog에서 제공하는 View License는 사용하는 Open source license 정보를 안내
            const AboutListTile(),
            ListTile(
              title: const Text("Log out (iOS / bottom)"),
              textColor: Colors.red,
              onTap: () {
                // NOTE: ModalPopup은 외부를 선택하면 사라지고 AlertDialog는 사라지지 않음 버튼 선택이 반드시 필요함.
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are you sure?"),
                    message: const Text("Please don't go"),
                    actions: [
                      CupertinoActionSheetAction(
                        child: const Text("Not log out"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes please"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (iOS)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Please don't go"),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text("No"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (Android)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Please don't go"),
                    actions: [
                      TextButton(
                        child: const Text("No"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
