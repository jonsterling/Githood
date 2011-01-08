#import "LRAbstractTableModel.h"
#import "GitHubServiceDelegate.h"

@protocol GHConcreteTableModel <LRTableModel,UITableViewDataSource>
- (void)refreshData;

@optional
@property (nonatomic, copy) NSString *username;
@end

@interface GHTableModel : LRAbstractTableModel <GitHubServiceDelegate>
@property (nonatomic,readonly) NSMutableArray *objects;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSInteger)index;
- (void)replaceObjectAtIndex:(NSInteger)index withObject:(id)object;
- (void)setObjects:(NSArray *)newObjects;
@end
