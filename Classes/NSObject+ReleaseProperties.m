#import "NSObject+ReleaseProperties.h"
#import <objc/runtime.h>

@implementation NSObject (ReleaseProperties)

- (void)releaseProperties {
  Class class = [self class];
  unsigned int pCount;
  objc_property_t *properties = class_copyPropertyList(class, &pCount);
  
  for (unsigned int i = 0; i < pCount; i++) {
    objc_property_t property = properties[i];
    NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    NSArray *propertyAttributeArray = [propertyAttributes componentsSeparatedByString:@","];
    BOOL isRetained = NO;
    
    for (NSString *string in propertyAttributeArray) {
      isRetained = isRetained || [string isEqual:@"&"] || [string isEqual:@"C"];
    }
    
    if (isRetained) {
      NSString *variableName = nil;
      NSString *lastProperty = (NSString*)[propertyAttributeArray lastObject];
      
      if ([lastProperty hasPrefix:@"V"]) {
        variableName = [lastProperty substringFromIndex:1];
      }
      
      if (variableName != nil) {
        Ivar ivar = class_getInstanceVariable(class, [variableName UTF8String]);
        id value = object_getIvar(self, ivar);
        
        object_setIvar(self, ivar, nil);
        [value release];
      }
    }
  }
  
  free(properties);

}

@end
