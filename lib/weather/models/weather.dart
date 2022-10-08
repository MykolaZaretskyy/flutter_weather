import 'package:equatable/equatable.dart';

class Temperature extends Equatable {
  const Temperature({required this.value});
  
  final double value;
  
  @override
  List<Object?> get props => [value];
}