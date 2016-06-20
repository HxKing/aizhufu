//
//  KKHttpTool.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKHttpTool.h"

#import "AFNetworking.h"
#import "XMLDictionary.h"

@implementation KKHttpTool


+ (void)get:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    __block NSString *url1 = url;
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:url1];
        
        NSString *xmlString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
        NSDictionary *dic = [NSDictionary dictionaryWithXMLString:xmlString];
        
        if (success) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                success(dic);
            }];
        }
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
    
}

@end
