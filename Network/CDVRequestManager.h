//
//  CDVRequestManager.h
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

typedef void (^RequestManagerSuccessBlock)(BOOL success, NSDictionary *dataDictionary, NSError *error);
typedef void (^RequestManagerGetImageSuccessBlock)(BOOL success, UIImage *image, NSError *error);

@interface CDVRequestManager : NSObject

+ (CDVRequestManager *)sharedInstance;

// GET
- (void)getImageFromURLString:(NSString *)URLString
                 successBlock:(RequestManagerGetImageSuccessBlock)successBlock;

// POST

// DELETE

// PATCH

@end
