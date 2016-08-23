//
//  ServiceAPI.m
//  TourTravel
//
//  Created by Varun Kumar on 31/01/16.
//  Copyright © 2016 Intelligrape. All rights reserved.
//

#import "ServiceAPI.h"
#include "SVProgressHUD.h"
#import "Constants.h"

@implementation ServiceAPI

+ (ServiceAPI *)manager
{
    static ServiceAPI *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServiceAPI alloc] init];
    });
    
    return manager;
}

// Post Request
-(void) requestWithPost:(NSString*)passUrlString params:(NSDictionary *)params progressHudType:(EPProgressHUDMaskType)progressHUDMaskType success:(ServiceAPISuccessBlock)successBlock failure:(ServiceAPIFailureBlock)failureBlock
{
    
//    if([[AFNetworkReachabilityManager sharedManager] isReachable]){
        NSMutableString *mutableUrlString = [NSMutableString stringWithString:passUrlString];
    
    NSString *urlString = [BaseUrlString stringByAppendingString:[NSString stringWithFormat:@"%@",mutableUrlString]];
    
    NSURL *apiUrl = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:apiUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"Sending Body Data: %@",params);
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params options: kNilOptions error: nil];
    [request setHTTPBody: jsonData];
    [request setValue: [NSString stringWithFormat: @"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSLog(@"urlString %@",urlString);
    NSLog(@"params %@",params);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showWithMaskType:(SVProgressHUDMaskType)progressHUDMaskType];
    });
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                              long code = [httpResponse statusCode];
                                              id tempDict = nil;
                                              tempDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

                                              
                                              NSLog(@"Recieved Data: %@\nStatus Code: %lu\n Error: %@",tempDict, code, error);
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [SVProgressHUD dismiss];
                                                  successBlock(tempDict);
                                                  
                                              });
                                        }];
    [postDataTask resume];
    
    
        
    
 }


// Get Request
-(void) requestWithGet:(NSString*)passUrlString progressHudType:(EPProgressHUDMaskType)progressHUDMaskType success:(ServiceAPISuccessBlock)successBlock failure:(ServiceAPIFailureBlock)failureBlock
{
    
    NSMutableString *mutableUrlString = [NSMutableString stringWithString:passUrlString];
    
    NSString *urlString = [BaseUrlString stringByAppendingString:[NSString stringWithFormat:@"%@",mutableUrlString]];
    
    NSURL *apiUrl = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:apiUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"Get"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showWithMaskType:(SVProgressHUDMaskType)progressHUDMaskType];
    });
    
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                              long code = [httpResponse statusCode];
                                              id tempDict = nil;
                                              tempDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                    
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [SVProgressHUD dismiss];
                                              });
                                              successBlock(tempDict);
                                          }];
    [getDataTask resume];
    
    
}




@end
