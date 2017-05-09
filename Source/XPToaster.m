//
//  XPToaster.m
//  XPToaster
//
//  Created by Xavi R. Pinteño on 30/03/16.
//  Copyright © 2016 Xavi R. Pinteño. All rights reserved.
//

#import "XPToaster.h"

#import "XPQueue.h"
#import "XPToastView.h"
#import "XPToast.h"

@interface XPToaster () <XPToastViewDelegate>

/** Queue to hold toasts */
@property (nonatomic, strong) XPQueue<XPToast *> *toastQueue;

@property (nonatomic, strong) XPToast *currentToast;
@property (nonatomic, strong) XPToastView *toastView;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;

@end

@implementation XPToaster

#pragma mark - Toasters

+ (void) toastMessage:(NSString *)message {
	[[self toastCenter] toast:message duration:XPToastDuration type:XPToastTypeInfo completion:nil];
}

+ (void) toastMessage:(NSString *)message duration:(NSTimeInterval)duration {
	[[self toastCenter] toast:message duration:duration type:XPToastTypeInfo completion:nil];
}

+ (void) toastMessage:(NSString *)message duration:(NSTimeInterval)duration type:(XPToastType)type {
	[[self toastCenter] toast:message duration:duration type:type completion:nil];
}

+ (void) toastMessage:(NSString *)message duration:(NSTimeInterval)duration type:(XPToastType)type completion:(void(^)(BOOL didTap))completion {
	[[self toastCenter] toast:message duration:duration type:type completion:completion];
}

+ (instancetype) toastCenter {
	static XPToaster *_toastCenter = nil;
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
		_toastCenter = [[self alloc] init];
	});

	return _toastCenter;
}

- (instancetype) init {
	self = [super init];

	if (self) {
		_toastQueue = [XPQueue queue];
		_currentToast = nil;
		_toastView = nil;
	}

	return self;
}

- (void) toast:(NSString *)message duration:(NSTimeInterval)duration type:(XPToastType)type completion:(void(^)(BOOL didTap))completion {
	XPToast *toast = [XPToast new];
	toast.message = message;
	toast.duration = (duration >= 0) ? duration : XPToastDuration;
	toast.type = type;
	toast.completion = completion;

	[self.toastQueue enqueue:toast];

	if (!self.currentToast) {
		[self showToast];
	}
}


- (void) removeToastsOfType:(XPToastType)type {
	NSPredicate *toastType = [NSPredicate predicateWithFormat:@"type == %lu", (unsigned long)type];
	[self.toastQueue removeObjectsWithPredicate:toastType];
}


#pragma mark - XPToastViewDelegate

- (void) toastDidHide:(XPToastView *)toastView tapped:(BOOL)wasTapped {
	if (wasTapped && self.currentToast.completion) {
		self.currentToast.completion(wasTapped);
	}

	self.toastView = nil;
	[self showToast];
}


#pragma mark - Toasts style
// TODO: Use a styler to allow proper customization

- (void) setFont:(UIFont *)font {
	_font = font;
}

- (void) setTextColor:(UIColor *)color {
	_textColor = color;
}

- (void) setBackgroundColor:(UIColor *)color {
	_backgroundColor = color;
}


#pragma mark - Convenience methods

- (void) showToast {
	self.currentToast = [self.toastQueue dequeue];

	if (self.currentToast) {
		XPToastView *toastView = [XPToastView toast];
		toastView.message = self.currentToast.message;
		toastView.duration = self.currentToast.duration;
		toastView.delegate = self;

		// Set style for view
		toastView.backgroundColor = self.backgroundColor;
		[toastView setTextColor:self.textColor];
		[toastView setFont:self.font];

		self.toastView = toastView;
		[self.toastView toastIt];
	}
}

@end
