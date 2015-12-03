//
//  CDVWebCore.m
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "WebCore.h"

#import "AFURLSessionManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

typedef void (^AFFailureBlock_t)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^AFSuccessBlock_t)(AFHTTPRequestOperation *operation, id responseObject);

@interface WebCore ()

/// Decorator for handling 400 HTTP error 
+ (AFHTTPRequestOperation *)requestOperationForRequest:(NSURLRequest *)request
                                successCompletionBlock:(AFSuccessBlock_t)success
                                               failure:(AFFailureBlock_t)failure;

@end

static NSString * const kGETRequestMethod = @"GET";
static NSString * const kPOSTRequestMethod = @"POST";
static NSString * const kDELETERequestMethod = @"DELETE";
static NSString * const kPATCHRequestMethod = @"PATCH";

@implementation CDVWebCore

#pragma mark - GET

+ (AFHTTPRequestOperation *)getRequestWithUrl:(NSURL *)url
                                      success:(SuccessBlock)success
                                      failure:(FailureBlock)failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //    [request setValue:kSigningProfileTypeProduction forHTTPHeaderField:kSigningProfileType];
    
//    [request setHTTPBody:jsonData];
    [request setHTTPMethod:kGETRequestMethod];
    return [self requestOperationForRequest:request successCompletionBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success)
        {
            success([NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark - POST

+ (AFHTTPRequestOperation *)postRequestWithURL:(NSURL *)url
                                    parameters:(NSDictionary *)parameters
                                       success:(SuccessBlock)success
                                       failure:(FailureBlock)failure
{
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&jsonError];
    if (jsonError != nil)
    {
        failure(jsonError);
        return nil;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:kSigningProfileTypeProduction forHTTPHeaderField:kSigningProfileType];

    [request setHTTPBody:jsonData];
    [request setHTTPMethod:kPOSTRequestMethod];
    
    return [self requestOperationForRequest:request successCompletionBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success)
        {
            success([NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark - DELETE

+ (AFHTTPRequestOperation *)deleteRequestWithURL:(NSURL *)url
                                      parameters:(NSDictionary *)parameters
                                         success:(SuccessBlock)success
                                         failure:(FailureBlock)failure
{
    NSError *jsonError;
    if (jsonError != nil)
    {
        failure(jsonError);
        return nil;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:kSigningProfileTypeProduction forHTTPHeaderField:kSigningProfileType];

    [request setHTTPMethod:kDELETERequestMethod];
    
    return [self requestOperationForRequest:request successCompletionBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success)
        {
            success([NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark - PATCH

+ (AFHTTPRequestOperation *)patchRequestWithURL:(NSURL *)url
                                     parameters:(NSDictionary *)parameters
                                        success:(SuccessBlock)success
                                        failure:(FailureBlock)failure
{
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&jsonError];
    if (jsonError != nil)
    {
        failure(jsonError);
        return nil;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:kSigningProfileTypeProduction forHTTPHeaderField:kSigningProfileType];
    
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:kPATCHRequestMethod];
    
    return [self requestOperationForRequest:request successCompletionBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success)
        {
            success([NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark - Images

+ (AFHTTPRequestOperation *)getImageWithURLString:(NSString *)URLString
                                       parameters:(NSDictionary *)parameters
                                          success:(SuccessImageRequestBlock)success
                                          failure:(FailureBlock)failure
{
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:URLString]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id image = responseObject;
        if (success)
        {
            success(image);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
    
    return requestOperation;
}

+ (AFHTTPRequestOperation *)postFormDataWithImage:(UIImage *)image
                                        URLString:(NSString *)URLString
                                       parameters:(NSDictionary *)parameters
                                          success:(SuccessBlock)success
                                          failure:(FailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kServerURLAddress]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:kAccept forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:kAuthKey forHTTPHeaderField:@"Authorization"];
    
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/problem+json"];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/hal+json"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    
    AFHTTPRequestOperation *uploadOperation = [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (imageData)
        {
            [formData appendPartWithFileData:imageData name:@"picture" fileName:@"newimage.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id JSON = responseObject;
        if (success)
        {
            success(JSON);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
    
    return uploadOperation;
}

#pragma mark - Utils

+ (AFHTTPRequestOperation *)requestOperationForRequest:(NSURLRequest *)request
                                successCompletionBlock:(AFSuccessBlock_t)success
                                               failure:(AFFailureBlock_t)failure
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    id decoratedSuccess = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(operation, responseObject);
    };
    
    id decoratedFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSInteger errorCode = [operation.response statusCode];

        if (errorCode == 400)
        {
#warning - handle error
        }
        NSError *httpError = [NSError errorWithDomain:@"com.coveveyor.http_error" code:errorCode userInfo:nil];
        failure(operation, httpError);
    };
    
    [operation setCompletionBlockWithSuccess:decoratedSuccess failure:decoratedFailure];
    
    return operation;
}

@end
