#import <UIKit/UIKit.h>
#import "LRTableModelEventListener.h"
#import "LRTableModelCellProvider.h"
#import "GHRefreshController.h"
#import "GHTableModel.h"

@protocol GHConcreteTableViewController <NSObject>
+ (Class)modelClass;
@optional
// If `-headerText` is implemented, the a docking header view will be added
- (NSString *)headerText;
@end

@class GHDockingTableHeaderViewController;

@interface GHTableViewController : UITableViewController <LRTableModelEventListener,LRTableModelCellProvider,GHRefreshControllerDelegate,GHTableModelDelegate>
@property (nonatomic,retain,readonly) id <GHConcreteTableModel> tableModel;
@property (nonatomic,retain,readonly) GHRefreshController *refreshItem;
@property (nonatomic,retain,readonly) GHDockingTableHeaderViewController *headerController;

- (void)refreshData;
- (void)setSoleToolbarItem:(UIBarButtonItem *)item;
@end
