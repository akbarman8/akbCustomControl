//
//  ABExtensions.m
//  ABCustomControl
//
//  Created by Amit Kumar Barman on 8/22/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//

#import "ABExtensions.h"
//----------------------------------------------------------------------------------------------------------------------
@implementation NSBundle (CIG)

+ (NSBundle *)mainBundleCore {
    static NSBundle* coreBundle = nil;
    if (!coreBundle) {
        NSLog(@"%@", [[NSBundle mainBundle] resourcePath]);
        NSString *coreBundlePath = [[NSBundle mainBundle] pathForResource:@"ABResourceBundle"
                                                                   ofType:@"bundle"];
        coreBundle = [NSBundle bundleWithPath:coreBundlePath];
    }
    return coreBundle;
}

@end


//----------------------------------------------------------------------------------------------------------------------
#pragma mark - NSdata Category
//----------------------------------------------------------------------------------------------------------------------
@implementation NSData (Extension)

- (NSString *)stringWithUTF8Data {
    NSData *data = [self copy];
    return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
}

- (NSString *)stringFromData {
    NSData *data = [self copy];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end


//----------------------------------------------------------------------------------------------------------------------
#pragma mark - NSNull Category
//----------------------------------------------------------------------------------------------------------------------
@implementation NSNull (Extension)

- (NSString *)nullToEmpty {
    NSNull *null = [self copy];
    if (!null) {
        return @"";
    }
    return @"";
}

@end


//----------------------------------------------------------------------------------------------------------------------

