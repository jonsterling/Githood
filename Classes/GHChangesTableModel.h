#import "GHTableModel.h"

@protocol GitHubCommit;
@protocol GitHubRepository;

@interface GHChangesTableModel : GHTableModel <GHConcreteTableModel>
@property (nonatomic,retain) id <GitHubCommit> commit;
@property (nonatomic,retain) id <GitHubRepository> repository;
@end
