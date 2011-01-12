#import "GHStatusBarButtonController.h"
#import "UIBarButtonItem+Custom.h"

@implementation GHStatusBarButtonController

+ (id)controller {
  return [[self new] autorelease];
}

- (UIBarButtonItem *)buttonItem {
  return [UIBarButtonItem withCustomView:self.view];
}

- (void)refreshLabel {
  if ([self class] == [GHStatusBarButtonController class]) {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"subclasses must implement -refreshLabel"
                                 userInfo:nil];
  }
}


@end
