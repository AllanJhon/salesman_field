
class SharedPreferencesKeys {
  /// boolean
  /// 用于欢迎页面. 只有第一次访问才会显示. 或者手动将这个值设为false
  static String showWelcome = 'loginWelcone';

  static String userInfo='userInfo';//存放当前登录用户
  
  static String isLogin='isLogin';//存放当前登录用户
  /// json 
  /// 用于存放搜索页的搜索数据.
  /// [{
  ///  name: 'name'
  ///  
  /// }]
  static String searchHistory = 'searchHistory';
}