import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/create_screen.dart';
import 'package:super_app/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
          //home: child,
        );
      },

      //child: const HomeScreen(),
    );
    //debugShowCheckedModeBanner: false,

    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          //mainAxisAlignment: .center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD02BDD),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD02BDD),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],

          //const SizedBox(height: 15),
          // children: [
          //   const Text('You have pushed the button this many times:'),
          //   Text(
          //     '$_counter',
          //     style: Theme.of(context).textTheme.headlineMedium,
          //   ),
          // ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
