#import "GHChangesTableViewController.h"
#import "GitHubCommit.h"
#import "GitHubRepository.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubServiceGotCommitDelegate.h"
#import "GHChangesTableModel.h"
#import "GHChangesStatusItemController.h"

#import "GHHeaderView.h"
#import "GHStyler.h"

@interface GHChangesTableViewController ()
@property (nonatomic,retain) GHChangesStatusItemController *statusItem;
@end

@interface GHChangesTableViewController (TypeSpecification)
@property (nonatomic,readonly) GHChangesTableModel *tableModel;
@end

@implementation GHChangesTableViewController
@synthesize commit;
@synthesize repository;
@synthesize statusItem;

- (void)dealloc {
  [commit release];
  [repository release];
  [statusItem release];
  [super dealloc];
}

+ (Class)modelClass {
  return [GHChangesTableModel class];
}

+ (id)withCommit:(id <GitHubCommit>)commit 
  fromRepository:(id <GitHubRepository>)repository {
  return [[[self alloc] initWithCommit:commit 
                        fromRepository:repository]
          autorelease];
}

- (id)initWithCommit:(id <GitHubCommit>)aCommit 
      fromRepository:(id<GitHubRepository>)aRepository {
  self = [super init];
  if (self != nil) {
    commit = [aCommit retain];
    repository = [aRepository retain];
  } return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Commit";
  self.tableModel.commit = self.commit;
  self.tableModel.repository = self.repository;
  
  self.tableView.rowHeight = 44.0f;
  
  GHHeaderView *headerView = [GHHeaderView view];
  headerView.text = self.commit.message;
  
  self.tableView.tableHeaderView = headerView;
  self.tableView.backgroundColor = [GHStyler gradientLightColor];
  
  self.statusItem = [GHChangesStatusItemController controller];
  self.statusItem.dataSource = self.tableModel;
  
  [self setSoleToolbarItem:self.statusItem.buttonItem];
  
  [self refreshData];
}

- (void)configureCell:(UITableViewCell *)cell forObject:(id)object atIndexPath:(NSIndexPath *)path {
  cell.textLabel.text = object;
  cell.textLabel.font = [UIFont boldSystemFontOfSize:(1.2*[UIFont systemFontSize])];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)dataDidChange {
  [super dataDidChange];
  [self.statusItem refreshLabel];
}


@end
