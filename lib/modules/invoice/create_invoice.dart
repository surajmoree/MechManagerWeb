import 'package:flutter/material.dart';
import 'package:mech_manager/base_layout.dart';
import '../../config/colors.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({super.key});

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _animationController;
  bool _isDrawerOpen = true;
  List<dynamic> assignMechanicList = [];
  List<dynamic> tasksList = [];
  final ValueNotifier<String> activeRouteNotifier =
      ValueNotifier<String>('/invoice_listing');

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

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      activeRouteNotifier: activeRouteNotifier,
      title: 'MechManager Admin',
      closeDrawer: _toggleDrawer,
      isDrawerOpen: _isDrawerOpen,
      showFloatingActionButton: true,
      routeWidgets: [
        GestureDetector(
          onTap: () {
            activeRouteNotifier.value = "/dashboard_page";
            //  Navigator.pushNamed(context, '/dashboard_page');
            Navigator.of(context).pushReplacementNamed('/dashboard_page');
          },
          child: const Text(
            "Home",
            style: TextStyle(color: blueColor),
          ),
        ),
        const Text(" / "),
        const Text(
          "Job Card",
          style: TextStyle(color: greyColor),
        ),
      ],
      key: _scaffoldKey,
      body: Center(
        child: Text("Invoice"),
      ),
    );
  }
}
