#import "GHTableViewController.h"

@protocol GitHubRepository;

@interface GHCommitsTableViewController : GHTableViewController <GHConcreteTableViewController>
@property (nonatomic, readonly) id <GitHubRepository> repository;

+ (id)withRepository:(id <GitHubRepository>)repository;
- (id)initWithRepository:(id <GitHubRepository>)repository;
@end
