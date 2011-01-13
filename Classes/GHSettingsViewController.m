#import <objc/runtime.h>
#import "GHSettingsViewController.h"
#import "UIBarButtonItem+Custom.h"
#import "GHGroupedTableView.h"
#import "GHStyler.h"

@interface GHSettingsViewController () <UITextFieldDelegate>
@property (nonatomic, readonly) UITextField *textField;
- (void)cancel;
- (void)done;
@end

@implementation GHSettingsViewController
@synthesize delegate;
@synthesize username;
@dynamic textField;

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
  
  self.title = @"Login";
  
  UIBarButtonItem *doneItem = [UIBarButtonItem withSystemItem:UIBarButtonSystemItemCancel
                                                       target:self
                                                       action:@selector(cancel)];
  self.navigationItem.leftBarButtonItem = doneItem;
  
  self.textField.text = self.username;
  [self.textField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  [self.textField selectAll:self];
  [UIMenuController sharedMenuController].menuVisible = NO;
}

- (void)done {
  [self dismissModalViewControllerAnimated:YES];
  [self.delegate settingsController:[[self retain] autorelease]
              didFinishWithUsername:self.username];
}

- (void)cancel {
  [self dismissModalViewControllerAnimated:YES];
  [self.delegate settingsControllerDidCancel:[[self retain] autorelease]];
}

- (UITextField *)textField {
  id path = [NSIndexPath indexPathForRow:0 inSection:0];
  id cell = [self.tableView cellForRowAtIndexPath:path];
  return objc_getAssociatedObject(cell, @"textField");
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGSize contentSize = cell.contentView.frame.size;
    CGRect textFieldRect = CGRectMake(10.0, 0.0, 290.0, contentSize.height);
    
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.placeholder = @"your username";
    textField.font = [UIFont systemFontOfSize:15.0f];
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
		textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		textField.clearButtonMode = UITextFieldViewModeWhileEditing;
		textField.delegate = self;
    
    [cell.contentView addSubview:textField];
    objc_setAssociatedObject(cell, @"textField", textField, OBJC_ASSOCIATION_ASSIGN);
    
    [textField release];
  }
  
  return cell;
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  self.username = textField.text;
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  self.username = textField.text;
  [self done];
  return NO;
}

@end
