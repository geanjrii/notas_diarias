// ignore_for_file: public_member_api_docs

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notas_diarias/data_layer/data_layer.dart';
import 'package:notas_diarias/domain_layer/domain_layer.dart';
import 'package:notas_diarias/feature_layer/dailyNotes/cubit/home_cubit.dart';

class MockAnnotationRepository extends Mock implements AnnotationRepository {}

void main() {
  late HomeCubit homeCubit;
  late MockAnnotationRepository mockRepository;

  setUp(() {
    mockRepository = MockAnnotationRepository();
    homeCubit = HomeCubit(repository: mockRepository);
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit', () {
    const mockAnnotation = Annotation(
      title: 'Test Title',
      description: 'Test Description',
      date: '01/01/2022 12:00:00',
    );

    test('initial state is correct', () {
      expect(homeCubit.state, const HomeState());
    });

    blocTest<HomeCubit, HomeState>(
      'emits correct state when onDeleted is called',
      setUp: () {
        when(() => mockRepository.deleteAnnotation(1)).thenAnswer((_) async {
          return Future.value(1);
        });
        when(() => mockRepository.fetchAnnotations())
            .thenAnswer((_) async => []);
      },
      build: () => homeCubit,
      act: (cubit) => cubit.onDeleted(1),
      verify: (_) {
        verify(() => mockRepository.deleteAnnotation(1)).called(1);
        verify(() => mockRepository.fetchAnnotations()).called(1);
      },
      expect: () => [const HomeState()],
    );

    blocTest<HomeCubit, HomeState>(
      'emits correct state when fetchAnnotation is called',
      setUp: () => when(() => mockRepository.fetchAnnotations())
          .thenAnswer((_) async => []),
      build: () => homeCubit,
      act: (cubit) => cubit.fetchAnnotation(),
      verify: (_) {
        verify(() => mockRepository.fetchAnnotations()).called(1);
      },
      expect: () => [const HomeState()],
    );

    blocTest<HomeCubit, HomeState>(
      'emits correct state when register is called with anotacao null',
      build: () => homeCubit,
      act: (cubit) => cubit.register(anotacao: null),
      expect: () => [
        const HomeState(saveOrUpdate: 'Salvar', title: '', description: ''),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits correct state when register is called with anotacao not null',
      build: () => homeCubit,
      act: (cubit) => cubit.register(anotacao: mockAnnotation),
      expect: () => [
        const HomeState(
            saveOrUpdate: 'Atualizar',
            title: 'Test Title',
            description: 'Test Description'),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits correct state when onTitleChanged is called',
      build: () => homeCubit,
      act: (cubit) => cubit.onTitleChanged('New Title'),
      expect: () => [
        const HomeState(title: 'New Title'),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits correct state when onDescriptionChanged is called',
      build: () => homeCubit,
      act: (cubit) => cubit.onDescriptionChanged('New Description'),
      expect: () => [
        const HomeState(description: 'New Description'),
      ],
    );
  });
}
