#import "GHTableViewController.h"

@protocol GitHubCommit;
@protocol GitHubRepository;

@interface GHChangesTableViewController : GHTableViewController <GHConcreteTableViewController>
@property (nonatomic,readonly) id <GitHubCommit> commit;
@property (nonatomic,readonly) id <GitHubRepository> repository;

+ (id)withCommit:(id <GitHubCommit>)commit 
  fromRepository:(id <GitHubRepository>)repository;
- (id)initWithCommit:(id <GitHubCommit>)commit 
      fromRepository:(id <GitHubRepository>)repository;
@end
