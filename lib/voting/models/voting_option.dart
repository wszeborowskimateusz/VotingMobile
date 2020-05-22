import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class VotingOption extends Equatable{
  final int id;
  final String name;

  const VotingOption({@required this.id,@required this.name});

  @override
  List<Object> get props => [id, name];
}