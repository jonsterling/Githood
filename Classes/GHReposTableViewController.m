#import "GHReposTableViewController.h"
#import "GHReposTableModel.h"
#import "GitHubRepository.h"
#import "GHCommitsTableViewController.h"
#import "GHCountStatusItemController.h"
#import "GHSettingsViewController.h"
#import "UIBarButtonItem+Custom.h"

@interface GHReposTableViewController () <GHTableModelDelegate>
@property (nonatomic,retain) GHCountStatusItemController *statusItem;
- (void)showSettings;
- (void)configureToolbar;
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
  
  self.statusItem = [GHCountStatusItemController withSingularType:@"repository"
                                                       pluralType:@"repositories"];
  self.statusItem.dataSource = self.tableModel;
  
  [self configureToolbar];
  
  [self refreshData];
}

- (void)configureToolbar {
  id settings = [UIBarButtonItem settingsItemWithStyle:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(showSettings)];
  
  id flexible = [UIBarButtonItem withSystemItem:UIBarButtonSystemItemFlexibleSpace
                                         target:nil
                                         action:nil];
  id fixed = [UIBarButtonItem withSystemItem:UIBarButtonSystemItemFixedSpace
                                      target:nil
                                      action:nil];
  
  // Since the settings icon is 24.0px wide, so must the fixed item, so as to
  // center the status item
  [fixed setWidth:24.0];
  
  id statusButtonItem = self.statusItem.buttonItem;
  id buttons = [NSArray arrayWithObjects:
                settings,flexible,
                statusButtonItem,
                flexible,fixed,nil];
  [self setToolbarItems:buttons animated:YES];
}

- (void)showSettings {
  id settings = [GHSettingsViewController new];
  id controller = [[UINavigationController alloc] initWithRootViewController:settings];
  [self presentModalViewController:controller animated:YES];
  
  [settings release];
  [controller release];
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
