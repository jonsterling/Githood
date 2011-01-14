#import <QuartzCore/QuartzCore.h>
#import "GHTableViewController.h"
#import "GHTableModel.h"
#import "GHRefreshController.h"
#import "UIBarButtonItem+Custom.h"
#import "GHStyler.h"
#import "GHDockingTableHeaderViewController.h"
#import "GHHeaderView.h"

@interface GHTableViewController () {
  BOOL hasRefreshedOnLoad;
}

@property (nonatomic,retain,readwrite) GHRefreshController *refreshItem;
@property (nonatomic,retain,readwrite) GHDockingTableHeaderViewController *headerController;
@end

@implementation GHTableViewController
@synthesize headerController;
@synthesize tableModel;
@synthesize refreshItem;

+ (void)initialize {
  if (self != [GHTableViewController class]) {
    NSAssert1([self conformsToProtocol:@protocol(GHConcreteTableViewController)],
              @"%@ must conform to GHConcreteTableViewController",self);
  }
}

- (void)dealloc {
  [tableModel release];
  [refreshItem release];
  [headerController release];
  [super dealloc];
}

- (id <GHConcreteTableModel>)tableModel {
  if (tableModel == nil) {
    tableModel = [[[[self class] modelClass] alloc] initWithCellProvider:self];
  } return tableModel;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [GHStyler styleNavigationController:self.navigationController];
  
  self.refreshItem = [GHRefreshController withTarget:self
                                                       action:@selector(refreshData) 
                                                     delegate:self];
  
  self.tableView.rowHeight = 65;
  self.tableView.dataSource = self.tableModel;
  self.tableView.delegate = self;
  self.tableModel.delegate = self;
  
  [self.tableModel addTableModelListener:self];
  
  if ([self respondsToSelector:@selector(headerText)]) {
    id headerView = [GHHeaderView withText:[self performSelector:@selector(headerText)]];
    self.headerController = [GHDockingTableHeaderViewController withTableView:self.tableView
                                                                   headerView:headerView];
  }
}

- (void)setSoleToolbarItem:(UIBarButtonItem *)item {
  id flexibleSpace = [UIBarButtonItem withSystemItem:UIBarButtonSystemItemFlexibleSpace
                                              target:nil
                                              action:nil];
  id buttons = [NSArray arrayWithObjects:flexibleSpace,item,flexibleSpace,nil];
  [self setToolbarItems:buttons animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if (!hasRefreshedOnLoad) {
    [self refreshData];
    hasRefreshedOnLoad = YES;
  }
}

- (void)refreshData {
  [self.tableModel refreshData];
  self.refreshItem.state = GHLoadingInProgressState;
}

#pragma mark -
#pragma mark GHRefreshControllerDelegate

- (void)placeRefreshButton:(UIBarButtonItem *)refreshButton {
  [self.navigationItem setRightBarButtonItem:refreshButton animated:YES];
}


#pragma mark -
#pragma mark GHTableModelDelegate 

- (void)dataDidChange {
  self.refreshItem.state = GHLoadingCompleteState;
}

- (void)refreshFailed {
  self.refreshItem.state = GHLoadingCompleteState;
}

#pragma mark -
#pragma mark LRTableModelEventListener

- (void)tableModelChanged:(LRTableModelEvent *)changeEvent {
  switch (changeEvent.type) {
    case LRTableModelRefreshDataEvent:
      [self.tableView reloadData];
      break;
    case LRTableModelInsertRowEvent:
      [self.tableView insertRowsAtIndexPaths:changeEvent.indexPaths 
                            withRowAnimation:UITableViewRowAnimationTop];
      [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows 
                            withRowAnimation:UITableViewRowAnimationNone];
      break;
    case LRTableModelInsertSectionEvent:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:changeEvent.indexPath.section] 
                    withRowAnimation:UITableViewRowAnimationMiddle];
      break;
    default:
      [self.tableView reloadData];
      break;
  }
  
}


#pragma mark -
#pragma mark LRTableModelCellProvider

- (id)cellForObjectAtIndexPath:(id)path reuseIdentifier:(NSString *)ident {
  return [UITableViewCell cellWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
}

- (void)configureCell:(UITableViewCell *)cell forObject:(id)object atIndexPath:(id)path {
  
}


#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.headerController scrollViewDidScroll:scrollView];
}

@end
