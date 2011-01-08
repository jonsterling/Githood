#import "GHTableModel.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubRepositoryServiceFactory.h"
#import "GitHubServiceGotCommitDelegate.h"

@implementation GHTableModel
@synthesize objects;

#pragma mark -
#pragma mark Setup and Teardown

- (id)initWithCellProvider:(id <LRTableModelCellProvider>)provider {
  if (self = [super initWithCellProvider:provider]) {
    objects = [NSMutableArray new];
  } return self;
}

- (void)dealloc {
  [objects release];
  [super dealloc];
}


#pragma mark -
#pragma mark CRUD

- (void)addObject:(id)object {
  [self.objects addObject:object];

  NSInteger i = [self.objects indexOfObject:object];
  [self notifyListeners:[LRTableModelEvent insertionAtRow:i section:0]];
}

- (void)removeObject:(id)object {
  NSInteger i = [self.objects indexOfObject:object];
  [self.objects removeObject:object];
  [self notifyListeners:[LRTableModelEvent deletedRow:i section:0]];
}

- (void)replaceObjectAtIndex:(NSInteger)index withObject:(id)object {
  [self.objects replaceObjectAtIndex:index withObject:object];
  [self notifyListeners:[LRTableModelEvent updatedRow:index section:0]];
}

- (void)insertObject:(id)object atIndex:(NSInteger)index {
  [self.objects insertObject:object atIndex:index];
  [self notifyListeners:[LRTableModelEvent insertionAtRow:index section:0]];
}

- (void)setObjects:(NSArray *)newObjects {
  [self.objects removeAllObjects];
  [self.objects setArray:newObjects];
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
