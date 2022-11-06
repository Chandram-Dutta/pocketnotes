import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketnotes/auth/presentation/signin_page.dart';
import 'package:pocketnotes/auth/services/auth_services.dart';
import 'package:pocketnotes/home/presentation/home_page.dart';

final pageControllerProvider = Provider<Widget>((ref) {
  return ref.watch(isLoggedInProvider) ? const HomePage() : SignInPage();
});
