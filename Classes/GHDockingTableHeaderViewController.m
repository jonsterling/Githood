#import "GHDockingTableHeaderViewController.h"

@interface GHDockingTableHeaderViewController ()
@property (nonatomic,assign) BOOL headerIsDocked;
@end

@implementation GHDockingTableHeaderViewController
@synthesize headerView;
@synthesize headerIsDocked;

+ (id)withTableView:(UITableView *)tableView headerView:(id)headerView  {
  return [[self alloc] initWithTableView:tableView headerView:headerView];
}

- (id)initWithTableView:(UITableView *)aTableView headerView:(id)aHeaderView {
  self = [super init];
  if (self != nil) {
    headerView = [aHeaderView retain];
    aTableView.tableHeaderView = headerView;
  } return self;
}

- (void)scrollViewDidScroll:(UITableView *)scrollView {
  if (scrollView.contentOffset.y < 0) {
    [self.headerView removeFromSuperview]; 
    [scrollView.backgroundView addSubview:self.headerView];
    self.headerIsDocked = YES;
  }
  
  else if (self.headerIsDocked) {
    [self.headerView removeFromSuperview];
    [scrollView addSubview:self.headerView];
    self.headerIsDocked = NO;
  }
}

- (void)dealloc {
  [headerView release];
  [super dealloc];
}

@end
