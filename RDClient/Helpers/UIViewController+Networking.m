//
//  UIViewController+Networking.m
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "UIViewController+Networking.h"
#import <AFNetworking.h>
#import <MTLJSONAdapter.h>

NSString * const baseUrl = @"https://www.reddit.com/r/Bitcoin";

@implementation UIViewController (Networking)

- (void) getListingsForType:(NSString *) type
                    afterId:(NSString *) afterId
                    success:(void (^)(id results))success {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSDictionary *dict = afterId ? @{@"after" : afterId} : @{};
    
    [manager GET:[NSString stringWithFormat:@"%@/%@.json",baseUrl,type] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (!responseObject)
        {
            //error
            success(@[]);
            return;
        }
        
        
        NSArray *data = [[responseObject objectForKey:@"data"] objectForKey:@"children"];
        NSError *err;
        
        NSArray *results = [MTLJSONAdapter modelsOfClass:[Listing class] fromJSONArray:data error:&err];
        if(err) {
            
            success(@[]);
            return;
        }
        
        success(results);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        success(@[]);
    }];
}


- (void) getCommentsForListingId:(NSString *) listingId
                         success:(void (^)(id listing, id comments))success {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSDictionary *dict = @{@"sort" : @"top"};
    
    [manager GET:[NSString stringWithFormat:@"%@/comments/%@.json",baseUrl,listingId] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (!responseObject)
        {
            //error handling
            success(@[], @[]);
            return ;
        }
        
        NSArray *listingData = [[[responseObject objectAtIndex:0] objectForKey:@"data"] objectForKey:@"children"];
        NSError *listingErr, *commentsErr;
        NSArray *listingResults = [MTLJSONAdapter modelsOfClass:[Listing class] fromJSONArray:listingData error:&listingErr];
        
        
        NSArray *commentsData = [[[responseObject objectAtIndex:1] objectForKey:@"data"] objectForKey:@"children"];
        NSArray *commentsResults = [MTLJSONAdapter modelsOfClass:[Comment class] fromJSONArray:commentsData error:&commentsErr];

        if(listingErr || commentsErr) {
            //error handling
            success(@[], @[]);
            return;
        }
        
        success(listingResults, commentsResults);
        
   
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //error handling
        success(@[], @[]);
    }];
    
}

@end
