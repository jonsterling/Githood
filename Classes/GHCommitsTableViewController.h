#import "GHTableViewController.h"

@protocol GitHubRepository;

@interface GHCommitsTableViewController : GHTableViewController <GHConcreteTableViewController>
@property (nonatomic,retain) id <GitHubRepository> repository;
@end
