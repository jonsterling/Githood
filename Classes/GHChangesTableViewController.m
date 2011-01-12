#import "GHChangesTableViewController.h"
#import "GitHubCommit.h"
#import "GitHubRepository.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubServiceGotCommitDelegate.h"
#import "GHChangesTableModel.h"

@interface GHChangesTableViewController (TypeSpecification)
@property (nonatomic,readonly) GHChangesTableModel *tableModel;
@end

@implementation GHChangesTableViewController
@synthesize commit;
@synthesize repository;

- (void)dealloc {
  [self releaseProperties];
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
  
  [self.tableModel refreshData];
}

- (void)configureCell:(UITableViewCell *)cell forObject:(id)object atIndexPath:(NSIndexPath *)path {
  cell.textLabel.text = object;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


@end
