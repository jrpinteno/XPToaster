//
//  XPToastView.m
//  XPToaster
//
//  Created by Xavi R. Pinteño on 27/09/15.
//  Copyright © 2015 Xavi R. Pinteño. All rights reserved.
//

#import "XPToastView.h"

NSTimeInterval const XPFadeDuration = 0.3;
NSTimeInterval const XPToastDuration = 1.5;

@interface XPToastView ()

@property (nonatomic, strong) UILabel *toastLabel;

@end


@implementation XPToastView

+ (instancetype) toast {
	return [[[self class] alloc] init];
}

- (instancetype) init {
	self = [super initWithFrame:CGRectZero];

	if (self) {
		[self setupUI];
		[self setupTap];
	}

	return self;
}

- (void) setMessage:(NSString *)message {
	self.toastLabel.text = message;
}

- (void) setupTap {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
	[self addGestureRecognizer:tap];
}

- (void) handleTap {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideToast) object:nil];
	[self hideToastFromTap:YES];
}

- (void) layoutSubviews {
	[super layoutSubviews];
	self.toastLabel.preferredMaxLayoutWidth = self.toastLabel.frame.size.width;
	[super layoutSubviews];
}

- (void) setupConstraints {
	NSDictionary *views = @{
									@"self": self,
									@"label": self.toastLabel
									};

	NSDictionary *metrics = @{
									  @"horizontalMargin": @(20),
									  @"verticalMargin": @(60)
									  };

	// Center toast horizontally to superview
	[self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
																				  attribute:NSLayoutAttributeCenterX
																				  relatedBy:NSLayoutRelationEqual
																					  toItem:self.superview
																				  attribute:NSLayoutAttributeCenterX
																				 multiplier:1
																					constant:0]];

	// Don't allow toast go grow bigger than side margins
	[self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=horizontalMargin)-[self]-(>=horizontalMargin)-|"
																								  options:0
																								  metrics:metrics
																									 views:views]];

	// Lower margin for toast
	[self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(>=verticalMargin)-|"
																								  options:0
																								  metrics:metrics
																									 views:views]];

	// Add horizontal and vertical constraints for label within view
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|"
																					 options:0
																					 metrics:metrics
																						views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]-|"
																					 options:0
																					 metrics:metrics
																						views:views]];
}

- (void) toastIt {
	// Make sure UI is updated on the main thread
	dispatch_async(dispatch_get_main_queue(), ^{
		UIWindow* window = [UIApplication sharedApplication].keyWindow;
		[[[window subviews] objectAtIndex:0] addSubview:self];

		[self showToast];
	});
}

- (void) setupUI {
	// Toast view
	self.translatesAutoresizingMaskIntoConstraints = NO;
	self.layer.cornerRadius = 10.0;
	self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
	self.alpha = 0.0;
}

#pragma mark - Style setters

- (void) setFont:(UIFont *)font {
	self.toastLabel.font = font;
}

- (void) setTextColor:(UIColor *)color {
	self.toastLabel.textColor = color;
}

#pragma mark - Lazy views

- (UILabel *) toastLabel {
	if (!_toastLabel) {
		// Configure a default label for the toast
		_toastLabel = [[UILabel alloc] init];
		_toastLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_toastLabel.numberOfLines = 0;
		_toastLabel.backgroundColor = [UIColor clearColor];
		_toastLabel.lineBreakMode = NSLineBreakByWordWrapping;
		_toastLabel.textAlignment = NSTextAlignmentCenter;

		[self addSubview:_toastLabel];
	}

	return _toastLabel;
}

- (void) showToast {
	[self setupConstraints];

	[UIView animateWithDuration:XPFadeDuration animations:^{
		self.alpha = 1.0;
	} completion:^(BOOL finished) {
		[self performSelector:@selector(hideToast) withObject:nil afterDelay:self.duration];
	}];
}

- (void) hideToastFromTap:(BOOL)wasTapped {
	[UIView animateWithDuration:XPFadeDuration animations:^{
		self.alpha = 0.0;
	} completion:^(BOOL finished) {
		[self removeFromTap:wasTapped];
	}];
}

- (void) hideToast {
	[self hideToastFromTap:NO];
}

- (void) removeFromTap:(BOOL)wasTapped {
	[self removeFromSuperview];
	[self.delegate toastDidHide:self tapped:wasTapped];
}

- (void) dealloc {
	self.toastLabel = nil;
}

@end
