#import "GHStatusBarButtonController.h"

@protocol GHCountStatusItemDataSource;

@interface GHCountStatusItemController : GHStatusBarButtonController
@property (nonatomic,retain,readonly) IBOutlet UILabel *textLabel;
@property (nonatomic,assign) id <GHCountStatusItemDataSource> dataSource;

@property (nonatomic,copy) NSString *singularType;
@property (nonatomic,copy) NSString *pluralType;

- (void)refreshLabel;
@end

@protocol GHCountStatusItemDataSource
- (NSUInteger)numberOfItemsForStatusItemController:(id)controller;
@end