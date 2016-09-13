#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+ (NSData *)base64StringFromText:(NSString *)text;
+ (NSString *)textFromBase64String:(NSData *)base64;

@end
