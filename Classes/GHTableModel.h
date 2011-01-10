#import "LRAbstractTableModel.h"
#import "GitHubServiceDelegate.h"

@protocol GHConcreteTableModel <LRTableModel,UITableViewDataSource>
- (void)refreshData;
@end

@interface GHTableModel : LRAbstractTableModel <GitHubServiceDelegate>
@property (nonatomic, retain) NSArray *objects;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSInteger)index;
- (void)replaceObjectAtIndex:(NSInteger)index withObject:(id)object;

@end
