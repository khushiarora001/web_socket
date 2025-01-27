abstract class OrderState {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);

  @override
  List<Object> get props => [message];
}
