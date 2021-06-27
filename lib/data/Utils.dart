class Utils {
  static List<String> TIME_STR = [
    'just',
    'second(s)',
    'minute(s)',
    'hour(s)',
    'day(s)'
  ];
  static List<int> TIME_INT = [1, 60, 60, 60, 24];

  static bool has_resources(Map<String, bool> resourceFilter) {
    bool ok = false;
    resourceFilter.forEach((resource_type, availability) {
      ok |= availability;
    });
    return ok;
  }

  static String available_resources(Map<String, bool> resourceFilter) {
    String result = "";
    List<String> resources = [];
    resourceFilter.forEach((resource_type, available) {
      if (available) {
        resources.add(resource_type);
      }
    });

    int n = resources.length;
    for (int i = 0; i < n - 1; i++) {
      result += "${resources[i]}, ";
    }
    result += resources[n - 1];

    return result;
  }

  static List<String> time_difference(String oldTime) {
    int currentTime =
        ((new DateTime.now()).millisecondsSinceEpoch / 1000).round();
    int pastTime = int.parse(oldTime);

    int timeDiff = currentTime - pastTime;

    int i = 0;
    while (i < TIME_INT.length) {
      if ((timeDiff / TIME_INT[i]).round() == 0) {
        break;
      }
      timeDiff = (timeDiff / TIME_INT[i++]).round();
    }

    return [timeDiff.toString(), TIME_STR[i], i == 0 ? "now" : "ago"];
  }
}
