import 'package:flutter/material.dart';
import 'UserPage/user.dart';
import 'Library/libary.dart';
import 'LibrarianPage/librarian_detail.dart';
import 'BookPage/book.dart';



class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {


  int currentTab = 0;
  final List<Widget> screens =[
    user(),
    libary(),
    librariandetail(),
    book()

  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = user();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = user();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 0 ? Colors.blue : Colors.red,
                        ),
                        Text(
                          'User Detail',
                          style: TextStyle(color: currentTab == 0 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = libary();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_add,
                          color: currentTab == 1 ? Colors.blue : Colors.green,
                        ),
                        Text(
                          'Libary',
                          style: TextStyle(color: currentTab == 1 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],

              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = book();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book,
                          color: currentTab == 4 ? Colors.blue : Colors.yellowAccent,
                        ),
                        Text(
                          'Book',
                          style: TextStyle(color: currentTab == 4 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = librariandetail();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: currentTab == 3 ? Colors.blue : Colors.orange,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(color: currentTab == 3 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}
