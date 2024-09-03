import 'package:flutter/material.dart';

import 'config/colors.dart';

class MainLayout extends StatefulWidget {
  final Widget? drawer;
  final Widget? body;



  MainLayout(
      {super.key,
      this.drawer,
      this.body
    
 });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool isFabExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          //centerTitle: true,
        
          centerTitle: false,
          elevation: 0,
          backgroundColor: blackColor,
          automaticallyImplyLeading: false,
         

          actions: const [


            HumbergerIconButton()
          ],
        ),
        drawer: widget.drawer,
        body: widget.body,
       
        
              );
  }
}

class HumbergerIconButton extends StatelessWidget {
  const HumbergerIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    // return Builder(builder: (context) {
    // return Padding(
    //     padding: const EdgeInsets.only(right: 18),
    //     child: 
    //     BlocBuilder<ProfileSectionBloc, ProfileSectionState>(
    //         builder: (context, state) {
    //       final profile = state.profileModel!.companyLogo.toString();

          return 
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/profile_info_page');
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ProfilePage()));
              // context.read<ProfileSectionBloc>().add(const FetchProfileInfo());
            },
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 16,
              child: ClipOval(
                  child: SizedBox.fromSize(
                size: const Size.fromRadius(16),
                child: 

                    Image.asset(
                        "assets/icons/user-blue.png",
                        height: 25,
                        width: 25,
                        color: blackColor,
                      ),
              )),
            
            ),
          );
        // }));
  
  }
}
