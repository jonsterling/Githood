#import <UIKit/UIKit.h>

@protocol GHSettingsDelegate;

@interface GHSettingsViewController : UITableViewController
@property (nonatomic,assign) id <GHSettingsDelegate> delegate;
@property (nonatomic, copy) NSString *username;
@end

@protocol GHSettingsDelegate
- (void)settingsController:(GHSettingsViewController *)controller didFinishWithUsername:(NSString *)name;
- (void)settingsControllerDidCancel:(GHSettingsViewController *)controller;
@end