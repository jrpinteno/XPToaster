//
//  XPToastView.h
//  XPToaster
//
//  Created by Xavi R. Pinteño on 27/09/15.
//  Copyright © 2015 Xavi R. Pinteño. All rights reserved.
//

@import UIKit;

@class XPToastView;

extern NSTimeInterval const XPFadeDuration;
extern NSTimeInterval const XPToastDuration;

@protocol XPToastViewDelegate <NSObject>

- (void) toastDidHide:(__kindof XPToastView *)toastView tapped:(BOOL)wasTapped;

@end

@interface XPToastView : UIView

@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, weak) id<XPToastViewDelegate> delegate;

/**
 *	Creates toast view
 *
 *	@return Returns view or subtype
 */
+ (instancetype) toast;

/**
 *	Toasts message
 */
- (void) toastIt;

#pragma mark - Style setters

- (void) setFont:(UIFont *)font;
- (void) setTextColor:(UIColor *)color;

@end
