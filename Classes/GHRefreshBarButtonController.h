typedef enum {
  GHLoadingCompleteState = 0,
  GHLoadingInProgressState
} GHLoadingState;

@protocol GHRefreshBarButtonDelegate;

@interface GHRefreshBarButtonController : NSObject
@property (nonatomic,readwrite) GHLoadingState state;
@property (nonatomic,assign) id <GHRefreshBarButtonDelegate> delegate;

+ (id)withTarget:(id)target action:(SEL)action delegate:(id <GHRefreshBarButtonDelegate>)delegate;
- (id)initWithTarget:(id)target action:(SEL)action delegate:(id <GHRefreshBarButtonDelegate>)delegate;
@end

@protocol GHRefreshBarButtonDelegate
- (void)placeRefreshButton:(UIBarButtonItem *)refreshButton;
@end
