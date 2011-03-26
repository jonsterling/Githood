#import "GHCountStatusItemController.h"

@interface GHCountStatusItemController ()
@property (nonatomic, readonly) NSString *singularType;
@property (nonatomic, readonly) NSString *pluralType;
@end

@implementation GHCountStatusItemController
@synthesize textLabel;
@synthesize dataSource;
@synthesize singularType;
@synthesize pluralType;

+ (id)withSingularType:(NSString *)singular pluralType:(NSString *)plural {
  return [[[self alloc] initWithSingularType:singular pluralType:plural] autorelease];
}

- (id)initWithSingularType:(NSString *)singular pluralType:(NSString *)plural {
  self = [super init];
  if (self != nil) {
    singularType = [singular copy];
    pluralType = [plural copy];
  } return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self refreshLabel];
}

- (void)refreshLabel {
  NSUInteger count = [self.dataSource numberOfItemsForStatusItem:self];
  NSString *type = (count == 1) ? self.singularType : self.pluralType;
  self.textLabel.text = [NSString stringWithFormat:@"%i %@",count,type];
}

- (void)dealloc {
  [textLabel release];
  [singularType release];
  [pluralType release];
  [super dealloc];
}

@end
