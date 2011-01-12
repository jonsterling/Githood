#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)

+ (id)withImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
  return [[[self alloc] initWithImage:image style:style target:target action:action] autorelease];
}

+ (id)withTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
  return [[[self alloc] initWithTitle:title style:style target:target action:action] autorelease];
}

+ (id)withSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action {
  return [[[self alloc] initWithBarButtonSystemItem:systemItem target:target action:action] autorelease];
}

+ (id)withCustomView:(UIView *)customView {
  return [[[self alloc] initWithCustomView:customView] autorelease];
}

@end
