#import "GHStatusBarButtonController.h"

@protocol GHDiffStatusItemDataSource;

@interface GHDiffStatusItemController : GHStatusBarButtonController
@property (nonatomic,retain) IBOutlet UILabel *textLabel;
@property (nonatomic,assign) id <GHDiffStatusItemDataSource> dataSource;
@end

@protocol GHDiffStatusItemDataSource <NSObject>
- (NSUInteger)linesAddedForStatusItem:(id)item;
- (NSUInteger)linesRemovedForStatusItem:(id)item;
@end