//
//  CDVRootRequest.m
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "CDVRootRequest.h"
#import "AFHTTPRequestOperation.h"
#import "CDVWebCore.h"

@interface CDVRootRequest ()

@property(nonatomic, strong) AFHTTPRequestOperation *operation;

@end

@implementation CDVRootRequest

- (AFHTTPRequestOperation *)GETRequestOperation
{
    __weak CDVRootRequest *weakSelf = self;

// TODO: logger
//    NSLog(@"url - %@", [self.url absoluteString]);
    
    self.operation = [CDVWebCore getRequestWithUrl:self.url success:^(id JSON) {
        
        [weakSelf parseResult:JSON];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

- (AFHTTPRequestOperation *)POSTRequestOperation
{
    __weak CDVRootRequest *weakSelf = self;
    
// TODO: logger
//    NSLog(@"url - %@", [self.url absoluteString]);
    
    self.operation = [CDVWebCore postRequestWithURL:self.url parameters:self.parameters success:^(id JSON) {
        
        [weakSelf parseResult:JSON];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

- (AFHTTPRequestOperation *)DELETERequestOperation
{
    __weak CDVRootRequest *weakSelf = self;

// TODO: logger
//    NSLog(@"url - %@", [self.url absoluteString]);
    
    self.operation = [CDVWebCore deleteRequestWithURL:self.url parameters:self.parameters success:^(id JSON) {
        
        [weakSelf parseResult:JSON];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

- (AFHTTPRequestOperation *)PATCHRequestOperation
{
    __weak CDVRootRequest *weakSelf = self;

// TODO: logger
//    NSLog(@"url - %@", [self.url absoluteString]);
    
    self.operation = [CDVWebCore patchRequestWithURL:self.url parameters:self.parameters success:^(id JSON) {
        
        [weakSelf parseResult:JSON];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

- (AFHTTPRequestOperation *)GETImageRequestOperation
{
    __weak CDVRootRequest *weakSelf = self;
    
    self.operation = [CDVWebCore getImageWithURLString:self.formDataURLString parameters:self.parameters success:^(UIImage *image) {
        
        [weakSelf downloadedImage:image];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

#pragma mark - Utils

- (void)parseResult:(id)JSON
{
    
}

- (void)downloadedImage:(UIImage *)image
{
    
}

@end
