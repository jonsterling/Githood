#import "GHStatusBarButtonController.h"

@implementation GHStatusBarButtonController

+ (id)controller {
  return [[self new] autorelease];
}

- (UIBarButtonItem *)buttonItem {
  return [[[UIBarButtonItem alloc] initWithCustomView:self.view] autorelease];
}


@end
