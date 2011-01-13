#import "GHDiffViewController.h"
#import "GHStyler.h"

@interface GHDiffViewController ()
@property (nonatomic,copy) NSString *diff;
@property (readonly) NSString *htmlDiff;
@end

@implementation GHDiffViewController
@synthesize webView;
@synthesize diff;
@dynamic htmlDiff;

+ (id)withDiff:(NSString *)diff ofFile:(NSString *)fileName{
  return [[[self alloc] initWithDiff:diff ofFile:fileName] autorelease];
}

- (id)initWithDiff:(NSString *)aDiff ofFile:(NSString *)aFileName {
  self = [super init];
  if (self != nil) {
    diff = [aDiff copy];
    self.title = aFileName.pathComponents.lastObject;
  } return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.webView loadHTMLString:self.htmlDiff baseURL:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.navigationController setToolbarHidden:NO animated:YES];
}

- (NSString *)htmlDiff {
  id templatePath = [[NSBundle mainBundle] pathForResource:@"diff.template" ofType:@"html"];
  id template = [[NSString alloc] initWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
  
  id html = [template stringByReplacingOccurrencesOfString:@"$diff" withString:self.diff];
  [template release];
  
  return html;
}

- (void)dealloc {
  [webView release];
  [diff release];
  [super dealloc];
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
