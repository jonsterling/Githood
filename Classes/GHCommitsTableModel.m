#import "GHCommitsTableModel.h"
#import "GitHubRepository.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubServiceGotCommitDelegate.h"

@interface GHCommitsTableModel () <GitHubServiceGotCommitDelegate>
@property (readonly) NSArray *sortedCommits;
@end

@implementation GHCommitsTableModel

- (void)dealloc {
  [self releaseProperties];
  [super dealloc];
}

- (void)refreshData {
  [self setObjects:[NSArray array]];
  
  [GitHubCommitServiceFactory requestCommitsOnBranch:@"master" 
                                          repository:self.repository.name 
                                                user:self.repository.owner
                                            delegate:self];
}

- (NSArray *)sortedCommits {
  return [self.objects sortedArrayUsingComparator:^(id <GitHubCommit> a, id <GitHubCommit> b) {
    return [b.committedDate compare:a.committedDate];
  }];
}


- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
  return [self.sortedCommits objectAtIndex:indexPath.row];
}


- (void)gitHubService:(id <GitHubService>)service gotCommit:(id <GitHubCommit>)commit {
  [self addObject:commit];
}


@end
