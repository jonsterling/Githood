#import "GHTableModel.h"

@protocol GitHubRepository;

@interface GHCommitsTableModel : GHTableModel <GHConcreteTableModel>
@property (nonatomic,retain) id <GitHubRepository> repository;
@end
