//
//  XPQueue.h
//  XPQueue
//
//  Created by Xavi R. Pinteño on 09/04/16.
//  Copyright © 2016 Xavi R. Pinteño. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface XPQueue<ObjectType> : NSObject

@property (nonatomic, assign, getter=isEmpty) BOOL empty;


#pragma mark - Instantiators

/**
 * Factory method which returns a ZQueue object
 */
+ (instancetype) queue;


#pragma mark - Queue modifiers

/**
 *	Enqueues given object to end
 *
 *	@param object	Object to add. Must be not null
 */
- (void) enqueue:(ObjectType)object;

/**
 *	Dequeues object from queue
 *
 *	@return Dequeued object or nil if queue is empty
 */
- (ObjectType _Nullable) dequeue;

/**
 * Removes all objects in queue that match with predicate
 *
 * @param predicate NSPredicate
 */
- (void) removeObjectsWithPredicate:(NSPredicate *)predicate;

/**
 *	Remove objects in queue from given class
 *
 *	@param class	Objective-C class object
 */
- (void) removeObjectsOfClass:(Class)class;

/**
 * Remove all objects in queue
 */
- (void) emptyQueue;

#pragma mark - Queue getters

/**
 *	Head of queue (first object)
 *
 *	@return Object in head or nil if empty
 */
- (ObjectType _Nullable) head;

/**
 * Elements still in queue
 *
 * @return Number of elements in queue
 */
- (NSUInteger) count;

@end
NS_ASSUME_NONNULL_END
