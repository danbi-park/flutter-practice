import 'package:flutter_riverpod/flutter_riverpod.dart';

// 로그인 타입
enum LoginState { none, activate, deactivate, logout, withdraw }

// 로그인 상태를 변경하고, 변경된 상태를 감지하는 데 사용
class LoginStateNotifier extends StateNotifier<LoginState> {
  LoginStateNotifier() : super(LoginState.none);
  void doActivate() {
    state = LoginState.activate;
  }

  void doDeactivate() {
    state = LoginState.deactivate;
  }
}

// 로그인 상태를 변경하는 Provider
// LoginStateNotifier 클래스의 인스턴스를 생성하여 이 Provider를 초기화하고, 해당 Provider를 통해 로그인 상태를 관리
//  ref.read(loginStateProvider.notifier).doNaverLogin();
final loginStateProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  return LoginStateNotifier();
});

// 로그인 상태에 따라 다른 메시지를 표시하는 Provider
final loginMessageProvider = Provider<String>((ref) {
  final loginState = ref.watch(loginStateProvider);

  switch (loginState) {
    case LoginState.activate:
      return '활성화 상태입니다';
    case LoginState.deactivate:
      return "비활성화 상태입니다.";
    case LoginState.logout:
      return '로그아웃 상태입니다.';
    case LoginState.withdraw:
      return '회원탈퇴 상태입니다.';
    case LoginState.none:
    default:
      return '비로그인 입니다';
  }
});
