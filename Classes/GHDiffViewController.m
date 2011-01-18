#import "GHDiffViewController.h"
#import "GHStyler.h"
#import "GHRefreshController.h"
#import "GHDiffStatusItemController.h"
#import "UIBarButtonItem+Custom.h"

@interface GHDiffViewController () <GHDiffStatusItemDataSource>
@property (nonatomic,copy) NSString *rawDiff;
@property (nonatomic,retain) GHDiffStatusItemController *statusItem;
- (NSUInteger)numberOfLinesStartingWith:(NSString *)prefix;
- (NSString *)htmlDiff;
@end

@implementation GHDiffViewController
@synthesize webView;
@synthesize rawDiff;
@synthesize statusItem;

+ (id)withDiff:(NSString *)diff ofFile:(NSString *)fileName{
  return [[[self alloc] initWithDiff:diff ofFile:fileName] autorelease];
}

- (id)initWithDiff:(NSString *)aDiff ofFile:(NSString *)aFileName {
  self = [super init];
  if (self != nil) {
    self.rawDiff = aDiff;
    self.title = aFileName.pathComponents.lastObject;
  } return self;
}

- (void)dealloc {
  [webView release];
  [rawDiff release];
  [statusItem release];
  [super dealloc];
}


- (void)viewDidLoad {
  [super viewDidLoad];
  self.statusItem = [GHDiffStatusItemController controller];
  self.statusItem.dataSource = self;
  
  id flex = [UIBarButtonItem withSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
  id items = [NSArray arrayWithObjects:flex,self.statusItem.buttonItem,flex,nil];
  [self setToolbarItems:items animated:YES];
  
  [self.webView loadHTMLString:self.htmlDiff baseURL:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark State

- (NSString *)htmlDiff {
  id templatePath = [[NSBundle mainBundle] pathForResource:@"diff.template" ofType:@"html"];
  id template = [[NSString alloc] initWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
  
  NSDictionary *map = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"<",@"&lt;",
                       @">",@"&gt;",
                       nil];
  
  id diff = [self.rawDiff mutableCopy];
  for (id key in map) {
    [diff replaceOccurrencesOfString:[map objectForKey:key] withString:key options:0 range:NSMakeRange(0, [diff length])];
  }
  
  id html = [template stringByReplacingOccurrencesOfString:@"$diff" withString:diff];
  [template release];
  [diff release];
  

  return html;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)aWebView {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark GHDiffStatusItemDataSource

- (NSUInteger)numberOfLinesStartingWith:(NSString *)prefix {
  id pred = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
    return [evaluatedObject hasPrefix:prefix];
  }];
  
  id comps = [self.rawDiff componentsSeparatedByString:@"\n"];
  id tail = [comps subarrayWithRange:NSMakeRange(2, [comps count] - 2)];
  
  return [tail filteredArrayUsingPredicate:pred].count;
}

- (NSUInteger)linesAddedForStatusItem:(id)item {
  return [self numberOfLinesStartingWith:@"+"];
}

- (NSUInteger)linesRemovedForStatusItem:(id)item {
  return [self numberOfLinesStartingWith:@"-"];
}


@end
