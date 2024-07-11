import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:whatsapp/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whatsapp/features/home/home_page.dart';
import 'package:whatsapp/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/auth/auth_state.dart';
import 'package:whatsapp/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:whatsapp/routes/on_generate_routes.dart';

import 'features/app/splash/splash_screen.dart';
import 'features/app/theme/style.dart';
import 'firebase_options.dart';
import 'main_injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name: "whatsapp-c2cd8",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider(
          create: (context) => di.sl<CredentialCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetDeviceNumberCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<MessageCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: tabColor,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: backgroundColor,
          dialogBackgroundColor: appBarColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          ),
        ),
        initialRoute: "/",
        onGenerateRoute: OnGenerateRoutes.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(uid: authState.uid);
                }
                return const SplashScreen();
              },
            );
          },
        },
      ),
    );
  }
}
