typedef enum {
  GHLoadingCompleteState = 0,
  GHLoadingInProgressState
} GHLoadingState;

@protocol GHRefreshControllerDelegate;

@interface GHRefreshController : NSObject
@property (nonatomic, readwrite) GHLoadingState state;
@property (nonatomic,assign) id <GHRefreshControllerDelegate> delegate;

+ (id)withTarget:(id)target action:(SEL)action delegate:(id <GHRefreshControllerDelegate>)delegate;
- (id)initWithTarget:(id)target action:(SEL)action delegate:(id <GHRefreshControllerDelegate>)delegate;
@end

@protocol GHRefreshControllerDelegate
@optional
- (void)placeRefreshButton:(UIBarButtonItem *)refreshButton;
@end
