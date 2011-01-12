#import "GHCountStatusItemController.h"

@implementation GHCountStatusItemController
@synthesize textLabel;
@synthesize dataSource;
@synthesize singularType;
@synthesize pluralType;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self refreshLabel];
}

- (void)refreshLabel {
  NSUInteger count = [self.dataSource numberOfItemsForStatusItem:self];
  NSString *type = (count == 1) ? self.singularType : self.pluralType;
  self.textLabel.text = [NSString stringWithFormat:@"%i %@",count,type];
}

- (void)dealloc {
  [textLabel release];
  [singularType release];
  [pluralType release];
  [super dealloc];
}

@end
