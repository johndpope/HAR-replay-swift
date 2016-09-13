#import "CodeTools.h"

@implementation CodeTools

+(NSString *)GZipDecompressAndBase64String:(NSString *)zippedString
{
    if (zippedString == nil && [zippedString isEqual:@""]) {
        return @"";
    }else{
        NSData * data=[Base64 base64StringFromText:zippedString];
        return [self unCompress:data];
    }
}


+(NSString *)GZipCompressAndBase64String:(NSString *)rawString
{
    if (rawString == nil && [rawString isEqual:@""]) {
        return @"";
    }else{
        NSData *data = [self Compress:rawString];
        NSString *zippedString =[Base64 textFromBase64String:data];
        return zippedString;
    }
}

+(NSString *)unCompress:(NSData *)data
{
    data = [data gunzippedData];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return result;
}

+(NSData *)Compress:(NSString *)result
{
    NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
    
    data = [data gzippedData];
    
    return data;
}


@end
