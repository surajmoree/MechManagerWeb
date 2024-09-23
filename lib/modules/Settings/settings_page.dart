import 'package:flutter/material.dart';
import 'package:mech_manager/base_layout.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/job_sheet_listing');
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      if (_isDrawerOpen) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        body: Center(
          child: Text('Setting Page'),
        ),
        title: 'MechManager Admin',
        closeDrawer: _toggleDrawer,
        isDrawerOpen: _isDrawerOpen,
        activeRouteNotifier: activeRouteNotifier);
  }
}
