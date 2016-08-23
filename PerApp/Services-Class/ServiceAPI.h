//
//  ServiceAPI.h
//  TourTravel
//
//  Created by Varun Kumar on 31/01/16.
//  Copyright © 2016 Intelligrape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceAPI : NSObject

typedef NS_ENUM(NSUInteger, EPProgressHUDMaskType) {
    EPProgressHUDMaskTypeNone = 1,  // allow user interactions while HUD is displayed
    EPProgressHUDMaskTypeClear,     // don't allow user interactions
    EPProgressHUDMaskTypeBlack,     // don't allow user interactions and dim the UI in the back of the HUD
    EPProgressHUDMaskTypeGradient,   // don't allow user interactions and dim the UI with a a-la-alert-view background gradient
};

typedef void (^ServiceAPISuccessBlock)(id result);
//typedef void (^ServiceAPIFailureBlock)(NSError* error);
typedef void (^ServiceAPIFailureBlock)(id result);

+ (ServiceAPI *)manager;

-(void) requestWithPost:(NSString*)passUrlString params:(NSDictionary *)params progressHudType:(EPProgressHUDMaskType)progressHUDMaskType success:(ServiceAPISuccessBlock)successBlock failure:(ServiceAPIFailureBlock)failureBlock;

-(void) requestWithGet:(NSString*)passUrlString progressHudType:(EPProgressHUDMaskType)progressHUDMaskType success:(ServiceAPISuccessBlock)successBlock failure:(ServiceAPIFailureBlock)failureBlock;
@end
