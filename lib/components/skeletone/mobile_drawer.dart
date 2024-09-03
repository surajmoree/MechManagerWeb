import 'package:flutter/material.dart';

class MobileDrawer extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Drawer(
      
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
       Material(
               color: Colors.black,
              child: InkWell(
                onTap: (){
                  /// Close Navigation drawer before
                  Navigator.pop(context);
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()),);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      bottom: 24
                  ),
                  child: Column(
                    children: [
                           
                Image.asset(
                  'assets/icons/mech-logo.png', 
                ),
                    ],
                  ),
                ),
              ),
            ),


            SizedBox(height: 5),
             SingleChildScrollView(
                child: Column(
                  children: [
                    MobileDrawerItem(
                      image: 'assets/icons/user-blue.png',
                      title: 'Dashboard',
                      route: '/dashboard_page',
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/dashboard_page');
                      },
                    ),
                    MobileDrawerItem(
                      image: 'assets/icons/jobcard-active.png',
                      title: 'Job Card',
                      route: '/job_sheet_listing',
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/job_sheet_listing');
                       
                      },
                    ),
                    MobileDrawerItem(
                      image: 'assets/icons/estimate.png',
                      title: 'Estimate',
                      route: '/estimate',
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/estimate');
                      },
                    ),
                    MobileDrawerItem(
                      image: 'assets/Icons/invoice.png',
                      title: 'Invoice',
                      route: '/invoice',
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/invoice');
                      },
                    ),
                    MobileDrawerItem(
                        image: 'assets/Icons/jobcard.png',
                        title: 'Dashboard',
                        route: '/dashboard',
                        onTap: (){}),
                    MobileDrawerItem(
                        image: 'assets/Icons/jobcard.png',
                        title: 'Job Card',
                        route: '/job_sheet_listing',
                        onTap: (){}),
                    MobileDrawerItem(
                        image: 'assets/Icons/estimate.png',
                        title: 'Estimate',
                        route: '/estimate',
                        onTap: (){}),
                    MobileDrawerItem(
                        image: 'assets/Icons/invoice.png',
                        title: 'Invoice',
                        route: '/estimate',
                        onTap: (){}),
                    MobileDrawerItem(
                        image: 'assets/Icons/jobcard.png',
                        title: 'Job Card',
                        route: '/job_sheet_listing',
                        onTap:() {
                          
                        },),
                    MobileDrawerItem(
                        image: 'assets/Icons/estimate.png',
                        title: 'Estimate',
                        route: '/estimate',
                        onTap:() {
                          
                        },),
                    MobileDrawerItem(
                        image: 'assets/Icons/setting.png',
                        title: 'Settings',
                        route: '/estimate',
                        onTap: () {
                          
                        },
                       ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black, // Define your black color
                      ),
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.white),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14), // Minimized font size
                        ),
                       
                      ),
                    ),
                  ],
                ),
              ),
    ],
  ),
);
  }
}



class MobileDrawerItem extends StatelessWidget {
  final String image;
  final String title;
  final String route;
  final VoidCallback onTap;

  const MobileDrawerItem({
    required this.image,
    required this.title,
    required this.route,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width < 600 ? 20 : 24;
    return ListTile(
      selectedColor: Colors.grey[200], 
      leading: SizedBox(
        width: imageSize, 
        height: imageSize,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          color: Colors.black, 
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 14), 
      ),
      onTap: () {
        onTap();
        Navigator.pushNamed(context, route);
      },
    );
  }
}
