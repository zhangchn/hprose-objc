/**********************************************************\
|                                                          |
|                          hprose                          |
|                                                          |
| Official WebSite: http://www.hprose.com/                 |
|                   http://www.hprose.org/                 |
|                                                          |
\**********************************************************/
/**********************************************************\
 *                                                        *
 * HproseFormatter.m                                      *
 *                                                        *
 * hprose formatter class for Objective-C.                *
 *                                                        *
 * LastModified: Jun 5, 2016                              *
 * Author: Ma Bingyao <andot@hprose.com>                  *
 *                                                        *
\**********************************************************/

#import <objc/runtime.h>
#import "HproseFormatter.h"
#import "HproseWriter.h"
#import "HproseReader.h"

@implementation HproseFormatter

+ (NSData *) serialize:(id)obj {
    return [self serialize:obj simple:NO];
}

+ (NSData *) serialize:(id)obj simple:(BOOL)simple {
    NSOutputStream *ostream = [NSOutputStream outputStreamToMemory];
    HproseWriter *writer = [HproseWriter writerWithStream:ostream simple:simple];
    [ostream open];
    @try {
        [writer serialize:obj];
        return [ostream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    }
    @finally {
        [ostream close];
        ostream = nil;
        writer = nil;
    }
}

+ (id) unserialize:(NSData *)data {
    return [self unserialize:data withClass:Nil withType:_C_ID simple:NO];
}

+ (id) unserialize:(NSData *)data withClass:(Class)cls {
    return [self unserialize:data withClass:cls withType:_C_ID simple:NO];
}

+ (id) unserialize:(NSData *)data withType:(char)type {
    return [self unserialize:data withClass:Nil withType:type simple:NO];
}

+ (id) unserialize:(NSData *)data withClass:(Class)cls withType:(char)type {
    return [self unserialize:data withClass:cls withType:type simple:NO];
}

+ (id) unserialize:(NSData *)data simple:(BOOL)simple {
    return [self unserialize:data withClass:Nil withType:_C_ID simple:simple];
}

+ (id) unserialize:(NSData *)data withClass:(Class)cls simple:(BOOL)simple {
    return [self unserialize:data withClass:cls withType:_C_ID simple:simple];
}

+ (id) unserialize:(NSData *)data withType:(char)type simple:(BOOL)simple {
    return [self unserialize:data withClass:Nil withType:type simple:simple];
}

+ (id) unserialize:(NSData *)data withClass:(Class)cls withType:(char)type simple:(BOOL)simple {
    NSInputStream *istream = [NSInputStream inputStreamWithData:data];
    HproseReader *reader = [HproseReader readerWithStream:istream simple:simple];
    [istream open];
    @try {
        return [reader unserialize:cls withType:type];
    }
    @finally {
        [istream close];
        istream = nil;
        reader = nil;
    }
}

@end
