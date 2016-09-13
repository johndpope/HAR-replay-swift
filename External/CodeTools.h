#import <Foundation/Foundation.h>
#import <GZIP/GZIP.h>
#import "Base64.h"

@interface CodeTools : NSObject

+(NSString *)GZipDecompressAndBase64String :(NSString *)zippedString;
+(NSString *)unCompress:(NSData *)data;
+(NSString *)GZipCompressAndBase64String :(NSString *)zippedString;
+(NSData *)Compress:(NSString *)result;

@end
