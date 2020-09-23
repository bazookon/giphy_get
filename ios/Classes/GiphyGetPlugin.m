#import "GiphyGetPlugin.h"
#if __has_include(<giphy_get/giphy_get-Swift.h>)
#import <giphy_get/giphy_get-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "giphy_get-Swift.h"
#endif

@implementation GiphyGetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGiphyGetPlugin registerWithRegistrar:registrar];
}
@end
