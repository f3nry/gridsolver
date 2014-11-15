//
//  SampleSpec.m
//  HelloWorld
//
//  Created by Henry, Paul on 11/14/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import "Kiwi.h"
#import "GridParser.h"

SPEC_BEGIN(GridParserSpec)

describe(@"GridParser", ^{
    describe(@".parse", ^{
        it(@"returns a parsed Grid, given a filename", ^{
            Grid* grid = [GridParser parse:@"grid.txt"];
            NSArray* rawGrid = grid.grid;
            [[theValue([rawGrid count]) should] equal: theValue(4)];
            
            NSArray* firstRow = [rawGrid objectAtIndex:0];
            NSString* firstCharacter = [firstRow objectAtIndex:0];
            [[firstCharacter should] startWithString: @"Y"];
        });
    });
});

SPEC_END