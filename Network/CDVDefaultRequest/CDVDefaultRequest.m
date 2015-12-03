//
//  CDVDefaultRequest.m
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "CDVDefaultRequest.h"

@implementation CDVDefaultRequest

- (instancetype)initRequestWithDictionary:(NSDictionary *)credentialsDictionary
{
    if (self = [super init])
    {
#warning -
//        NSString *urlString = [NSString stringWithFormat:@"%@%@", kAPIEndpointV1, kAuthURLPath];
//        _url = [[NSURL alloc] initWithString:urlString];
//        _parameters = credentialsDictionary;
    }
    
    return self;
}

#pragma mark - Utils

- (void)parseResult:(id)JSON
{
    __weak typeof(self) weakSelf = self;
    if ((JSON == nil) || ([JSON isKindOfClass:[NSDictionary class]] == NO))
    {
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(nil);
            return;
        }
    }
    
    NSDictionary *dataDictionary = (NSDictionary *)JSON;
    if (weakSelf.successBlock)
    {
        weakSelf.successBlock(dataDictionary);
    }
}

@end
