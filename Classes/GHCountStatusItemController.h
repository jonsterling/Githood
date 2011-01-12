#import "GHStatusBarButtonController.h"

@protocol GHCountStatusItemDataSource;

@interface GHCountStatusItemController : GHStatusBarButtonController
@property (nonatomic,retain,readonly) IBOutlet UILabel *textLabel;
@property (nonatomic,assign) id <GHCountStatusItemDataSource> dataSource;

@property (nonatomic,copy) NSString *singularType;
@property (nonatomic,copy) NSString *pluralType;

@end

@protocol GHCountStatusItemDataSource
- (NSUInteger)numberOfItemsForStatusItem:(id)controller;
@end