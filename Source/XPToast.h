//
//  XPToast.h
//  XPToaster
//
//  Created by Xavier R. Pinteño on 08/05/2016.
//  Copyright © 2016 Xavier R. Pinteño. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XPToastType);

@interface XPToast : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) XPToastType type;
@property (nonatomic, strong) void (^completion)(BOOL didTap);

@end
