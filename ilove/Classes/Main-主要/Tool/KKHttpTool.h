//
//  KKHttpTool.h
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKHttpTool : NSObject

+ (void)get:(NSString *)url parame:(NSDictionary *)parame success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

@end
