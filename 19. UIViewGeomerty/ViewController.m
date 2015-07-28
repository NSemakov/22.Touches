//
//  ViewController.m
//  19. UIViewGeomerty
//
//  Created by Admin on 27.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
@interface ViewController ()
//@property (weak,nonatomic) UIView* board;
@property (weak, nonatomic) IBOutlet UIView *board;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Uchenik + Student
    /*
    CGRect boundsOfView=self.view.bounds;
    CGFloat widthOfboundsOfView=CGRectGetWidth(boundsOfView);
    CGFloat heightOfboundsOfView=CGRectGetHeight(boundsOfView);
    
    CGFloat sizeOfBlackSquare=MIN(widthOfboundsOfView, heightOfboundsOfView)/8;
    
    
    CGFloat verticalPosition=0;
    CGFloat horizontalPosition=widthOfboundsOfView/8;
    
    for (NSInteger row=0; row<8; row++) {
        
        for (NSInteger column=1; column<5; column++) {
            UIView* view=[[UIView alloc]initWithFrame:CGRectMake(horizontalPosition, verticalPosition, sizeOfBlackSquare, sizeOfBlackSquare)];
            view.backgroundColor=[UIColor blackColor];
            
            view.autoresizingMask=UIViewAutoresizingFlexibleRightMargin|
                UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleWidth|
            UIViewAutoresizingFlexibleTopMargin| UIViewAutoresizingFlexibleHeight|
            UIViewAutoresizingFlexibleBottomMargin;
            
            [self.view addSubview:view];
            horizontalPosition+=2*sizeOfBlackSquare;
        }
        verticalPosition+=sizeOfBlackSquare;
        horizontalPosition=(row%2)*widthOfboundsOfView/8;
    }
    */
    //----------
    //end of Uchenik + Student
    
    //Master
    /*
    CGRect boundsOfView=self.view.bounds;
    CGFloat widthOfboundsOfView=CGRectGetWidth(boundsOfView);
    CGFloat heightOfboundsOfView=CGRectGetHeight(boundsOfView);
    
    CGRect board=CGRectMake(0, (heightOfboundsOfView-widthOfboundsOfView)/2, widthOfboundsOfView, widthOfboundsOfView);
    
    CGFloat sizeOfBoard=MIN(widthOfboundsOfView, heightOfboundsOfView);
    CGFloat sizeOfBlackSquare=MIN(widthOfboundsOfView, heightOfboundsOfView)/8;
    UIView *boardView=[[UIView alloc]initWithFrame:board];
    boardView.backgroundColor=[UIColor yellowColor];
    boardView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleRightMargin;
    self.board=boardView;
    [self.view addSubview:boardView];
    CGFloat verticalPosition=0;
    CGFloat horizontalPosition=sizeOfBoard/8;
    
    for (NSInteger row=0; row<8; row++) {
        
        for (NSInteger column=1; column<5; column++) {
            UIView* view=[[UIView alloc]initWithFrame:CGRectMake(horizontalPosition, verticalPosition, sizeOfBlackSquare, sizeOfBlackSquare)];
            view.backgroundColor=[UIColor blackColor];

            [self.board addSubview:view];
            horizontalPosition+=2*sizeOfBlackSquare;
        }
        verticalPosition+=sizeOfBlackSquare;
        horizontalPosition=(row%2)*sizeOfBoard/8;
    }
    */
    //----------
    //end of Master
    
    //Superman
    CGRect boundsOfView=self.board.bounds;
    CGFloat widthOfboundsOfView=CGRectGetWidth(boundsOfView);
    CGFloat heightOfboundsOfView=CGRectGetHeight(boundsOfView);
    
    //CGRect board=CGRectMake(0, (heightOfboundsOfView-widthOfboundsOfView)/2, widthOfboundsOfView, widthOfboundsOfView);
    
    CGFloat sizeOfBoard=MIN(widthOfboundsOfView, heightOfboundsOfView);
    CGFloat sizeOfBlackSquare=MIN(widthOfboundsOfView, heightOfboundsOfView)/8;
    //UIView *boardView=[[UIView alloc]initWithFrame:board];
    //boardView.backgroundColor=[UIColor yellowColor];
    //boardView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|
    //UIViewAutoresizingFlexibleRightMargin;
    //self.board=boardView;
    //[self.view addSubview:boardView];
    CGFloat verticalPosition=0;
    CGFloat horizontalPosition=sizeOfBoard/8;
    
    for (NSInteger row=0; row<8; row++) {
        
        for (NSInteger column=1; column<5; column++) {
            CGRect blackSquareRect=CGRectMake(horizontalPosition, verticalPosition, sizeOfBlackSquare, sizeOfBlackSquare);
            UIView* view=[[UIView alloc]initWithFrame:blackSquareRect];
            view.backgroundColor=[UIColor blackColor];
            
            CGRect unitRect=CGRectInset(blackSquareRect, 10, 10);
            [self.board addSubview:view];
            view.tag=1;
            if (row<3) {
                UIView *unitView=[[UIView alloc]initWithFrame:unitRect];
                unitView.backgroundColor=[UIColor redColor];
                unitView.tag=2;
                [self.board addSubview:unitView];
            } else if(row>4) {
                UIView *unitView=[[UIView alloc]initWithFrame:unitRect];
                unitView.backgroundColor=[UIColor whiteColor];
                unitView.tag=2;
                [self.board addSubview:unitView];
            }
            
            horizontalPosition+=2*sizeOfBlackSquare;
        }
        verticalPosition+=sizeOfBlackSquare;
        horizontalPosition=(row%2)*sizeOfBoard/8;
    }
    
    
    //--------
    //end of Superman
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
   
    
    CGFloat red=(float)arc4random_uniform(101)/100;
    CGFloat green=(float)arc4random_uniform(101)/100;
    CGFloat blue=(float)arc4random_uniform(101)/100;
    
    NSMutableArray* units=[NSMutableArray new];
    
    for (UIView * view in self.board.subviews){
        if (view.tag==1) {
            view.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:0.8];
        } else if (view.tag==2) {
            [units addObject:view];
        }

    }
    for (UIView *unit in units){

        NSInteger index=arc4random_uniform((unsigned int)[units count]);
        UIView* viewForReplace=[units objectAtIndex:index];

        UIColor *color=unit.backgroundColor ;
        
        unit.backgroundColor=[viewForReplace backgroundColor] ;
        viewForReplace.backgroundColor=color;
    }
}



- (NSUInteger)supportedInterfaceOrientations{
    return  UIInterfaceOrientationMaskAll;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
