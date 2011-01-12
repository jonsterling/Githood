#import "GHGroupedTableView.h"
#import "GHStyler.h"
#import <QuartzCore/QuartzCore.h>

@implementation GHGroupedTableView

- (id)initWithFrame:(CGRect)aFrame style:(UITableViewStyle)aStyle {
	self = [super initWithFrame:aFrame style:aStyle];
	if (self != nil) {
		self.backgroundColor = [UIColor clearColor];
		self.opaque = YES;
		self.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
  
	return self;
}

- (void)drawRect:(CGRect)rect {
	if (self.opaque) {
		CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint start = self.bounds.origin;
    CGPoint end = CGPointMake(CGRectGetMaxX(self.bounds),
                              CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(context,[GHStyler gradient],start,end,0);
	}
}

@end