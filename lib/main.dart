import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasklogin/screens/registration.dart';

import 'cache/shared_handler.dart';
import 'cubit/registration_cubit.dart';
import 'service/registration_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHandler.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Register App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => RegisterCubit(RegisterService()),
        child: RegisterScreen(),
      ),
    );
  }
}
