
import 'package:flutter/material.dart';
import 'package:localsaveimage/controller/data.dart';
import 'package:localsaveimage/controller/sqlhelper.dart';
import 'package:localsaveimage/view/home_page.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await sqlHelper().initiateDb();
  await mydata().requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>mydata() ,
      builder:(context, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:HomePage(),
      ),
    );
  }
}

