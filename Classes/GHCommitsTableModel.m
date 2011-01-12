#import "GHCommitsTableModel.h"
#import "GitHubRepository.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubServiceGotCommitDelegate.h"

@interface GHCommitsTableModel () <GitHubServiceGotCommitDelegate>
@property (readonly) NSArray *sortedCommits;
@end

@implementation GHCommitsTableModel
@synthesize repository;
@dynamic sortedCommits;

- (void)dealloc {
  [self releaseProperties];
  [super dealloc];
}

- (void)refreshData {
  [self removeAllObjects];
  
  [GitHubCommitServiceFactory requestCommitsOnBranch:@"master" 
                                          repository:self.repository.name 
                                                user:self.repository.owner
                                            delegate:self];
  [self.delegate dataDidChange];
}

- (NSArray *)sortedCommits {
  return [[self objectsForSection:0] sortedArrayUsingComparator:^(id <GitHubCommit> a, id <GitHubCommit> b) {
    return [b.committedDate compare:a.committedDate];
  }];
}


- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
  return [self.sortedCommits objectAtIndex:indexPath.row];
}


- (void)gitHubService:(id <GitHubService>)service gotCommit:(id <GitHubCommit>)commit {
  [self addObject:commit toSection:0];
}

#pragma mark -
#pragma mark GHCountStatusItemDataSource

- (NSUInteger)numberOfItemsForStatusItem:(id)controller {
  return self.sortedCommits.count;
}


@end
