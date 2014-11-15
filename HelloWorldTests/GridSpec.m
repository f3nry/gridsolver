//
//  GridSpec.m
//  HelloWorld
//
//  Created by Henry, Paul on 11/14/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import "Kiwi.h"
#import "Grid.h"

SPEC_BEGIN(GridSpec)

describe(@"Grid", ^{
    describe(@"initWithGrid", ^{
        it(@"initializes a Grid with a raw grid", ^{
            NSMutableArray* rawGrid = [[NSMutableArray alloc] initWithArray: @[
                [[NSMutableArray alloc] initWithArray:@[@"A", @"B"]]
            ]];
            Grid* grid = [[Grid alloc] initWithGrid:rawGrid];
            [[grid.grid should] beIdenticalTo:rawGrid];
        });
    });
    
    describe(@".yieldGrid", ^{
        it(@"yields the grid one character at a time with the coordinates of that character", ^{
            NSMutableArray* rawGrid = [[NSMutableArray alloc] initWithArray: @[
                [[NSMutableArray alloc] initWithArray:@[@"A", @"B"]]
            ]];
            
            Grid* grid = [[Grid alloc] initWithGrid:rawGrid];
            
            [grid yieldGrid:^(NSString *character, NSUInteger x, NSUInteger y) {
                if([character isEqualToString:@"A"]) {
                    [[theValue(x) should] equal: theValue(0)];
                    [[theValue(y) should] equal: theValue(0)];
                } else {
                    [[character should] equal: @"B"];
                    [[theValue(x) should] equal: theValue(1)];
                    [[theValue(y) should] equal: theValue(0)];                   
                }
            }];
        });
    });
});

SPEC_END
