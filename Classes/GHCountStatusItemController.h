#import "GHStatusBarButtonController.h"

@protocol GHCountStatusItemDataSource;

@interface GHCountStatusItemController : GHStatusBarButtonController
@property (nonatomic, retain, readonly) IBOutlet UILabel *textLabel;
@property (nonatomic,assign) id <GHCountStatusItemDataSource> dataSource;

+ (id)withSingularType:(NSString *)singular pluralType:(NSString *)plural;
- (id)initWithSingularType:(NSString *)singular pluralType:(NSString *)plural;

@end

@protocol GHCountStatusItemDataSource
- (NSUInteger)numberOfItemsForStatusItem:(id)controller;
@end