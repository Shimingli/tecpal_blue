#import "TecpalBluePlugin.h"
#if __has_include(<tecpal_blue/tecpal_blue-Swift.h>)
#import <tecpal_blue/tecpal_blue-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tecpal_blue-Swift.h"
#endif

@implementation TecpalBluePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTecpalBluePlugin registerWithRegistrar:registrar];
}
@end
