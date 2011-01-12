#import "GHDockingTableHeaderViewController.h"

@interface GHDockingTableHeaderViewController ()
@property (readonly) BOOL isHeaderDocked;
@end

@implementation GHDockingTableHeaderViewController
@synthesize headerView;
@dynamic isHeaderDocked;

+ (id)withTableView:(UITableView *)tableView headerView:(id)headerView  {
  return [[self alloc] initWithTableView:tableView headerView:headerView];
}

- (id)initWithTableView:(UITableView *)tableView headerView:(id)aHeaderView {
  self = [super init];
  if (self != nil) {
    headerView = [aHeaderView retain];
    
    if (tableView.backgroundView == nil) {
      tableView.backgroundView = [[UIView new] autorelease];
    }
    
    tableView.tableHeaderView = headerView;
  }
  
  return self;
}

- (void)dealloc {
  [headerView release];
  [super dealloc];
}

#pragma mark -
#pragma mark State

- (BOOL)isHeaderDocked {
  return ![[self.headerView superview] isKindOfClass:[UITableView class]];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UITableView *)tableView {
  if (tableView.contentOffset.y < 0) {
    [self.headerView removeFromSuperview]; 
    [tableView.backgroundView addSubview:self.headerView];
  }
  
  else if (self.isHeaderDocked) {
    [self.headerView removeFromSuperview];
    [tableView addSubview:self.headerView];
  }
}

@end
