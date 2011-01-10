@protocol GitHubCommit;

@interface GHCommitViewController : UIViewController
@property (nonatomic,readonly) id <GitHubCommit> commit;

+ (id)withCommit:(id <GitHubCommit>)commit;
- (id)initWithCommit:(id <GitHubCommit>)commit;
@end
