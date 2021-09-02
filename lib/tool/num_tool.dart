//file:num_tool.dart
///数字转换与显示处理工具类
class NumTool {
  ///数值 保证转换为 int
  ///[解析model时候规避错误]
  static int toIntParse(dynamic data) {
    var _int = 0;
    if (data is int) {
      _int = data;
    } else if (data is String) {
      _int = int.parse(data);
    }
    return _int;
  }

  ///数字显示过滤  100.00w
  static String numStr(int num) {
    if (num >= 100000) {
      return "${(num.toDouble() / 10000).toStringAsFixed(2)}w";
    } else {
      return num.toString();
    }
  }

  ///数字显示过滤  100.0w
  static String numStr1(int num) {
    if (num >= 1000000000) {
      return "${(num.toDouble() / 10000).toStringAsFixed(0)}w";
    } else if (num >= 100000) {
      return "${(num.toDouble() / 10000).toStringAsFixed(1)}w";
    } else {
      return num.toString();
    }
  }

  ///数字显示过滤2  100万
  static String numStr2(int num) {
    if (num >= 100000) {
      return "${(num.toDouble() / 10000).toStringAsFixed(0)}万";
    } else {
      return num.toString();
    }
  }

  ///数字显示过滤  100.0亿
  static String numStr3(int num) {
    if (num >= 100000000) {
      return "${(num.toDouble() / 100000000).toStringAsFixed(0)}亿";
    } else if (num >= 100000) {
      return "${(num.toDouble() / 10000).toStringAsFixed(0)}万";
    } else {
      return num.toString();
    }
  }

  ///数字显示过滤
  static String doubleStr(int num) {
    if (num >= 10) {
      return num.toString();
    } else {
      return "0$num";
    }
  }
}
