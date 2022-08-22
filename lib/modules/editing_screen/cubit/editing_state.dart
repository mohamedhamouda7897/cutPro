part of 'editing_cubit.dart';

@immutable
abstract class EditingState {}

class EditingInitial extends EditingState {}

class EditingSuccessState extends EditingState {}

class EditingErrorState extends EditingState {}

class EditingLoadState extends EditingState {}
