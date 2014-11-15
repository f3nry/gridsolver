//
//  Grid.h
//  HelloWorld
//
//  Created by Henry, Paul on 10/31/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Grid : NSObject
@property (nonatomic, strong) NSMutableArray* grid;

- (id)initWithGrid:(NSMutableArray*) grid;
- (void)yieldGrid:(void (^)(NSString *character, NSUInteger x, NSUInteger y))block;
@end
