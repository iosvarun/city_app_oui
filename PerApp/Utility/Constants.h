//
//  Constants.h
//  Eprotege
//
//  Created by abhayam on 21/09/15.
//  Copyright (c) 2015 TTN. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef Eprotege_Constants_h
#define Eprotege_Constants_h

//Font Name
static NSString *const kLatoRegularFont = @"Lato-Regular";
static NSString *const kLatoLightFont = @"Lato-Light";
static NSString *const kLatoItalicFont = @"Lato-Italic";
static NSString *const kLatoBoldItalicFont = @"Lato-BoldItalic";
static NSString *const kLatoBoldFont = @"Lato-Bold";

//baseURL
#define BaseUrlString @"http://52.26.209.114:90/webservice.aspx?"

//using API
#define SignIn_API @"/api/login"
#define SignUp_API @"/api/users"
#define Get_Catagories_API @"getcatagories"
#define Get_SubCatagories_API @"getsubcategorypackages"
#define Packagedetails_API @"packagedetails"
#define Get_Offer_List_API @"getofferlist"

#define Get_Home_Offer_List_API @"getoffershome"


#define Get_AppUserDetail_API @"GetAppUserDetails"
#define Registration_API @"registration"
#define Get_Wish_List_API @"getwishlist"
#define Setwishlist_API @"setwishlist"
#define Saveuserenquiry_API @"saveuserenquiry"
#define Get_Company_Details_API @"getcompanydetails"
#define Get_Menu_Details_API @"getmenulist"
#define Checkfavouritepackage_API @"checkfavouritepackage"
#define Getsearchresult_API       @"getsearchresult"
#define Get_Getdocumentlist_API @"getdocumentlist"



#define Getcompanydetailst_API @"getcompanydetails"

static NSString * const DeviceID = @"1464";

// Category API
static NSString * const kCatagoryDescription = @"CatagoryDesc";
static NSString * const kCatagoryID = @"CatagoryID";
static NSString * const kFeederImageURL = @"feederImageURL";
static NSString * const kCatagoryName = @"CatagoryName";
static NSString * const kCatagoryImage = @"CatagoryImage";
static NSString * const kCatagoryTitle = @"CatagoryTitle";

// Category API
static NSString * const kOfferDescription = @"OfferDescription";
static NSString * const kOfferID = @"OfferID";
static NSString * const kOfferImage = @"OfferImage";
static NSString * const kOfferTitle = @"OfferTitle";

// Contact Details API
static NSString * const kStoreId = @"StoreID";
static NSString * const kname = @"Name";
static NSString * const kTourDescription = @"Description";
static NSString * const kTourAddress = @"Address";
static NSString * const kZipCode = @"Zip";
static NSString * const kTelephoneNum = @"Tel";
static NSString * const kFax = @"Fax";
static NSString * const kMail = @"Mail";
static NSString * const kWebsite = @"Website";
static NSString * const kSkype = @"Skype";
static NSString * const kOpeningTime = @"OpeningTime";
static NSString * const kClosingTime = @"ClosingTime";

//

static NSString * const kShowAlertTitleNoConnection = @"Connection Problem";
static NSString * const kShowAlertMessageNoConnection = @"Please check your internet connection";

// search
static NSString * const kSearchPackageID = @"PackageID";
static NSString * const kSearchPackageTitle = @"PackageTitle";
static NSString * const kSearchPackageImage = @"PackageImage";
static NSString * const kSearchOtherDetails = @"OtherDetails";


#endif
