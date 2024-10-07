class AppStrings {
  static const String serverHost1 = 'http://172.16.90.85:8801';
  static const String serverHost2 = 'http://172.16.90.85:8802';
  static const String serverHost3 = 'http://172.16.90.85:8803';
  static const String baseUrlAuth = 'http://dev-f1-api.tornadoinvest.com.vn';
  // static const String baseUrlNews = 'https://dev-f1-api.tornadoinvest.com.vn/api/m';
  static const String baseUrlNews = serverHost2;
  static const String baseUrlSearch = '$serverHost3/api/app';
  static const String baseUrlPublicResource = '$serverHost2/public';
  static const String baseUrlProfile = '$serverHost1/api/app/profile';
  static const String baseUrlConfig = '$serverHost1/api/app/config';
  static const String baseUrlHistoryTransaction = '$serverHost1/api/app/money';

  static const String apiVersion = 'v1';
  // static const String fileUrl = 'https://api.tornadoinvest.com.vn/api/m/v1/cms/files/view?p=';
  static const String fileUrl = '$serverHost2/v1/cms/files/view?p=';
  static const String defaultAvatarLink = 'https://yt3.googleusercontent.com/oN0p3-PD3HUzn2KbMm4fVhvRrKtJhodGlwocI184BBSpybcQIphSeh3Z0i7WBgTq7e12yKxb=s900-c-k-c0x00ffffff-no-rj';
  static const String bannerImageUrl = '$serverHost2/v1/cms/files/view?p=';
  //eKYC
  static String authorizationEKYC =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJGMV9UUkFESU5HX0NNU19VU1IiLCJleHAiOiIzMzI3NjcxNDUzMyIsImlhdCI6IjE3MTkzNjExODgifQ.-IXlwoWgqAiTuOhTsJv-kFafxOZD7JCCNAgJEC_kHRCD-2JBl3j6KJF4BKvQIY8A3OkRGajdOiJp0fdTSaucog';
  static String fptUrlEKYC = 'https://apig.idcheck.xplat.online/';

  static const String zaloOfficialAccount = 'http://zalo.me/885542136996000261?src=qr';
  static const String sseBoardPrice = 'http://172.16.90.85:8803/api/sse/board-price';
  static const String appBoardPrice = 'http://172.16.90.85:8803/api/app/board-price';
}
