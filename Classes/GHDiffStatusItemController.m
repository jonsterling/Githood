#import "GHDiffStatusItemController.h"

@implementation GHDiffStatusItemController
@synthesize textLabel;
@synthesize dataSource;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self refreshLabel];
}

- (void)refreshLabel {
  NSUInteger adds = [self.dataSource linesAddedForStatusItem:self];
  NSUInteger dels = [self.dataSource linesRemovedForStatusItem:self];
  
  self.textLabel.text = [NSString stringWithFormat:@"%u %@, %u %@",
                         adds,@"lines added",
                         dels,@"removed"];

}

@end
