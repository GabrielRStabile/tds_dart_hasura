import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'project_constants.dart';
import 'screens/home_page.dart';
import 'use_cases/network_change/no_network_widget.dart';
import 'view_models/home_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        title: 'Lista de Tarefas',
        theme: ProjectConstants.lightTheme,
        darkTheme: ProjectConstants.darkTheme,
        themeMode: ThemeMode.system,
        builder: (context, child) {
          return Column(
            children: [
              Expanded(child: child ?? const SizedBox()),
              const NoNetworkWidget(),
            ],
          );
        },
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
