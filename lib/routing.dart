import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickity/bloc/home_cubits/event_cubit.dart';
import 'package:tickity/bloc/signup_cubit.dart';
import 'package:tickity/view/allevents.dart';
import 'package:tickity/view/home.dart';
import 'package:tickity/view/loginpage.dart';
import 'package:tickity/view/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:tickity/view/signuppage2.dart';
import 'package:tickity/view/splash.dart';
import 'bloc/home_cubits/category_cubit.dart';
import 'bloc/home_cubits/collection_cubit.dart';
import 'bloc/login_cubit.dart';
import 'di_container.dart';

SignupCubit _signupCubit = locator<SignupCubit>();
EventCubit _eventCubit =  locator<EventCubit>();

class Routing {
  // static late final SharedPreferences prefs;

// GoRouter configuration
  static final router = GoRouter(
    routes: [
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: 'loginPage',
        path: '/loginPage',
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          ),
        ),
      ),
      GoRoute(
        name: 'signupPage',
        path: '/signupPage',
        builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: BlocProvider.value(
              value: _signupCubit,
              child: const SignupPage(),
            )),
      ),
      GoRoute(
        name: 'signupPage2',
        path: '/signupPage2',
        builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: BlocProvider.value(
              value: _signupCubit,
              child: const SignupPage2(),
            )),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => CollectionCubit(),
                ),
                BlocProvider(
                  create: (context) => CategoryCubit(),
                ),
                BlocProvider.value(
                  value: _eventCubit,
                ),
              ],
              child: const Home(),
            )),
      ),
      GoRoute(
        name: 'allEvents',
        path: '/allEvents',
        builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: BlocProvider.value(
              value: _eventCubit,
              child: const AllEvents(),
            )),
      ),
    ],
    redirect: (context, state) {
      if (['/signupPage'].contains(state.uri.toString())) {
        _signupCubit = SignupCubit();
      }
      return null;
    },
  );
}
