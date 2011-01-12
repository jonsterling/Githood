#import "GHSettingsViewController.h"
#import "UIBarButtonItem+Custom.h"
#import "GHStyler.h"

@interface GHSettingsViewController ()
- (void)close;
@end

@implementation GHSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style {
  return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)dealloc {
  [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.title = @"Settings";
  
  [GHStyler styleNavigationBar:self.navigationController.navigationBar];
  
  UIBarButtonItem *doneItem = [UIBarButtonItem withSystemItem:UIBarButtonSystemItemDone 
                                                       target:self
                                                       action:@selector(close)];
  self.navigationItem.leftBarButtonItem = doneItem;
}

- (void)close {
  [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [UITableViewCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
