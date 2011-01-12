#import "LRAbstractTableModel.h"
#import "GitHubServiceDelegate.h"

@protocol GHConcreteTableModel <LRTableModel,UITableViewDataSource>
- (void)refreshData;
@end

@protocol GHTableModelDelegate;
@interface GHTableModel : LRAbstractTableModel <GitHubServiceDelegate>
@property (nonatomic,assign) id <GHTableModelDelegate> delegate;

// ### Accessors:
- (NSArray *)objectsForSection:(NSUInteger)section;
- (NSArray *)firstSection;

// ### Insertion
- (void)addObject:(id)object toSection:(NSUInteger)section;
- (void)addObjects:(id <NSFastEnumeration>)objs toSection:(NSUInteger)section;
- (void)insertObject:(id)object atRow:(NSUInteger)row inSection:(NSUInteger)section;

// ### Removal
- (void)removeObject:(id)object fromSection:(NSUInteger)section;
- (void)removeAllObjects;

// ### Replacement
- (void)replaceObjectAtRow:(NSUInteger)index inSection:(NSUInteger)section withObject:(id)object;

@end

@protocol GHTableModelDelegate
- (void)dataDidChange;
@end