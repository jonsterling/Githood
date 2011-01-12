#import <QuartzCore/QuartzCore.h>
#import "GHTableViewController.h"
#import "GHTableModel.h"
#import "GHRefreshBarButtonController.h"

@interface GHTableViewController ()
@property (nonatomic,retain,readwrite) GHRefreshBarButtonController *refreshItem;
- (void)configureBars;
@end

@implementation GHTableViewController
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
  [super dealloc];
}

- (id <GHConcreteTableModel>)tableModel {
  if (tableModel == nil) {
    tableModel = [[[[self class] modelClass] alloc] initWithCellProvider:self];
  } return tableModel;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configureBars];
  
  self.tableView.rowHeight = 65;
  self.tableView.dataSource = self.tableModel;
  self.tableView.delegate = self;
  self.tableModel.delegate = self;
  
  [self.tableModel addTableModelListener:self];
}

- (void)setSoleToolbarItem:(UIBarButtonItem *)item {
  id flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                   target:nil 
                                                                   action:nil];
  self.toolbarItems = [NSArray arrayWithObjects:flexibleSpace,item,flexibleSpace,nil];
  [flexibleSpace release];
}

- (void)configureBars {
  UIToolbar *tb = self.navigationController.toolbar;
  UINavigationBar *nb = self.navigationController.navigationBar;
  
  nb.barStyle = UIBarStyleBlack;
  nb.layer.contents = (id)[UIImage imageNamed:@"navigation_bar"].CGImage;  
  
  tb.barStyle = UIBarStyleBlack;
  tb.tintColor = [UIColor colorWithWhite:0.8 alpha:1.0];
  
  self.refreshItem = [GHRefreshBarButtonController withTarget:self
                                                       action:@selector(refreshData) 
                                                     delegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)refreshData {
  [self.tableModel refreshData];
  self.refreshItem.state = GHLoadingInProgressState;
}

#pragma mark -
#pragma mark GHRefreshBarButtonDelegate

- (void)placeRefreshButton:(UIBarButtonItem *)refreshButton {
  [self.navigationItem setRightBarButtonItem:refreshButton animated:YES];
}

#pragma mark -
#pragma mark GHTableModelDelegate 

- (void)dataDidChange {
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


@end
