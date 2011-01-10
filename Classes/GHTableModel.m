#import "GHTableModel.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubRepositoryServiceFactory.h"
#import "GitHubServiceGotCommitDelegate.h"

@interface GHTableModel ()
@property (nonatomic, readonly) NSMutableArray *mutableObjects;
@end


@implementation GHTableModel
@dynamic objects;

#pragma mark -
#pragma mark Setup and Teardown

- (id)initWithCellProvider:(id <LRTableModelCellProvider>)provider {
  if ((self = [super initWithCellProvider:provider])) {
    mutableObjects = [NSMutableArray new];
  } return self;
}

- (void)dealloc {
  [self releaseProperties];
  [super dealloc];
}


#pragma mark -
#pragma mark CRUD

- (void)addObject:(id)object {
  [self.mutableObjects addObject:object];

  NSInteger i = [self.objects indexOfObject:object];
  [self notifyListeners:[LRTableModelEvent insertionAtRow:i section:0]];
}

- (void)removeObject:(id)object {
  NSInteger i = [self.objects indexOfObject:object];
  [self.mutableObjects removeObject:object];
  [self notifyListeners:[LRTableModelEvent deletedRow:i section:0]];
}

- (void)replaceObjectAtIndex:(NSInteger)index withObject:(id)object {
  [self.mutableObjects replaceObjectAtIndex:index withObject:object];
  [self notifyListeners:[LRTableModelEvent updatedRow:index section:0]];
}

- (void)insertObject:(id)object atIndex:(NSInteger)index {
  [self.mutableObjects insertObject:object atIndex:index];
  [self notifyListeners:[LRTableModelEvent insertionAtRow:index section:0]];
}

- (NSArray *)objects {
  return self.mutableObjects;
}

- (void)setObjects:(NSArray *)newObjects {
  [self.mutableObjects removeAllObjects];
  [self.mutableObjects setArray:newObjects];
  [self notifyListeners:[LRTableModelEvent refreshedData]];
}

#pragma mark -
#pragma mark LRTableModel

- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex {
  return self.objects.count;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
  return [self.objects objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark GitHubServiceDelegate

- (void)gitHubService:(id <GitHubService>)gitHubService didFailWithError:(NSError *)error {
  NSLog(@"%@, %@",NSStringFromSelector(_cmd),error);
}

- (void)gitHubServiceDone:(id <GitHubService>)gitHubService {
  
}


@end
