#import "GHTableModel.h"
#import "GHCountStatusItemController.h"

@interface GHReposTableModel : GHTableModel <GHConcreteTableModel,GHCountStatusItemDataSource>
@property (nonatomic, copy) NSString *username;
@end
