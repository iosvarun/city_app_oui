//
//  CommonFunctions.m
//  Eprotege
//
//  Created by abhayam on 21/09/15.
//  Copyright (c) 2015 TTN. All rights reserved.
//

#import "CommonFunctions.h"
#import "Utility.h"
#import "Constants.h"

#import "Reachability.h"

@interface NSObject ()
- (void)leftDrawerButtonPress:(id)sender;
- (void)backBtnAciton:(id)sender;
-(void)searchBtnAction :(id)sender;
@end

#pragma mark - Notification

void removeNotification(id sender){
    [[NSNotificationCenter defaultCenter] removeObserver:sender];
}
void postNotification(NSString *name, id object){
     [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}
void addNotification(NSString *name, id sender,SEL selector,id object){
     [[NSNotificationCenter defaultCenter] addObserver:sender selector:selector name:name object:object];
}

#pragma mark- Custom

void startShake (UIView* view)
{
    CGAffineTransform leftShake = CGAffineTransformMakeTranslation(-5, 0);
    CGAffineTransform rightShake = CGAffineTransformMakeTranslation(0, 0);
    
    view.transform = leftShake;  // starting point
    
    [UIView beginAnimations:@"shake_button" context:(__bridge void *)(view)];
    [UIView setAnimationRepeatAutoreverses:YES]; // important
    [UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:0.06];
    
    shakeEnded(@"shake_button", YES, (__bridge void *)(view));
    view.transform = rightShake; // end here & auto-reverse
    [UIView commitAnimations];
}

void shakeEnded (NSString * animationID, BOOL finished, void *context)
{
    if (finished) {
        UIView* item = (__bridge UIView *)context;
        item.transform = CGAffineTransformIdentity;
    }
}

void showCustomAlert (NSString * title,NSString * message){
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alerView show];
}

#pragma mark-  Custom Back Button

void customBackButtonForController (UIViewController *controller){
    
    UIButton *customBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBackBtn.frame = CGRectMake(0, 0, 22, 22);
    BUTTONIMAGE(customBackBtn, "backArrow");
    BUTTON_ADD_TARGET(customBackBtn,controller,backBtnAciton:);
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:customBackBtn];
    [controller.navigationItem setLeftBarButtonItem:leftBarBtnItem animated:YES];
}

void customRightForController(UIViewController *controller){
    UIButton *customBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBackBtn.frame = CGRectMake(270, 0, 25, 25);
    BUTTONIMAGE(customBackBtn, "search");
    BUTTON_ADD_TARGET(customBackBtn,controller,searchBtnAction:);
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:customBackBtn];
    [controller.navigationItem setRightBarButtonItem:leftBarBtnItem animated:YES];
}

#pragma mark- Manage Drawer

void manageFlyOur(UIViewController *controller){
    UIButton *leftDrawerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftDrawerButton.frame = CGRectMake(0, 0, 22, 22);
    BUTTONIMAGE(leftDrawerButton, "icon_menu");
    BUTTON_ADD_TARGET(leftDrawerButton, controller, leftDrawerButtonPress:);
    
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftDrawerButton];
    [controller.navigationItem setLeftBarButtonItem:leftBarBtnItem animated:YES];
}


#pragma mark - Add multiple buttons on right side
void customNavigationRightButtonForController(UIViewController *controller){
    UIButton *customBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBackBtn.frame = CGRectMake(0, 0, 75, 75);
    
    customBackBtn.backgroundColor = [UIColor blueColor];;
    
    UIButton *customBackBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    customBackBtn2.frame = CGRectMake(0, 0, 50, 50);
    customBackBtn2.backgroundColor = [UIColor redColor];;
    
    BUTTONIMAGE(customBackBtn, "icon_menu");
    BUTTONIMAGE(customBackBtn2, "backArrow");
    
    BUTTON_ADD_TARGET(customBackBtn,controller,searchBtnAction:);
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:customBackBtn];
    UIBarButtonItem *rightBarBtnItem2 = [[UIBarButtonItem alloc] initWithCustomView:customBackBtn2];
    
    //    [controller.navigationItem setRightBarButtonItem:rightBarBtnItem animated:YES];
    
    controller.navigationItem.rightBarButtonItems = @[rightBarBtnItem2,rightBarBtnItem];
    
}


#pragma mark- String
NSMutableAttributedString* attributedStringForString(NSString *string,NSString *fontName,CGFloat size, UIColor *color){
    string = isNonEmptyString(string)?string:@"";
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:fontName size:size], NSFontAttributeName,color,NSForegroundColorAttributeName,nil];
    
    return [[NSMutableAttributedString alloc] initWithString:string attributes:attributesDictionary];
}


BOOL isNonEmptyString(NSString *string){
    if (string == (id)[NSNull null] || string.length == 0 ){
        return NO;
    }else{
        return YES;
    }
}


#pragma mark - Date

NSDate* fixFormatDateFromString(NSString* timeString)
{
    NSDate *gmtDate = dateFromStringWithFormat(timeString, @"dd'.'MM'.'yyyy HH:mm:ss");
    NSDate* currentDate = timeWithGMTTime(gmtDate);
    return currentDate;
}


NSDate* timeWithGMTTime(NSDate* gmtTime)
{
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:gmtTime];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:gmtTime];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:gmtTime];
    return destinationDate;
}

NSDate* exactTimeWith(NSDate* sourceDate)
{
    //get current time
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* currentTime = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    return currentTime;
}



NSDate* dateFromInterval(NSTimeInterval interval)
{
    if(interval == 0)
        return nil;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
    return date;
}

NSDate* gmtDateWithDate(NSDate* date)
{
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    gmtInterval = -gmtInterval;
    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
    //DEBUG_LOG(@"gmtDateWithDate %@",destinationDate);
    return destinationDate;
}


NSDate* dateWithCurrentTimeZone(NSDate* date)
{
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
    //DEBUG_LOG(@"dateWithCurrentTimeZone %@",destinationDate);
    return destinationDate;
}

NSDate* dateFromStringWithFormat(NSString* str,NSString* format)
{
    if(!isNonEmptyString(str))
       str = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormatter dateFromString:str];
        
    return date;
}

NSDate* dateFromString(NSString* str,NSString* format)
{
    if(!isNonEmptyString(str))
        return [NSDate new];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}


#pragma mark- UIFont
UIFont* fontWithName(NSString* name,float size)
{
    return [UIFont fontWithName:name size:size];
}

#pragma mark - Save & Remove Data

void saveDataWithKey(id data,NSString *key){
    
}

id dataWithKey(NSString *key){
    return nil;
}



@implementation CommonFunctions

#pragma mark Check connectivity method
+(void)isInternetConnected:(void(^)(void))online ifDisconnected:(void(^)(void))offline
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    if ([reachability currentReachabilityStatus] != 0) {
        online();
    }
    else {
        offline();
    }
}
@end
