


import '../../../../../domain/models/results.model.dart';

class ResultsState{}

class ResultsLoading extends ResultsState{}

class ResultsLoaded extends ResultsState{
  final Results results;
  ResultsLoaded({required this.results});
}