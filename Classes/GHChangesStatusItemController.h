#import "GHStatusBarButtonController.h"

@protocol GHChangesStatusItemDataSource;

@interface GHChangesStatusItemController : GHStatusBarButtonController
@property (nonatomic,retain,readonly) IBOutlet UILabel *textLabel;
@property (nonatomic,assign) id <GHChangesStatusItemDataSource> dataSource;
@end

@protocol GHChangesStatusItemDataSource
- (NSUInteger)numberModifiedForStatusItem:(id)controller;
- (NSUInteger)numberAddedForStatusItem:(id)controller;
- (NSUInteger)numberRemovedForStatusItem:(id)controller;
@end