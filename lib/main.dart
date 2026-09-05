import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'services/identity_service.dart';
import 'services/economy_service.dart';
import 'services/follow_service.dart';
import 'ui/screens/wire/wire_feed_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IdentityService()),
        ChangeNotifierProvider(create: (_) => EconomyService()),
        ChangeNotifierProvider(create: (_) => FollowService()),
      ],
      child: const ShrowdApp(),
    ),
  );
}

class ShrowdApp extends StatefulWidget {
  const ShrowdApp({super.key});

  @override
  State<ShrowdApp> createState() => _ShrowdAppState();
}

class _ShrowdAppState extends State<ShrowdApp> {
  bool _isShowingLogo = true;
  bool _isSignUp = true;
  bool _obscurePassword = true;

  final Color _backgroundColor = const Color(0xFF0D0D12);
  final Color _fieldColor = const Color(0xFF16161E);
  final Color _accentColor = const Color(0xFF6366F1);
  final Color _secondaryTextColor = const Color(0xFF8E8E93);

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isShowingLogo = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _backgroundColor,
      ),
      home: Builder(
        builder: (context) {
          if (_isShowingLogo) return _buildLogoScreen();
          return _buildSignupPage(context);
        },
      ),
    );
  }

  Widget _buildLogoScreen() {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/branding/logo.png',
              width: 180,
              height: 180,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.white, size: 100),
            ),
            const SizedBox(height: 24),
            const Text(
              'SHROWD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupPage(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'SHROWD',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'One account. Two identities.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _secondaryTextColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),

              // Toggle (Log in / Sign up)
              Container(
                height: 54,
                decoration: BoxDecoration(
                  color: _fieldColor,
                  borderRadius: BorderRadius.circular(27),
                ),
                child: Row(
                  children: [
                    Expanded(child: _buildToggleButton('Log in', !_isSignUp)),
                    Expanded(child: _buildToggleButton('Sign up', _isSignUp)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              if (_isSignUp) ...[
                _buildFieldLabel('USERNAME'),
                _buildTextField('Pick a public handle'),
                const SizedBox(height: 20),
                _buildFieldLabel('PHONE NUMBER'),
                _buildTextField('+1 (555) 000-0000', keyboardType: TextInputType.phone),
                const SizedBox(height: 20),
              ],

              _buildFieldLabel(_isSignUp ? 'EMAIL ADDRESS' : 'USERNAME OR EMAIL'),
              _buildTextField(
                _isSignUp ? 'your@email.com' : 'Username or email',
                keyboardType: _isSignUp ? TextInputType.emailAddress : TextInputType.text,
              ),
              const SizedBox(height: 20),

              _buildFieldLabel('PASSWORD'),
              _buildTextField(
                '••••••••••••',
                isPassword: true,
                obscureText: _obscurePassword,
                onToggleVisibility: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              const SizedBox(height: 32),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: _accentColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const WireFeedScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accentColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    _isSignUp ? 'Create account' : 'Log in',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              if (_isSignUp)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12121A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.purple.withOpacity(0.5), Colors.blue.withOpacity(0.5)],
                          ),
                        ),
                        child: const Icon(Icons.lock_outline, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Your Wanderer identity',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(4)),
                                  child: Text('ALWAYS PRIVATE',
                                      style: TextStyle(color: _accentColor, fontSize: 8, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Created automatically alongside your account.',
                              style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12, height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isSignUp ? 'Already have an account? ' : 'Don\'t have an account? ',
                      style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 15)),
                  GestureDetector(
                    onTap: () => setState(() => _isSignUp = !_isSignUp),
                    child: Text(
                      _isSignUp ? 'Log in' : 'Sign up',
                      style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                _isSignUp
                    ? 'By signing up, you agree to our Terms of Service and Privacy Policy'
                    : 'By logging in, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(color: _secondaryTextColor.withOpacity(0.7), fontSize: 12),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isActive) {
    return GestureDetector(
      onTap: () => setState(() => _isSignUp = text == 'Sign up'),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? _accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : _secondaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF8E8E93),
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint,
      {bool isPassword = false, bool obscureText = false, VoidCallback? onToggleVisibility, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(color: _fieldColor, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: _secondaryTextColor.withOpacity(0.5),
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: _secondaryTextColor, size: 22),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}
