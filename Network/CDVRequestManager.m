//
//  CDVRequestManager.m
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "CDVRequestManager.h"
#import "SynthesizeSingleton.h"
#import "AFHTTPRequestOperation.h"

#import "CDVGETImageRequest.h"

@interface CDVRequestManager ()

@property (nonatomic, strong) NSMutableArray *GETImageRequestsArray;

@end

@implementation CDVRequestManager
SYNTHESIZE_SINGLETON_FOR_CLASS(CDVRequestManager)

- (instancetype)init
{
    if ([super init] == self)
    {
        _GETImageRequestsArray = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - Get Requests

- (void)getImageFromURLString:(NSString *)URLString successBlock:(RequestManagerGetImageSuccessBlock)successBlock
{
    CDVGETImageRequest *getImageRequest = [[CDVGETImageRequest alloc] initWithURLString:URLString];
    [self.GETImageRequestsArray addObject:getImageRequest];
    
    __weak CDVGETImageRequest *weakRequest = getImageRequest;
    getImageRequest.failureBlock = ^(NSError *error) {
        
        successBlock(NO, nil, error);
        [self.GETImageRequestsArray removeObject:weakRequest];
    };
    getImageRequest.successBlock = ^(UIImage *image) {
        
        successBlock(YES, image, nil);
        [self.GETImageRequestsArray removeObject:weakRequest];
    };
    
    [getImageRequest.GETImageRequestOperation start];
}

@end
