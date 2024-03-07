part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}


class RegisterLoading extends AppState {}
class RegisterSuccess extends AppState {}
class RegisterFailed extends AppState {}


class LoginLoading extends AppState {}
class LoginSuccess extends AppState {}
class LoginFailed extends AppState {}


class PickerImageLoading extends AppState {}
class PickerImageSuccess extends AppState {}
class PickerImageFailed extends AppState {}

class SendingMessageLoading extends AppState {}
class SendingMessageSuccess extends AppState {}
class SendingMessageFailed extends AppState {}

class ControllerCleared extends AppState {}