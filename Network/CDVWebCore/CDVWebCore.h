//
//  CDVWebCore.h
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

@class AFHTTPRequestOperation;

typedef void (^SuccessBlock)(id JSON);
typedef void (^FailureBlock)(NSError *error);
typedef void (^SuccessImageRequestBlock)(UIImage *image);

@interface CDVWebCore : NSObject

+ (AFHTTPRequestOperation *)getRequestWithUrl:(NSURL *)url
                                      success:(SuccessBlock)success
                                      failure:(FailureBlock)failure;

+ (AFHTTPRequestOperation *)postRequestWithURL:(NSURL *)url
                                    parameters:(NSDictionary *)parameters
                                       success:(SuccessBlock)success
                                       failure:(FailureBlock)failure;

+ (AFHTTPRequestOperation *)deleteRequestWithURL:(NSURL *)url
                                      parameters:(NSDictionary *)parameters
                                         success:(SuccessBlock)success
                                         failure:(FailureBlock)failure;

+ (AFHTTPRequestOperation *)patchRequestWithURL:(NSURL *)url
                                     parameters:(NSDictionary *)parameters
                                        success:(SuccessBlock)success
                                        failure:(FailureBlock)failure;

+ (AFHTTPRequestOperation *)getImageWithURLString:(NSString *)URLString
                                       parameters:(NSDictionary *)parameters
                                          success:(SuccessImageRequestBlock)success
                                          failure:(FailureBlock)failure;

+ (AFHTTPRequestOperation *)postFormDataWithImage:(UIImage *)image
                                        URLString:(NSString *)URLString
                                       parameters:(NSDictionary *)parameters
                                          success:(SuccessBlock)success
                                          failure:(FailureBlock)failure;

@end
