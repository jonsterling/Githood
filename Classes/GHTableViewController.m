#import <QuartzCore/QuartzCore.h>
#import "GHTableViewController.h"
#import "GHTableModel.h"

@interface GHTableViewController ()
- (void)configureBars;
@end

@implementation GHTableViewController
@synthesize tableModel;

+ (void)initialize {
  if (self != [GHTableViewController class]) {
    NSAssert1([self conformsToProtocol:@protocol(GHConcreteTableViewController)],
              @"%@ must conform to GHConcreteTableViewController",self);
  }
}

- (void)dealloc {
  [tableModel release];
  [super dealloc];
}

- (id <GHConcreteTableModel>)tableModel {
  if (tableModel == nil) {
    tableModel = [[[[self class] modelClass] alloc] initWithCellProvider:self];
  }
  
  return tableModel;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configureBars];
  
  self.tableView.rowHeight = 65;
  self.tableView.dataSource = self.tableModel;
  self.tableView.delegate = self;
  
  [self.tableModel addTableModelListener:self];  
}

- (void)configureBars {
  UIToolbar *tb = self.navigationController.toolbar;
  UINavigationBar *nb = self.navigationController.navigationBar;
  
  nb.barStyle = UIBarStyleBlack;
  nb.layer.contents = (id)[UIImage imageNamed:@"navigation_bar"].CGImage;  
  
  tb.barStyle = UIBarStyleBlack;
  tb.tintColor = [UIColor colorWithWhite:0.8 alpha:1.0];
  
  id refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                   target:self.tableModel
                                                                   action:@selector(refreshData)];
  self.navigationItem.rightBarButtonItem = refreshButton;
  [refreshButton release];  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.navigationController setToolbarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark LRTableModelEventListener

- (void)tableModelChanged:(LRTableModelEvent *)changeEvent {
  switch (changeEvent.type) {
    case LRTableModelRefreshDataEvent:
      [self.tableView reloadData];
      break;
    case LRTableModelInsertRowEvent:
      [self.tableView insertRowsAtIndexPaths:changeEvent.indexPaths withRowAnimation:UITableViewRowAnimationTop];
      [self.tableView reloadData];
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
