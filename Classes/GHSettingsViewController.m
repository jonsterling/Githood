#import "GHSettingsViewController.h"
#import "UIBarButtonItem+Custom.h"
#import "GHGroupedTableView.h"
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

- (void)loadView {
  GHGroupedTableView *table = [[GHGroupedTableView alloc] initWithFrame:CGRectZero 
                                                                  style:UITableViewStyleGrouped];
  self.view = table;
  self.tableView = table;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  [table release];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [GHStyler styleNavigationController:self.navigationController];
  
  self.title = @"Settings";
  
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return @"Your Login";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  return @"Enter your GitHub username or email here to see your watched repositories.";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
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
