#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"ReactNativeFileOpenExample";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};

  NSURL *_Nullable launchURL = [launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
  if (launchURL) {
    [[FileOpeningModule sharedInstance] markFileOpened:launchURL];
  }

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self getBundleURL];
}

- (NSURL *)getBundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

// - (BOOL)application:(UIApplication *)application
//             openURL:(NSURL *)url
//             options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
// {
//   if ([SupportedDeckFormatHelper isSupportedFormatWithUrl:url]) {
//     [[FileOpeningModule sharedInstance] markFileOpened:url];
//     return YES;
//   }
// }

@end
