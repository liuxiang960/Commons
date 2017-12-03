//
//  NSString.m
//  SEUDApp
//
//  Created by Chengkai on 16/8/29.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "NSString+Encrypt.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Encrypt)

-(NSString *)stringByAESEncrypt{
    
    return self;
    NSString *kInitVector = @"16-Bytes--String";/**< 初始向量 */
    size_t kKeySize = kCCKeySizeAES128;
    NSString *key = @"asefd12.012p34h6";/**< Android、PC、iOS三端统一的加密key */
    
    NSData *contentData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    
    // 为结束符'\\0' +1
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}

/**
 *  @author 程凯, 16-08-29 15:08:57
 *
 *  AES解密.
 *
 *  @return 解密后的内容
 *
 *  @since 1.0
 */
//-(NSString *)stringByAESDecrypt{
//    
//    NSString *kInitVector = @"16-Bytes--String";
//    size_t kKeySize = kCCKeySizeAES128;
//    NSString *key = @"asefd12.012p34h6";
//    // 把 base64 String 转换成 Data
//    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSUInteger dataLength = contentData.length;
//    
//    char keyPtr[kKeySize + 1];
//    memset(keyPtr, 0, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    size_t decryptSize = dataLength + kCCBlockSizeAES128;
//    void *decryptedBytes = malloc(decryptSize);
//    size_t actualOutSize = 0;
//    
//    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
//    
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
//                                          kCCAlgorithmAES,
//                                          kCCOptionPKCS7Padding,
//                                          keyPtr,
//                                          kKeySize,
//                                          initVector.bytes,
//                                          contentData.bytes,
//                                          dataLength,
//                                          decryptedBytes,
//                                          decryptSize,
//                                          &actualOutSize);
//    
//    if (cryptStatus == kCCSuccess) {
//        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
//    }
//    free(decryptedBytes);
//    return nil;
//}

-(NSString *)stringByPhoneNumberAESEncrypt{
    if(self.length>7){
        if ([SeudPublic isStringBaoHanString:self myString:@"****"]) {
            return self;
        }else{
            NSString * str = [self substringWithRange:NSMakeRange(3, 4)];
            return [self stringByReplacingOccurrencesOfString:str withString:@"****"];
        }
    }else{
        return self;
    }
}

@end
