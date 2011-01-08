#import "GHReposTableViewController.h"
#import "GHReposTableModel.h"
#import "GitHubRepository.h"
#import "GHCommitsTableViewController.h"

@implementation GHReposTableViewController

+ (Class)modelClass {
  return [GHReposTableModel class];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Repositories";
  self.tableView.rowHeight = 65; 
  
  self.tableModel.username = @"jonsterling";
  [self.tableModel refreshData];
}

#pragma mark -
#pragma mark LRTableModelCellProvider

- (void)configureCell:(UITableViewCell *)cell forObject:(id <GitHubRepository>)object atIndexPath:(id)path {
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  cell.textLabel.text = object.name;
  cell.detailTextLabel.text = object.owner;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  GHCommitsTableViewController *commitsController = [GHCommitsTableViewController new];
  commitsController.repository = [self.tableModel objectAtIndexPath:indexPath];
  
  [self.navigationController pushViewController:commitsController animated:YES];
  
  [commitsController release];
}

@end
