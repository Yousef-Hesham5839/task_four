import 'package:go_router/go_router.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'products_page.dart';
import 'signup_page.dart';
import 'test.dart';

// const widgets can be reused across rebuilds, reducing widget allocations and rebuild work.
// The redirect protects only /home and its nested routes; top-level /signup remains available while logged out.
// In the navigation stack, push adds a page so pop returns to the previous page; go changes the location and replaces the matched page stack.
// Expected experiment results (the navigation flows are documented here, not run in this headless session):
// Test 1: push('/signup') then pop() returns to Login; Login stays mounted while Signup is open.
// Test 2: go('/signup') removes Login ("finish Login"); pop() has no prior Login page and reports that there is nothing to pop.
// Test 3: go('/signup') then go('/login') returns to a newly created Login ("start Login").
// Test 4: push('/signup') then the AppBar back arrow pops Signup and reveals the existing Login.
// With push, Login is not disposed on opening Signup; with go, it is disposed when the location changes.
final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final path = state.matchedLocation;
    if (path.startsWith('/home') && !Database.isLoggedIn) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'products',
          builder: (context, state) => const ProductsPage(),
        ),
      ],
    ),
  ],
);


