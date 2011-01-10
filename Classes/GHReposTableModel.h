#import "GHTableModel.h"

@interface GHReposTableModel : GHTableModel <GHConcreteTableModel>
@property (nonatomic, copy) NSString *username;
@end
