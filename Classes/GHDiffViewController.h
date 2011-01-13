#import <UIKit/UIKit.h>

@interface GHDiffViewController : UIViewController
@property (nonatomic,retain) IBOutlet UIWebView *webView;

+ (id)withDiff:(NSString *)diff ofFile:(NSString *)fileName;
- (id)initWithDiff:(NSString *)diff ofFile:(NSString *)fileName;
@end
