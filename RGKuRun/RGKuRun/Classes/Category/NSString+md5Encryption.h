//
//  NSString+md5Encryption.h
//  RGKuRun
//
//  Created by TRRogen on 16/6/8.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5Encryption)
- (NSString *)md5Str;
- (NSString *)md5StrXor;
@end
