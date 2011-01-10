#import "GHCommitsTableViewController.h"
#import "GHCommitsTableModel.h"
#import "GitHubCommit.h"
#import "GitHubRepository.h"
#import "GHCommitViewController.h"

@interface GHCommitsTableViewController ()
@property (nonatomic, readonly) GHCommitsTableModel *tableModel;
@end


@implementation GHCommitsTableViewController
@dynamic tableModel;

+ (id)withRepository:(id <GitHubRepository>)repository {
  return [[[self alloc] initWithRepository:repository] autorelease];
}

- (id)initWithRepository:(id <GitHubRepository>)aRepository {
  self = [super init];
  if (self != nil) {
    repository = [aRepository retain];
  } return self;
}

+ (Class)modelClass {
  return [GHCommitsTableModel class];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Commits";
  self.tableView.rowHeight = 65; 
  
  self.tableModel.repository = self.repository;
  [self.tableModel refreshData];
}

- (void)dealloc {
  [self releaseProperties];
  [super dealloc];
}

#pragma mark -
#pragma mark LRTableModelCellProvider

- (void)configureCell:(UITableViewCell *)cell forObject:(id <GitHubCommit>)object atIndexPath:(id)path {
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  cell.textLabel.text = object.message;

  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.dateStyle = NSDateFormatterMediumStyle;
  formatter.timeStyle = NSDateFormatterShortStyle;
  
  cell.detailTextLabel.text = [formatter stringFromDate:object.committedDate];

  [formatter release];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(id)path {
  id <GitHubCommit> commit = [self.tableModel objectAtIndexPath:path];
  id controller = [GHCommitViewController withCommit:commit];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
