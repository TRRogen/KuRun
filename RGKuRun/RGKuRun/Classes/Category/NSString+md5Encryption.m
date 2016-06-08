//
//  NSString+md5Encryption.m
//  RGKuRun
//
//  Created by TRRogen on 16/6/8.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import "NSString+md5Encryption.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (md5Encryption)

- (NSString *)md5Str{
    const char *myPassword = [self UTF8String];
    unsigned char md5c[16];
    CC_MD5(myPassword,(CC_LONG)strlen(myPassword),md5c);
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [md5Str appendFormat:@"%02x",md5c[i]];
    }
    return [md5Str copy];
    
}



- (NSString *)md5StrXor{
    const char *myPassword = [self UTF8String];
    unsigned char md5c[16];
    CC_MD5(myPassword,(CC_LONG)strlen(myPassword),md5c);
    NSMutableString *md5Str = [NSMutableString string];
    
    [md5Str appendFormat:@"%02x",md5c[0]];
    for (int i = 0; i < 16; i++) {
        [md5Str appendFormat:@"%02x",md5c[i]^md5c[0]];
    }

    
    return [md5Str copy];
}






@end
