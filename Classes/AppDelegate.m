#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(id)application didFinishLaunchingWithOptions:(id)options {
  [self.window addSubview:self.navigationController.view];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

  // Save data if appropriate.
}

- (void)dealloc {
  [self releaseProperties];
  [super dealloc];
}

@end
