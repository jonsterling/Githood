#import "GHChangesStatusItemController.h"

@implementation GHChangesStatusItemController
@synthesize textLabel;
@synthesize dataSource;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self refreshLabel];
}

- (void)refreshLabel {
  NSUInteger mods = [self.dataSource numberModifiedForStatusItem:self];
  NSUInteger adds = [self.dataSource numberAddedForStatusItem:self];
  NSUInteger dels = [self.dataSource numberRemovedForStatusItem:self];
  
  self.textLabel.text = [NSString stringWithFormat:@"%u %@, %u %@, %u %@",
                         mods,@"modified",
                         adds,@"added",
                         dels,@"removed"];
}

- (void)dealloc {
  [textLabel release];
  [super dealloc];
}

@end
