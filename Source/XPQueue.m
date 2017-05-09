//
//  XPQueue.m
//  XPQueue
//
//  Created by Xavi R. Pinteño on 09/04/16.
//  Copyright © 2016 Xavi R. Pinteño. All rights reserved.
//

#import "XPQueue.h"

@interface XPQueue ()

@property (nonatomic, strong) NSMutableArray *queue;

@end

@implementation XPQueue

+ (instancetype) queue {
	return [[self alloc] init];
}

- (instancetype) init {
	self = [super init];

	if (self) {
		_queue = [[NSMutableArray alloc] init];
	}

	return self;
}

#pragma mark - Queue modifiers

- (void) enqueue:(id)object {
	[self.queue addObject:object];
}

- (id _Nullable) dequeue {
	id dequeuedObject = nil;

	if (!self.isEmpty) {
		dequeuedObject = [self.queue firstObject];
		[self.queue removeObjectAtIndex:0];
	}

	return dequeuedObject;
}

- (void) emptyQueue {
	[self.queue removeAllObjects];
}

- (void) removeObjectsWithPredicate:(NSPredicate *)predicate {
	if (!predicate) {
		return;
	}

	NSArray *matchingObjects = [self.queue filteredArrayUsingPredicate:predicate];

	if (matchingObjects.count > 0) {
		[self.queue removeObjectsInArray:matchingObjects];
	}
}

- (void) removeObjectsOfClass:(Class)class {
	for (id object in self.queue.copy) {
		if ([object isKindOfClass:class]) {
			[self.queue removeObject:object];
		}
	}
}

#pragma mark - Queue getters

- (id _Nullable) head {
	return [self.queue firstObject];
}

- (BOOL) isEmpty {
	return self.queue.count == 0;
}

- (NSUInteger) count {
	return self.queue.count;
}

@end
