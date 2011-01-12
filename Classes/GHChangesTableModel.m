#import "GHChangesTableModel.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubServiceGotCommitDelegate.h"
#import "GitHubCommit.h"
#import "GitHubRepository.h"

@interface GHChangesTableModel () <GitHubServiceGotCommitDelegate>
@end

@implementation GHChangesTableModel
@synthesize commit;
@synthesize repository;

- (void)dealloc {
  [commit release];
  [repository release];
  [super dealloc];
}

- (void)refreshData {
  [self removeAllObjects];
  
  [GitHubCommitServiceFactory requestCommitBySha:self.commit.sha
                                      repository:self.repository.name
                                            user:self.repository.owner
                                        delegate:self];
}

- (NSString *)headerForSection:(NSInteger)index {
  id sections[] = {@"modified",@"added",@"removed"};
  return sections[index];
}


#pragma mark -
#pragma mark GitHubServiceGotCommitDelegate

- (void)gitHubService:(id<GitHubService>)service gotCommit:(id<GitHubCommit>)aCommit {
  self.commit = aCommit;
  
  [self addObjects:aCommit.modified toSection:0];
  [self addObjects:aCommit.added toSection:1];
  [self addObjects:aCommit.removed toSection:2];
  
  [self.delegate dataDidChange];
}

#pragma mark -
#pragma mark GHChangesStatusItemController

- (NSUInteger)numberModifiedForStatusItem:(id)controller {
  return self.commit.modified.count;
}

- (NSUInteger)numberAddedForStatusItem:(id)controller {
  return self.commit.added.count;
}

- (NSUInteger)numberRemovedForStatusItem:(id)controller {
  return self.commit.removed.count;
}


@end
