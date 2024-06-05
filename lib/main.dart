import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_flutter/features/auth/services/auth_service.dart';
import 'package:amazon_clone_flutter/features/home/screens/home_screen.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:amazon_clone_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: ((context) => UserProvider()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const HomeScreen()
          : const AuthScreen(),
    );
  }
}
