#import "GHStatusBarButtonController.h"

@implementation GHStatusBarButtonController

+ (id)controller {
  return [[self new] autorelease];
}

- (UIBarButtonItem *)buttonItem {
  return [[[UIBarButtonItem alloc] initWithCustomView:self.view] autorelease];
}

- (void)refreshLabel {
  if ([self class] == [GHStatusBarButtonController class]) {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"subclasses must implement -refreshLabel"
                                 userInfo:nil];
  }
}


@end
