#import "LRTableModelEventListener.h"
#import "LRTableModelCellProvider.h"
#import "GHRefreshBarButtonController.h"
#import "GHTableModel.h"

@protocol GHConcreteTableViewController <NSObject>
+ (Class)modelClass;
@end

@interface GHTableViewController : UITableViewController <LRTableModelEventListener,LRTableModelCellProvider,GHRefreshBarButtonDelegate,GHTableModelDelegate>
@property (nonatomic,retain,readonly) id <GHConcreteTableModel> tableModel;
@property (nonatomic,retain,readonly) GHRefreshBarButtonController *refreshItem;

- (void)refreshData;
- (void)setSoleToolbarItem:(UIBarButtonItem *)item;
@end
