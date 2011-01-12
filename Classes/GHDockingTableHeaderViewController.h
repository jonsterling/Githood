#import <UIKit/UIKit.h>

// To use `GHDockingTableHeaderViewController`, forward `-scrollViewDidScroll:`
// to it.
@interface GHDockingTableHeaderViewController : NSObject <UIScrollViewDelegate>
+ (id)withTableView:(UITableView *)tableView headerView:(UIView *)headerView;
- (id)initWithTableView:(UITableView *)tableView headerView:(UIView *)headerView;
@end
