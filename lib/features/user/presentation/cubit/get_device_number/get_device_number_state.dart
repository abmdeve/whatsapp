import 'package:equatable/equatable.dart';

import '../../../domain/entities/contact_entity.dart';

class GetDeviceNumberState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDeviceNumberInitial extends GetDeviceNumberState {
  @override
  List<Object> get props => [];
}

class GetDeviceNumberLoading extends GetDeviceNumberState {
  @override
  List<Object> get props => [];
}

class GetDeviceNumberLoaded extends GetDeviceNumberState {
  final List<ContactEntity> contacts;

  GetDeviceNumberLoaded({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

class GetDeviceNumberFailure extends GetDeviceNumberState {
  @override
  List<Object> get props => [];
}
