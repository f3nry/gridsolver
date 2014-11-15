//
//  Grid.m
//  HelloWorld
//
//  Created by Henry, Paul on 10/31/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import "Grid.h"

@implementation Grid
- (id)initWithGrid:(NSMutableArray *)grid {
    if(self = [super init]) {
        self.grid = grid;
    }
    
    return self;
}

- (void)yieldGrid:(void (^)(NSString *character, NSUInteger x, NSUInteger y))block {
    [self.grid enumerateObjectsUsingBlock:^(NSArray* line, NSUInteger line_idx, BOOL *lineStop) {
        [line enumerateObjectsUsingBlock:^(NSString* character, NSUInteger idx, BOOL *stop) {
            block(character, idx, line_idx);
        }];
    }];
}
@end
