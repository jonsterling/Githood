#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

+ (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier {
  return [[[self alloc] initWithStyle:style reuseIdentifier:identifier] autorelease];
}

@end
