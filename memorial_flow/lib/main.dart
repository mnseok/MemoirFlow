import 'package:flutter/material.dart';
import 'package:memorial_flow/screens/main.screen.dart';
import 'package:memorial_flow/screens/group.screen.dart';
import 'package:memorial_flow/screens/profile.screen.dart';
import 'package:memorial_flow/screens/write.screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://esrvbiydhlrulgpajcdk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVzcnZiaXlkaGxydWxncGFqY2RrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTM1Mzg2NzIsImV4cCI6MjAwOTExNDY3Mn0.hXwAopE97t-m_SyhTIBUSInNCQYu3_Jpf6ny9ChDnB0',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Memoir Flow'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(date: '3월 1일'),
    const GroupScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            widget.title,
            style: const TextStyle(
                fontFamily: 'OoohBaby',
                fontSize: 30,
                fontWeight: FontWeight.w700),
          ),

          // leading: IconButton(
          //     icon: Icon(Icons.menu), onPressed: () => {print("hi")}),
        ),
        endDrawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OoohBaby',
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const Write(data: 'Write Screen mockup')),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.border_color),
        ), // This trailing comma makes auto-formatting nicer for build methods.

        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Group',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
