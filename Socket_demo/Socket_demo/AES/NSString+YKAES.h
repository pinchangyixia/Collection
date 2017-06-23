//
//  NSString+YKAES.h
//  besttoneMobile
//
//  Created by Besttone on 15/11/6.
//  Copyright (c) 2015年 Besttone. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (YKAES)
-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;

- (NSString *)md5:(NSString *)str;

+ (NSString*) AES128Encrypt:(NSString *)plainText key:(NSString *)key;

+ (NSString*) AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

//获取文件的MD5
+ (NSString *)getImageMD5:(NSString *)path;
@end
