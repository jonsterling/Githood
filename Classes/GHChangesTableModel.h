#import "GHTableModel.h"
#import "GHChangesStatusItemController.h"

@protocol GitHubCommit;
@protocol GitHubRepository;

@interface GHChangesTableModel : GHTableModel <GHConcreteTableModel,GHChangesStatusItemDataSource>
@property (nonatomic,retain) id <GitHubCommit> commit;
@property (nonatomic,retain) id <GitHubRepository> repository;
@end
