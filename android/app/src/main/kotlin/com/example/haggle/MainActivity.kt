package com.example.haggle

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    
//MainActivity provideSplashScreen will present the custom splash screen

@Override

@Nullable

public SplashScreen provideSplashScreen() {

return new SplashScreenWithTransition();

}


}
