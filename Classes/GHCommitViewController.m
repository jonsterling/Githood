#import "GHCommitViewController.h"
#import "GitHubCommit.h"

@interface GHCommitViewController ()
@property (nonatomic,retain) IBOutlet UIWebView *webView;
@end

@implementation GHCommitViewController
@synthesize commit;
@synthesize webView;

- (void)dealloc {
  [commit release];
  [super dealloc];
}

+ (id)withCommit:(id <GitHubCommit>)commit {
  return [[[self alloc] initWithCommit:commit] autorelease];
}

- (id)initWithCommit:(id <GitHubCommit>)aCommit {
  self = [super init];
  if (self != nil) {
    commit = [aCommit retain];
  } return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Commit";
}

@end
