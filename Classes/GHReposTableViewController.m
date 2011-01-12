#import "GHReposTableViewController.h"
#import "GHReposTableModel.h"
#import "GitHubRepository.h"
#import "GHCommitsTableViewController.h"
#import "GHCountStatusItemController.h"

@interface GHReposTableViewController () <GHTableModelDelegate>
@property (nonatomic,retain) GHCountStatusItemController *statusItem;
@end

@interface GHReposTableViewController (TypeSpecification)
@property (nonatomic,readonly) GHReposTableModel *tableModel;
@end

@implementation GHReposTableViewController
@synthesize statusItem;

+ (Class)modelClass {
  return [GHReposTableModel class];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Repositories";
  self.tableView.rowHeight = 65;
  
  self.tableModel.username = @"jonsterling";
  self.tableModel.delegate = self;
  
  self.statusItem = [GHCountStatusItemController controller];
  self.statusItem.singularType = @"repository";
  self.statusItem.pluralType = @"repositories";
  self.statusItem.dataSource = self.tableModel;
  
  [self setSoleToolbarItem:self.statusItem.buttonItem];
  
  [self refreshData];
}

#pragma mark -
#pragma mark GHTableModelDelegate

- (void)dataDidChange {
  [super dataDidChange];
  [self.statusItem refreshLabel];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(id)path {
  id <GitHubRepository> repository = [self.tableModel objectAtIndexPath:path];
  id controller = [GHCommitsTableViewController withRepository:repository];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
