#import <UIKit/UIKit.h>

// To use `GHDockingTableHeaderViewController`, forward `-scrollViewDidScroll:`
// to it.
@interface GHDockingTableHeaderViewController : NSObject <UIScrollViewDelegate>
@property (nonatomic,readonly) id headerView;

+ (id)withTableView:(UITableView *)tableView headerView:(id)headerView;
- (id)initWithTableView:(UITableView *)tableView headerView:(id)headerView;
@end
