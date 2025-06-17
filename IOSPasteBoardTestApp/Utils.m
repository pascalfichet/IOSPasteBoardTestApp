//
//  Utils.m
//  IOSPasteBoardTestApp
//
//  Created by alexey on 14/05/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject

@end

@implementation Utils



+ (NSString *)hexString:(NSData *) data length:(unsigned int)length {
    const unsigned char *bytes = (const unsigned char *)data.bytes;
    NSMutableString *hex = [NSMutableString new];
    for (NSInteger i = 0; i < MIN(data.length, length); i++) {
        [hex appendFormat:@"%02x", bytes[i]];
    }
    return [hex copy];
}

@end

