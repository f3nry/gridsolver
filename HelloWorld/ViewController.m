//
//  ViewController.m
//  HelloWorld
//
//  Created by Henry, Paul on 10/28/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import "ViewController.h"
#import "GridParser.h"
#import "Grid.h"
#import "GridSolver.h"

@interface ViewController ()
- (IBAction)solveGrid:(id)sender;
@end

@implementation ViewController

- (IBAction)solveGrid:(id)sender {
    if([self.wordInput.text length] == 0) {
        return;
    }
    
    [self resetlabels];

    GridSolver *gridSolver = [[GridSolver alloc] initWithGrid:self.grid];
    
    [gridSolver registerForCharacterSolved:^(NSUInteger x, NSUInteger y) {
        UILabel* referencedLabel = [[self.labels objectAtIndex:y] objectAtIndex:x];
        
        referencedLabel.textColor = [UIColor redColor];
    }];
    
    [gridSolver solve: self.wordInput.text];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.grid = [GridParser parse:@"grid.txt"];
    [self loadGrid];
}

- (void) resetlabels {
    [self.labels enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL *stop) {
        [obj enumerateObjectsUsingBlock:^(UILabel* label, NSUInteger idx, BOOL *stop) {
            label.textColor = [UIColor blackColor];
        }];
    }];
}

- (void)loadGrid {
    NSUInteger startX = 5;
    NSUInteger startY = 40;
    
    self.labels = [[NSMutableArray alloc] init];
    
    [self.grid yieldGrid:^(NSString *character, NSUInteger x, NSUInteger y) {
        if ([self.labels count] <= y) {
            [self.labels addObject:[[NSMutableArray alloc] init]];
        }
        
        NSMutableArray* lineLabels = [self.labels objectAtIndex:y];
        
        NSUInteger calculatedX = 18 * x + startX;
        NSUInteger calculatedY = 20 * y + startY;
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(calculatedX, calculatedY, 20, 20)];
        label.text = character;
        label.textAlignment = NSTextAlignmentCenter;
        
        [lineLabels addObject:label];
        [self.view addSubview:label];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
