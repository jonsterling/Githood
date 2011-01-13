#import "GHWebView.h"
#import "GHStyler.h"

@implementation GHWebView

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextDrawLinearGradient(context,
                              [GHStyler gradient],
                              CGPointZero,
                              CGPointMake(0, rect.size.height),
                              kCGGradientDrawsBeforeStartLocation);
}

@end
