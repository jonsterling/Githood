#import "GHHeaderView.h"
#import <CoreGraphics/CoreGraphics.h>

@interface GHHeaderView ()
- (void)drawBackgroundInRect:(CGRect)rect;
- (void)drawBorderInRect:(CGRect)rect;
@end

@implementation GHHeaderView
@synthesize text;

- (id)init {
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  return [self initWithFrame:(CGRect){{0,0},{width,100.0}}];
}

+ (id)view {
  return [[self new] autorelease];
}

- (void)setText:(NSString *)string {
  [text autorelease];
  text = [string copy];
  
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  [self drawBackgroundInRect:self.bounds];
  [self drawBorderInRect:self.bounds];
  
  UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
  l.text = self.text;
  l.font = [UIFont systemFontOfSize:15.0];
  l.backgroundColor = [UIColor clearColor];
  l.shadowColor = [UIColor whiteColor];
  l.shadowOffset = (CGSize){1.0,1.0};
  l.numberOfLines = 0;
  
  CGRect insetRect = CGRectInset(self.bounds, 10.0, 10.0);
  CGSize textSize = [self.text sizeWithFont:l.font constrainedToSize:insetRect.size];
  CGRect textRect = (CGRect){insetRect.origin, textSize};
  
  [l drawTextInRect:textRect];
  
  [l release];
}

- (void)drawBackgroundInRect:(CGRect)rect {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  
  CGFloat ls[2] = { 0.0, 1.0 };
  CGFloat cs[8] = { 0.98, 0.98, 0.98, 1.0,
                    0.85, 0.85, 0.85, 1.0 };
  size_t num = sizeof(ls)/sizeof(CGFloat);
  
  CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
  CGGradientRef grad = CGGradientCreateWithColorComponents(space,cs,ls,num);
  CGColorSpaceRelease(space);
  CGContextDrawLinearGradient(ctx,grad,
                              CGPointZero,
                              CGPointMake(0, rect.size.height),
                              kCGGradientDrawsBeforeStartLocation);
}

- (void)drawBorderInRect:(CGRect)rect {
  CGContextRef ctx = UIGraphicsGetCurrentContext();

  UIColor *stc = [UIColor colorWithWhite:0.7 alpha:1.0];
  CGContextSetStrokeColorWithColor(ctx,stc.CGColor);
  CGContextSetLineWidth(ctx,2.0);

  CGPoint ps[2] = { CGPointMake(0.0,rect.size.height),
                    CGPointMake(rect.size.width,rect.size.height) };

  CGContextStrokeLineSegments(ctx,ps,1);
}

- (void)dealloc {
  [super releaseProperties];
  [super dealloc];
}

@end
