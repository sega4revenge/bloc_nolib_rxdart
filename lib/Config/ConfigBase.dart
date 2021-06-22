
class ConfigBase {
  static const String API_KEY = "c7e7fcd8-b829-472e-a533-a1dba5328f4a";
  static const String BASE_URL = "http://ddragon.leagueoflegends.com/cdn/11.11.1/data/en_US/";
  static const String FONT_FAMILY = "yoongothic";
}

extension NullSafeBlock<T> on T? {
  void let(Function(T it) runnable) {
    final instance = this;
    if (instance != null) {
      runnable(instance);
    }
  }
}