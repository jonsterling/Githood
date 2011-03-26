#import "GHTableModel.h"
#import "GHCountStatusItemController.h"

@protocol GitHubRepository;

@interface GHCommitsTableModel : GHTableModel <GHConcreteTableModel,GHCountStatusItemDataSource>
@property (nonatomic, retain) id <GitHubRepository> repository;
@end
