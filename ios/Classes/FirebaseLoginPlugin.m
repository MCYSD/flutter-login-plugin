#import "FirebaseLoginPlugin.h"
#if __has_include(<firebase_login/firebase_login-Swift.h>)
#import <firebase_login/firebase_login-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "firebase_login-Swift.h"
#endif

@implementation FirebaseLoginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFirebaseLoginPlugin registerWithRegistrar:registrar];
}
@end
