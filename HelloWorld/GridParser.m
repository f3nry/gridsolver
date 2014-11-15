//
//  GridParser.m
//  HelloWorld
//
//  Created by Henry, Paul on 10/31/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import "GridParser.h"
#import "Grid.h"

@implementation GridParser
- (id)initFromFile:(NSString*) fileName {
    if(self = [super init]) {
        self.fileName = fileName;
    }
    
    return self;
}

- (NSMutableArray*)parseGrid {
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], self.fileName];
    NSError* error = nil;
    self.rawData = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error: &error];
    
    return [self parseIntoGrid];
}

- (NSMutableArray*)parseIntoGrid {
    NSMutableArray* grid = [[NSMutableArray alloc] init];
    
    [self.rawData enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        [grid addObject: [line componentsSeparatedByString:@" "]];
    }];
    
    return grid;
}

+ (Grid*)parse:(NSString*) fileName {
    NSMutableArray* grid = [[[GridParser alloc] initFromFile: fileName] parseGrid];
    
    return [[Grid alloc] initWithGrid:grid];
}
@end
