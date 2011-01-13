#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@interface GHStyler : NSObject
+ (void)styleNavigationController:(UINavigationController *)controller;
+ (void)styleNavigationBar:(UINavigationBar *)bar;
+ (void)styleToolbar:(UIToolbar *)bar;

+ (UIColor *)gradientLightColor;
+ (UIColor *)gradientDarkColor;
+ (CGGradientRef)gradient;
@end
