#import "GHCommitsTableViewController.h"
#import "GHCommitsTableModel.h"
#import "GitHubCommit.h"
#import "GitHubRepository.h"

@implementation GHCommitsTableViewController
@synthesize repository;

+ (Class)modelClass {
  return [GHCommitsTableModel class];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Commits";
  self.tableView.rowHeight = 65; 
  
  [(GHCommitsTableModel *)self.tableModel setRepository:self.repository];
  [self.tableModel refreshData];
}

- (void)dealloc {
  [repository release];
  [super dealloc];
}

#pragma mark -
#pragma mark LRTableModelCellProvider

- (void)configureCell:(UITableViewCell *)cell forObject:(id <GitHubCommit>)object atIndexPath:(id)path {
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  cell.textLabel.text = object.message;
}


@end
