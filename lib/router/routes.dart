import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routes {
  static late final FluroRouter router;

  static String root = "/";
  static String homePage = "/HomePage";

  static String blocTestPage = "/HomePage/BlocTestPage";
  static String providerTestPage = "/HomePage/ProviderTestPage";

  static String houseToolPage = "/HomePage/HouseToolPage";

  //
  static String sensingBannerPage = "/HomePage/SensingBannerPage";
  static String fullScreenSensingPage = "/HomePage/FullScreenSensingPage";

  static String videoPage = "/HomePage/VideoPage";
  static String videoListPage = "/HomePage/VideoListPage";
  static String permissionHandlerWidget = "/HomePage/permissionHandlerWidget";

  static void configureRoutes(FluroRouter router) {
    Routes.router = router;

    router.define(root, handler: rootHandler);
    router.define(homePage, handler: homeHandler);
    router.define(blocTestPage, handler: blocTestHandler);
    router.define(providerTestPage, handler: providerTestHandler);
    router.define(houseToolPage, handler: houseToolHandler);

    router.define(sensingBannerPage, handler: sensingBannerHandler);
    router.define(fullScreenSensingPage, handler: fullScreenSensingHandler);
    router.define(videoPage, handler: videoPageHandler);
    router.define(videoListPage, handler: videoListPageHandler);
    router.define(permissionHandlerWidget, handler: permissionHandlerWidgetHandler);

    router.notFoundHandler = emptyHandler;
  }
}
