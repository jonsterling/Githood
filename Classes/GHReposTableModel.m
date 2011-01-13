#import "GHReposTableModel.h"
#import "GitHubServiceGotRepositoryDelegate.h"
#import "GitHubRepositoryServiceFactory.h"

@interface GHReposTableModel () <GitHubServiceGotRepositoryDelegate>
@property (readonly) NSArray *sortedRepositories;
@end

@implementation GHReposTableModel
@dynamic username;
@dynamic sortedRepositories;

- (void)refreshData {
  if (self.username.length == 0) {
    [self.delegate refreshFailed];
    return;
  }
  
  [self removeAllObjects];
  [GitHubRepositoryServiceFactory requestRepositoriesWatchedByUser:self.username
                                                          delegate:self];
}

- (void)gitHubService:(id <GitHubService>)service gotRepository:(id <GitHubRepository>)repository {
  [self addObject:repository toSection:0];
}

- (NSString *)username {
  return [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
}

- (void)setUsername:(NSString *)username {
  id defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:username forKey:@"username"];
  [defaults synchronize];
}

- (NSArray *)sortedRepositories {
  return [self.firstSection sortedArrayUsingComparator:^(id <GitHubRepository> a, id <GitHubRepository> b) {
    return [b.pushDate compare:a.pushDate];
  }];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
  return [self.sortedRepositories objectAtIndex:indexPath.row];
}

- (NSUInteger)numberOfItemsForStatusItem:(id)controller; {
  return self.sortedRepositories.count;
}

- (void)gitHubService:(id<GitHubService>)service didFailWithError:(NSError *)error {
  [super gitHubService:service didFailWithError:error];
  self.username = nil;
}

@end
