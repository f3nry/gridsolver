//
//  ViewController.h
//  HelloWorld
//
//  Created by Henry, Paul on 10/28/14.
//  Copyright (c) 2014 Henry, Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grid.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) NSMutableArray* labels;
@property (nonatomic, strong) Grid* grid;
@property (nonatomic, weak) IBOutlet UITextField* wordInput;
@end

