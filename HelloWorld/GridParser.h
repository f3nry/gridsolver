//
//  GridParser.h
//  HelloWorld
//
//  Created by Henry, Paul on 10/31/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grid.h"

@interface GridParser : NSObject
@property (nonatomic, strong) NSString* fileName;
@property (nonatomic, strong) NSString* rawData;


+ (Grid*)parse:(NSString*) fileName;

- (id)initFromFile:(NSString*) _fileName;
- (NSMutableArray*)parseGrid;

@end
