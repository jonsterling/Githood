#import "GHHeaderView.h"
#import <CoreGraphics/CoreGraphics.h>

static CGFloat kOffset = 10.0;

@interface GHHeaderView ()
@property (nonatomic,retain,readonly) UILabel *label;
- (void)drawBackgroundInRect:(CGRect)rect;
- (void)drawBorderInRect:(CGRect)rect;
@end

@implementation GHHeaderView
@synthesize text;
@synthesize label;

- (id)init {
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  return [self initWithFrame:(CGRect){{0,0},{width,100.0}}];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self != nil) {
    label = [[UILabel alloc] initWithFrame:CGRectMake(kOffset, kOffset, 0.0, 0.0)];
    label.font = [UIFont systemFontOfSize:15.0];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = (CGSize){1.0,1.0};
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    
    [self addSubview:label];
  } return self;
}

+ (id)view {
  return [[self new] autorelease];
}

- (void)setText:(NSString *)string {
  [text autorelease];
  text = [string copy];
  
  self.label.text = self.text;
  CGSize insetSize = CGRectInset(self.bounds, kOffset, kOffset).size;
  CGSize textSize = [self.text sizeWithFont:self.label.font 
                          constrainedToSize:CGSizeMake(insetSize.width, CGFLOAT_MAX)];
  
  self.frame = (CGRect){self.frame.origin,{textSize.width + 2*kOffset,textSize.height + 2*kOffset}};
  self.label.frame = (CGRect){self.label.frame.origin,textSize};
}

- (void)drawRect:(CGRect)rect {
  [self drawBackgroundInRect:self.bounds];
  [self drawBorderInRect:self.bounds];
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
