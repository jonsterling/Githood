@interface UIBarButtonItem (Custom)
+ (id)withImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
+ (id)withTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
+ (id)withSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action;
+ (id)withCustomView:(UIView *)customView;
@end