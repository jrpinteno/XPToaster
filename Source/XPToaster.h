//
//  XPToaster.h
//  XPToaster
//
//  Created by Xavi R. Pinteño on 30/03/16.
//  Copyright © 2016 Xavi R. Pinteño. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, XPToastType) {
	XPToastTypeInfo = 1
};

@interface XPToaster : NSObject

+ (instancetype) toastCenter;

+ (void) toastMessage:(NSString *)message;
+ (void) toastMessage:(NSString *)message duration:(NSTimeInterval)duration;
+ (void) toastMessage:(NSString *)message duration:(NSTimeInterval)duration type:(XPToastType)type;
+ (void) toastMessage:(NSString *)message duration:(NSTimeInterval)duration type:(XPToastType)type completion:(void(^)(BOOL didTap))completion;

- (void) removeToastsOfType:(XPToastType)type;

#pragma mark - Style

- (void) setFont:(UIFont *)font;
- (void) setTextColor:(UIColor *)color;
- (void) setBackgroundColor:(UIColor *)color;

@end

