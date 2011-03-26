#import "GHDockingTableHeaderViewController.h"

@interface GHDockingTableHeaderViewController ()
@property (nonatomic,readonly) UITableView *tableView;
@property (nonatomic,readonly) BOOL isHeaderDocked;
@end

@implementation GHDockingTableHeaderViewController
@synthesize tableView;
@dynamic headerView;
@dynamic isHeaderDocked;

+ (id)withTableView:(UITableView *)tableView headerView:(id)headerView  {
  return [[[self alloc] initWithTableView:tableView headerView:headerView] autorelease];
}

- (id)initWithTableView:(UITableView *)aTableView headerView:(id)aHeaderView {
  self = [super init];
  if (self != nil) {
    tableView = [aTableView retain];
    
    if (tableView.backgroundView == nil) {
      tableView.backgroundView = [[UIView new] autorelease];
    }
    
    tableView.tableHeaderView = aHeaderView;
  }
  
  return self;
}

- (void)dealloc {
  [tableView release];
  [super dealloc];
}

#pragma mark -
#pragma mark State

- (BOOL)isHeaderDocked {
  return self.headerView.superview == self.tableView.backgroundView;
}

- (UIView *)headerView {
  return self.tableView.tableHeaderView;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UITableView *)scrollView {
  if (self.tableView.contentOffset.y < 0) {
    [self.headerView removeFromSuperview]; 
    [self.tableView.backgroundView addSubview:self.headerView];
  }
  
  else if (self.isHeaderDocked) {
    [self.headerView removeFromSuperview];
    [self.tableView insertSubview:self.headerView atIndex:2];
  }
}

@end
