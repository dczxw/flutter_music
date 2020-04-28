class FUtils {
  static FUtils inst;

  static FUtils init() {
    if (inst == null) {
      inst = new FUtils();
    }

    return inst;
  }

  formatNumber(num) {

    if (num > 100000000) {
      return (num/100000000).toStringAsFixed(2)+"亿";
    }

    if (num > 10000) {
      return (num/10000).toStringAsFixed(2)+"万";
    }

    if (num > 1000) {
      return (num/1000).toStringAsFixed(2) +"千";
    }
    return num;
  }
}
