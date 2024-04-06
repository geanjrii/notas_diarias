// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_diarias/feature_layer/dailyNotes/cubit/home_cubit.dart';
import 'package:notas_diarias/feature_layer/dailyNotes/view/components/annotation_register.dart';

class ListaTarefas extends StatelessWidget {
  const ListaTarefas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final anotacao = state.annotations[index];
            return Card(
              child: ListTile(
                title: Text(anotacao.title!),
                subtitle: Text('${anotacao.date!} - ${anotacao.description}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //edit button
                    GestureDetector(
                      onTap: () {
                        context.read<HomeCubit>().register(anotacao: anotacao);
                        showDialog(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<HomeCubit>(),
                                child: AnnotationRegister(
                                  anotacao: anotacao,
                                ),
                              );
                            });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    //delete button
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<HomeCubit>()
                            .onDeleted(anotacao.id!);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: state.annotations.length,
        );
      },
    );
  }
}
