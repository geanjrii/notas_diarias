import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notas_diarias/app/app.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const App());
}
