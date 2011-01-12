#import <QuartzCore/QuartzCore.h>
#import "GHStyler.h"

@implementation GHStyler

+ (void)styleNavigationController:(UINavigationController *)controller {
  [self styleNavigationBar:controller.navigationBar];
  [self styleToolbar:controller.toolbar];
}

+ (void)styleNavigationBar:(UINavigationBar *)bar {
  bar.barStyle = UIBarStyleBlack;
  bar.tintColor = [UIColor blackColor];
  bar.layer.contents = (id)[UIImage imageNamed:@"navigation_bar"].CGImage;  
}

+ (void)styleToolbar:(UIToolbar *)bar {
  bar.barStyle = UIBarStyleBlack;
  bar.tintColor = [UIColor colorWithWhite:0.8 alpha:1.0];
}

@end
