class Utils {
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
}
