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

- (id)initWithTableView:(UITableView *)tableView headerView:(id)aHeaderView {
  self = [super init];
  if (self != nil) {
    headerView = [aHeaderView retain];
    tableView.tableHeaderView = headerView;
  } return self;
}

- (void)dealloc {
  [headerView release];
  [super dealloc];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UITableView *)tableView {
  if (tableView.contentOffset.y < 0) {
    [self.headerView removeFromSuperview]; 
    [tableView.backgroundView addSubview:self.headerView];
    self.headerIsDocked = YES;
  }
  
  else if (self.headerIsDocked) {
    [self.headerView removeFromSuperview];
    [tableView addSubview:self.headerView];
    self.headerIsDocked = NO;
  }
}

@end
