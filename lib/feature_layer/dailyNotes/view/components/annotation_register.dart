// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_diarias/data_layer/annotation_api/model/anotacao.dart';
import 'package:notas_diarias/feature_layer/dailyNotes/cubit/home_cubit.dart';

class AnnotationRegister extends StatelessWidget {
  const AnnotationRegister({
    super.key,
    this.anotacao,
  });

  final Annotation? anotacao;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${context.read<HomeCubit>().state.saveOrUpdate} anotação'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //title text field
          TitleTextField(),
          //description text field
          DescriptionTextField(),
        ],
      ),
      actions: [
        //cancel button
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        //save button
        TextButton(
          onPressed: () {
            context
                .read<HomeCubit>()
                .onSubmited(selectedAnnotation: anotacao);
            Navigator.pop(context);
          },
          child: Text(context.read<HomeCubit>().state.saveOrUpdate),
        ),
      ],
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(

      onChanged: (value) =>
          context.read<HomeCubit>().onDescriptionChanged(value),
      controller: TextEditingController(text: context.read<HomeCubit>().state.description),
      decoration: const InputDecoration(
        labelText: 'Descrição',
        hintText: 'Digite a descrição...',
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<HomeCubit>().onTitleChanged(value),
      controller: TextEditingController(text: context.read<HomeCubit>().state.title),
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'Título',
        hintText: 'Digite título...',
      ),
    );
  }
}