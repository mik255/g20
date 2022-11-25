


import '../../../../../domain/models/results.model.dart';

class ResultsState{}

class ResultsLoading extends ResultsState{}

class ResultsLoaded extends ResultsState{
  final UserResults results;
  ResultsLoaded({required this.results});
}