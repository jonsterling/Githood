#import "GHTableModel.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubRepositoryServiceFactory.h"
#import "GitHubServiceGotCommitDelegate.h"

@interface GHTableModel ()
@property (nonatomic, readonly) NSMutableArray *sections;
- (void)stubSection:(NSUInteger)section;
- (void)setObjects:(NSArray *)objects forSection:(NSUInteger)section;
@end


@implementation GHTableModel
@synthesize delegate;
@synthesize sections;

#pragma mark -
#pragma mark Setup and Teardown

- (id)initWithCellProvider:(id <LRTableModelCellProvider>)provider {
  if ((self = [super initWithCellProvider:provider])) {
    sections = [NSMutableArray new];
  } return self;
}

- (void)dealloc {
  [self releaseProperties];
  [super dealloc];
}


#pragma mark -
#pragma mark Accessors

- (NSArray *)firstSection {
  return [self objectsForSection:0];
}

- (NSArray *)objectsForSection:(NSUInteger)index {
  [self stubSection:index];
  
  return [self.sections objectAtIndex:index];
}

- (void)stubSection:(NSUInteger)section {
  if (section >= self.sections.count) {
    [self.sections insertObject:[NSMutableArray array] atIndex:section];
    [self notifyListeners:[LRTableModelEvent insertedSection:section]];
  }
}

- (void)setObjects:(NSArray *)objects forSection:(NSUInteger)section {
  [self.sections replaceObjectAtIndex:section withObject:objects];
}

#pragma mark -
#pragma mark Insertion

- (void)addObjects:(NSArray *)objs toSection:(NSUInteger)sectionIndex {
  if (objs.count == 0) {
    [self stubSection:sectionIndex];
  }
  
  for (id o in objs) {
    [self addObject:o toSection:sectionIndex];
  }
}

- (void)addObject:(id)object toSection:(NSUInteger)sectionIndex {
  id section = [[self objectsForSection:sectionIndex] mutableCopy];
  [section addObject:object];
  [self setObjects:section forSection:sectionIndex];  
  
  NSUInteger rowIndex = [section indexOfObject:object];
  [self notifyListeners:[LRTableModelEvent insertedAtRow:rowIndex section:sectionIndex]];
}

- (void)insertObject:(id)object atRow:(NSUInteger)row inSection:(NSUInteger)section {
  id objects = [[self objectsForSection:section] mutableCopy];
  [objects insertObject:object atIndex:row];
  [self setObjects:objects forSection:section];
  [objects release];
  
  [self notifyListeners:[LRTableModelEvent insertedAtRow:row section:section]];
}


#pragma mark -
#pragma mark Removal

- (void)removeObject:(id)object fromSection:(NSUInteger)sectionIndex {
  id section = [[self objectsForSection:sectionIndex] mutableCopy];
  
  NSUInteger rowIndex = [section indexOfObject:object];
  [section removeObject:object];
  
  [self setObjects:section forSection:sectionIndex];
  [section release];
  
  [self notifyListeners:[LRTableModelEvent deletedRow:rowIndex section:0]];
}

- (void)removeAllObjects {
  [self.sections removeAllObjects];
  [self notifyListeners:[LRTableModelEvent refreshedData]];
}


#pragma mark -
#pragma mark Replacement

- (void)replaceObjectAtRow:(NSUInteger)row inSection:(NSUInteger)section withObject:(id)object {
  id objects = [[self objectsForSection:section] mutableCopy];
  [objects replaceObjectAtIndex:row withObject:object];
  [self setObjects:objects forSection:section];
  [objects release];
  
  [self notifyListeners:[LRTableModelEvent updatedRow:row section:0]];
}


#pragma mark -
#pragma mark LRTableModel

- (NSInteger)numberOfSections {
  return self.sections.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex {
  return [[self objectsForSection:sectionIndex] count];
}

- (id)objectAtIndexPath:(NSIndexPath *)path {
  return [[self objectsForSection:path.section] objectAtIndex:path.row];
}

#pragma mark -
#pragma mark GitHubServiceDelegate

- (void)gitHubService:(id <GitHubService>)gitHubService didFailWithError:(NSError *)error {
  NSLog(@"%@, %@",NSStringFromSelector(_cmd),error);
}

- (void)gitHubServiceDone:(id <GitHubService>)gitHubService {
  [self.delegate dataDidChange];
}


@end
