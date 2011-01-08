#import "AppDelegate.h"

@implementation AppDelegate
@synthesize window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [window addSubview:navigationController.view];
  [window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

  // Save data if appropriate.
}

- (void)dealloc {

  [window release];
  [navigationController release];
  [super dealloc];
}

@end
