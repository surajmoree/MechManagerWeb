import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../base_layout.dart';


class InvoicePage extends StatefulWidget {
  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDrawerOpen = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
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

  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'MechManager Admin',
      closeDrawer: _toggleDrawer,
      isDrawerOpen: _isDrawerOpen,
      body: Center(
        child: Text('Invoice page'),
      ),
    );
  }
}

