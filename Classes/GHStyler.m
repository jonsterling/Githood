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

+ (UIColor *)gradientLightColor {
  return [UIColor colorWithHue:(216.0/360.0) saturation:0.02 brightness:0.99 alpha:1.0];
}

+ (UIColor *)gradientDarkColor {
  return [UIColor colorWithHue:(217.0/360.0) saturation:0.02 brightness:0.90 alpha:1.0];
}

+ (CGGradientRef)gradient {
  static CGGradientRef gradient = NULL;
  
  if (!gradient) {
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		CGFloat components[3][4];
    
		memcpy(components[0],
           CGColorGetComponents(self.gradientLightColor.CGColor),
           sizeof(CGFloat) * 4);
		memcpy(components[1],
           CGColorGetComponents(self.gradientDarkColor.CGColor),
           sizeof(CGFloat) * 4);
		
		const CGFloat endpoints[2] = {0.0, 1.0};
    
		gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                   (const CGFloat *)components,
                                                   endpoints,2);
		CFRelease(colorSpace);
	}
  
  return gradient;
}

@end
