//
//  GridSolver.h
//  HelloWorld
//
//  Created by Henry, Paul on 10/31/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grid.h"

@interface PointTuple : NSObject
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;

- (id)initWithPoint: (NSInteger) x y: (NSInteger) y;
@end

@interface GridSolver : NSObject
@property NSMutableArray* listeners;

- (id)initWithGrid: (Grid*) grid;
- (void)registerForCharacterSolved:(void (^)(NSUInteger x, NSUInteger y))block;
- (void)solve: (NSString*) word;
@end
