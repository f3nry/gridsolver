//
//  GridSolver.m
//  HelloWorld
//
//  Created by Henry, Paul on 10/31/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import "GridSolver.h"
#import "Grid.h"
#import <UIKit/UIKit.h>

#define GridSolverDirectionRight     [[PointTuple alloc] initWithPoint:1 y:0]
#define GridSolverDirectionRightUp   [[PointTuple alloc] initWithPoint:1 y:-1]
#define GridSolverDirectionUp        [[PointTuple alloc] initWithPoint:0 y:-1]
#define GridSolverDirectionLeftUp    [[PointTuple alloc] initWithPoint:-1 y:-1]
#define GridSolverDirectionLeft      [[PointTuple alloc] initWithPoint:-1 y:0]
#define GridSolverDirectionLeftDown  [[PointTuple alloc] initWithPoint:-1 y:1]
#define GridSolverDirectionDown      [[PointTuple alloc] initWithPoint:0 y:1]
#define GridSolverDirectionRightDown [[PointTuple alloc] initWithPoint:1 y:1]

@implementation PointTuple

- (id)initWithPoint:(NSInteger) x y:(NSInteger) y {
    if(self == [super init]) {
        self.x = x;
        self.y = y;
    }
    
    return self;
}

@end

@interface GridSolver ()

@property Grid *grid;
@property NSMutableArray *rawGrid;

- (void)notifyListeners: (NSUInteger) x y: (NSUInteger) y;

@end

@implementation GridSolver
- (id)initWithGrid: (Grid*) grid {
    if(self == [super init]) {
        self.listeners = [[NSMutableArray alloc] init];
        self.grid = grid;
        self.rawGrid = grid.grid;
    }
    
    return self;
}

- (unsigned long) width {
    return [[self.rawGrid objectAtIndex:0] count];
}

- (void)registerForCharacterSolved:(void (^)(NSUInteger, NSUInteger))block {
    [self.listeners addObject:block];
}

- (void)notifyListeners: (NSUInteger) x y: (NSUInteger) y {
    [self.listeners enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        void (^block)(NSUInteger, NSUInteger) = (void (^)(NSUInteger, NSUInteger))obj;
        block(x, y);
    }];
}

- (char) characterAtRawGridIndex: (NSUInteger) x y: (NSUInteger) y {
    NSString* character = [[self.rawGrid objectAtIndex: y] objectAtIndex: x];
    return [character characterAtIndex:0];
}

- (PointTuple*) findFirstOccurenceOf: (NSString*) c start: (PointTuple*) point {
    NSUInteger index = point.x == 0 ? point.x : point.x + 1;
    
    for(NSUInteger y = point.y; y < [self.rawGrid count]; y++) {
        NSArray* row = [self.rawGrid objectAtIndex:y];
        
        if(row) {
            while((index = [row indexOfObject: c inRange: NSMakeRange(index, [row count] - index)]) != NSNotFound) {
                NSLog(@"Index: %lu", index);
                
                return [[PointTuple alloc] initWithPoint:index y:y];
            }
        }
        
        index = 0;
    }
    
    return nil;
}

- (BOOL) pointInBounds: (NSInteger) x y: (NSInteger) y {
    if(x < 0 || y < 0) {
        return false;
    }
    
    if(y < [self.rawGrid count]) {
        NSArray* secondDimension = [self.rawGrid objectAtIndex:y];
        if(secondDimension && x < [secondDimension count]) {
            return true;
        }
    }
    
    return false;
}

- (char) characterAtIndex: (NSInteger) x y: (NSInteger) y {
    NSString* character = [[self.rawGrid objectAtIndex:y] objectAtIndex: x];
    return [character characterAtIndex:0];
}

- (NSArray*) searchDirection: (const char*) characters start: (PointTuple*) start incrementX: (NSInteger) incrementX incrementY: (NSInteger) incrementY {
    NSMutableArray* foundPositions = [[NSMutableArray alloc] initWithArray:@[start]];
    NSInteger startX = start.x;
    NSInteger startY = start.y;
    
    for (int i = 1; i < strlen(characters); i++) {
        startX += incrementX;
        startY += incrementY;
        
        if([self pointInBounds:startX y:startY]) {
            NSLog(@"Incremented point to %li,%li still in bounds, searching %li,%li", startX, startY, incrementX, incrementY);
            if([self characterAtIndex:startX y:startY] == characters[i]) {
                NSLog(@"Character %c found at %li,%li", characters[i], startX, startY);
                [foundPositions addObject:[[PointTuple alloc] initWithPoint: startX y: startY]];
            }
        } else {
            return nil;
        }
    }
    
    if([foundPositions count] == strlen(characters)) {
        return foundPositions;
    } else {
        return nil;
    }
}

- (NSArray*) possibleSearchDirections {
    return @[GridSolverDirectionRight,
             GridSolverDirectionRightUp,
             GridSolverDirectionUp,
             GridSolverDirectionLeftUp,
             GridSolverDirectionLeft,
             GridSolverDirectionLeftDown,
             GridSolverDirectionDown,
             GridSolverDirectionRightDown];
}

- (NSArray*) findWord: (NSString*) word {
    NSString* firstCharacter = [NSString stringWithFormat:@"%c", [word characterAtIndex:0]];
    PointTuple* startingPoint = [[PointTuple alloc] initWithPoint:0 y:0];
    
    startingPoint = [self findFirstOccurenceOf:firstCharacter start: startingPoint];
    
    while(startingPoint) {
        NSLog(@"Found character %@ at %lu,%lu", firstCharacter, (unsigned long)startingPoint.x, (unsigned long)startingPoint.y);
        
        for (PointTuple* direction in [self possibleSearchDirections]) {
            NSArray* foundPositions = [self searchDirection:[word UTF8String] start:startingPoint incrementX:direction.x incrementY:direction.y];
            
            if(foundPositions) {
                return foundPositions;
            }
        }
        
        startingPoint = [self findFirstOccurenceOf:firstCharacter start: startingPoint];
    }
    
    return nil;
}

- (void)solve: (NSString*) word {
    NSArray* positions = [self findWord: word];
    
    if(positions) {
        for(PointTuple* position in positions) {
            [self notifyListeners:position.x y:position.y];
        }
    }
}
@end
