import 'package:rxdart/rxdart.dart';

class BaseBloc {
  final BehaviorSubject<bool> isLoading = BehaviorSubject<bool>.seeded(false);

  void dispose() {
    isLoading.close();
  }
}
