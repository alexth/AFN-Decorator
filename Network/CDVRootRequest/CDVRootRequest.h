//
//  CDVRootRequest.h
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void (^RequestFailureBlock)(NSError *error);

@interface CDVRootRequest : NSObject
{
    NSURL *_url;
    NSString *_formDataURLString;
    NSDictionary *_parameters;
    UIImage *_image;
}

@property (nonatomic, strong) AFHTTPRequestOperation *GETRequestOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *POSTRequestOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *DELETERequestOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *PATCHRequestOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *GETImageRequestOperation;
@property (nonatomic, copy) RequestFailureBlock failureBlock;
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSString *formDataURLString;
@property (nonatomic, copy, readonly) NSDictionary *parameters;
@property (nonatomic, strong) UIImage *image;

@end

@interface CDVRootRequest (Protected)

- (void)parseResult:(id)JSON;
- (void)downloadedImage:(UIImage *)image;

@end
