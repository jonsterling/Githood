#import "GHRefreshBarButtonController.h"

@interface GHRefreshBarButtonController ()
@property (nonatomic,assign) id buttonTarget;
@property (nonatomic,readwrite) SEL buttonAction;

@property (nonatomic,retain,readonly) UIBarButtonItem *refreshItem;
@property (nonatomic,retain,readonly) UIBarButtonItem *loadingItem;

- (UIBarButtonItem *)buttonForState:(GHLoadingState)aState;
- (void)messageDelegateWithCurrentState;
@end

@implementation GHRefreshBarButtonController
@synthesize state;
@synthesize refreshItem;
@synthesize loadingItem;
@synthesize buttonTarget;
@synthesize buttonAction;
@synthesize delegate;

+ (id)withTarget:(id)target action:(SEL)action delegate:(id <GHRefreshBarButtonDelegate>)delegate {
  return [[[self alloc] initWithTarget:target action:action delegate:delegate] autorelease];
}

- (id)initWithTarget:(id)target action:(SEL)action delegate:(id <GHRefreshBarButtonDelegate>)aDelegate {
  self = [super init];
  if (self != nil) {
    self.buttonTarget = target;
    self.buttonAction = action;
    self.delegate = aDelegate;
    
    [self.delegate placeRefreshButton:self.refreshItem];
  } return self;
}

- (UIBarButtonItem *)refreshItem {
  if (refreshItem == nil) {
    refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                target:self.buttonTarget 
                                                                action:self.buttonAction];
  } return refreshItem;
}

- (UIBarButtonItem *)loadingItem {
  if (loadingItem == nil) {
    id ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    loadingItem = [[UIBarButtonItem alloc] initWithCustomView:ind];
    loadingItem.style = UIBarButtonItemStyleBordered;
    
    [ind startAnimating];
    [ind release];
  } return loadingItem;
}

- (UIBarButtonItem *)buttonForState:(GHLoadingState)aState {
  UIBarButtonItem *item = nil;
  
  switch (aState) {
    case GHLoadingCompleteState:
      item = self.refreshItem;
      break;
    case GHLoadingInProgressState:
      item = self.loadingItem;
      break;
    default:
      break;
  }
  
  return item;
}

- (void)messageDelegateWithCurrentState {
  [self.delegate placeRefreshButton:[self buttonForState:self.state]];
}

- (void)setState:(GHLoadingState)aState {
  state = aState;
  [self messageDelegateWithCurrentState];
}

- (void)dealloc {
  [self releaseProperties];
  [super dealloc];
}

@end
