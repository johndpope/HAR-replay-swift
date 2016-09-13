#import "Base64.h"
@implementation Base64

+ (NSData *)base64StringFromText:(NSString *)text
{
    NSData* data = [[NSData alloc] initWithBase64EncodedString:text options:0];
    
    return data;
}

+ (NSString *)textFromBase64String:(NSData *)base64
{
    NSData * data = [base64 base64EncodedDataWithOptions:0];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;

}

@end
