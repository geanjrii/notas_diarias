// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_diarias/data_layer/annotation_api_sql_imp/annotation_api_sql_imp.dart';
import 'package:notas_diarias/domain_layer/annotation_repository.dart';
import 'package:notas_diarias/feature_layer/dailyNotes/view/components/annotation_register.dart';
import 'package:notas_diarias/feature_layer/dailyNotes/view/components/lista_tarefas.dart';

import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
          repository: AnnotationRepository(api: AnnotationApiSqlImp()))..fetchAnnotation(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas anotações'),
        backgroundColor: Colors.lightGreen,
      ),
      body: const   Column(children: [
        Expanded(
          child: ListaTarefas(),
        ),
      ]),
      //add button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeCubit>().register();
          showDialog(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<HomeCubit>(),
                  child: const AnnotationRegister(),
                );
              });
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
