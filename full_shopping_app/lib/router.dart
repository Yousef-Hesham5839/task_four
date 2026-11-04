import 'package:go_router/go_router.dart';
import 'login_page.dart' ;
import 'home_page.dart' ;
import 'products_page.dart';
import 'test.dart';
// const widgets can be reused across rebuilds, reducing widget allocations and rebuild work.
final router = GoRouter(
    initialLocation: "/login",
    redirect: (context,state){
      var path = state.matchedLocation;
      if(path.startsWith("/home") && !Database.isLoggedIn){
        return "/login";
      }
      return null ;
    },
    routes: [
  GoRoute(path: "/login",builder: (context,state)=>const LoginPage()),
  GoRoute(path: "/home",builder: (context,state)=>HomePage() ,
  routes: [
    GoRoute(path: 'products',builder: (context,state)=>ProductsPage())
  ])
]);

