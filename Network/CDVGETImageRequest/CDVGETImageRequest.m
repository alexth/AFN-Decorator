//
//  CDVGETImageRequest.m
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "CDVGETImageRequest.h"

@implementation CDVGETImageRequest

- (instancetype)initWithURLString:(NSString *)URLString
{
    if (self = [super init])
    {
        _formDataURLString = URLString;
    }
    
    return self;
}

#pragma mark - Utils

- (void)downloadedImage:(UIImage *)image
{
    __weak typeof(self) weakSelf = self;
    if ((image == nil) || ([image respondsToSelector:@selector(initWithCGImage:)] == NO))
    {
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(nil);
            return;
        }
    }
    
    if (weakSelf.successBlock)
    {
        weakSelf.successBlock(image);
    }
}

@end
