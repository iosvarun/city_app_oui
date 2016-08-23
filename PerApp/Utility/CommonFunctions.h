//
//  CommonFunctions.h
//  Eprotege
//
//  Created by abhayam on 21/09/15.
//  Copyright (c) 2015 TTN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Notification
void removeNotification(id sender);
void postNotification(NSString *name, id object);
void addNotification(NSString *name, id sender,SEL selector,id object);

#pragma mark - Custom
void customBackButtonForController(id controller);
void customRightForController(id controller);
void customNavigationRightButtonForController(id controller);
void manageFlyOur(UIViewController *controller);
void startShake (UIView* view);
void shakeEnded (NSString * animationID, BOOL finished, void *context);
void showCustomAlert (NSString * title,NSString * message);

#pragma mark - String
BOOL isNonEmptyString(NSString *string);
NSMutableAttributedString* attributedStringForString(NSString *string,NSString *fontName,CGFloat size, UIColor *color);



#pragma mark - Date
NSDate* dateWithCurrentTimeZone(NSDate* date);
NSDate* dateFromString(NSString* str,NSString* format);
NSDate* gmtDateWithDate(NSDate* date);
NSDate* dateFromInterval(NSTimeInterval interval);
NSDate* beginningOfDay(NSDate *date);
NSDate* endOfDay(NSDate *date);
NSDate* timeWithGMTTime(NSDate* gmtTime);
NSDate* exactTimeWith(NSDate* sourceDate);
NSDate* dateFromStringWithFormat(NSString* str,NSString* format);
NSString* stringFromDate(NSDate* date,NSString* format);
NSString* fixFormatDateStringFromString(NSString* timeString);
NSDate* fixFormatDateFromString(NSString* timeString);

#pragma mark- UIFont
UIFont* fontWithName(NSString* name,float size);



#pragma mark - Save & Remove Data
void saveDataWithKey(id data,NSString *key);
id dataWithKey(NSString *key);
void removeAllCachedData();

@interface CommonFunctions : NSObject

+ (void)isInternetConnected:(void(^)(void))online ifDisconnected:(void(^)(void))offline;

@end
