#import "LRTableModelEventListener.h"
#import "LRTableModelCellProvider.h"

@protocol GHConcreteTableViewController <NSObject>
+ (Class)modelClass;
@end

@protocol GHConcreteTableModel;

@interface GHTableViewController : UITableViewController <LRTableModelEventListener,LRTableModelCellProvider>
@property (nonatomic,readonly) id <GHConcreteTableModel> tableModel;
@end
