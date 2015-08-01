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
@property (strong,nonatomic) UIView *draggingView;
@property (assign,nonatomic) CGPoint touchOffset;
@property (assign,nonatomic) CGPoint previousPoint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    //--------
    //end of Superman
}
- (void) changeAvailabilityOfView:(UIView*) view toActiveState:(BOOL) state {
    view.hidden=!state;
    view.userInteractionEnabled=state;
}
- (UIView *) findEmptyCheckForView:(UIView*) dragView onPoint:(CGPoint) touchPoint withEvent:(UIEvent*) event{
    [self changeAvailabilityOfView:dragView toActiveState:NO];
    
    CGFloat blackCheckSize=CGRectGetWidth(self.blackCheck.bounds);
    NSMutableArray *arrayOfEmptyBlackCheckers=[[NSMutableArray alloc]init];
    NSInteger i=1;
    UIView *viewOfTouch=[self.view hitTest:touchPoint withEvent:event];
    if ([viewOfTouch isEqual:self.view]|| viewOfTouch.tag==2) {
        UIView *previousView=[self.view hitTest:self.previousPoint withEvent:event];
        [self changeAvailabilityOfView:dragView toActiveState:YES];
        return previousView;
    } else if (viewOfTouch.tag==1 ){
        [self changeAvailabilityOfView:dragView toActiveState:YES];
        return viewOfTouch;
    } else {
        [self changeAvailabilityOfView:dragView toActiveState:YES];
        while (1) {
            CGFloat x;
            CGFloat y;
            for (NSInteger j=-(i-1); j<i; j=j+2) {
                //rotate must be near (0,0) point. Then, translate points by adding delta to them.
                x=j*blackCheckSize;
                y=i*blackCheckSize;

                for (NSInteger k=0; k<4; k++) {
                    
                    CGFloat xAfterRotation=x*cosf(k*M_PI_2)-y*sinf(k*M_PI_2);//rotate on 0,90,180,270 degrees.
                    CGFloat yAfterRotation=x*sinf(k*M_PI_2)+y*cosf(k*M_PI_2);
                    NSLog(@"after rotation near 0, %@",NSStringFromCGPoint(CGPointMake(xAfterRotation, yAfterRotation)));
                    CGPoint pointAfterRotation=CGPointMake(xAfterRotation+touchPoint.x, yAfterRotation+touchPoint.y);
                    UIView *view = [self.view hitTest:pointAfterRotation withEvent:event];
                    UIView *correctionView=[self.view hitTest:[self.view convertPoint:view.center fromView:self.board] withEvent:event];
                    if (correctionView.tag==1) {
                        [arrayOfEmptyBlackCheckers addObject:correctionView];
                    }
                }
            }
            NSLog(@"array of empty %@",arrayOfEmptyBlackCheckers);
            if (![arrayOfEmptyBlackCheckers count]==0) {
                [arrayOfEmptyBlackCheckers sortUsingComparator:^NSComparisonResult(UIView * obj1, UIView * obj2) {
                    CGPoint pointInBoardCoord=[self.board convertPoint:touchPoint fromView:self.view];
                    CGFloat deltaX1=ABS(obj1.center.x-pointInBoardCoord.x);
                    CGFloat deltaY1=ABS(obj1.center.y-pointInBoardCoord.y);
                    CGFloat hypotenuse1=sqrtf(deltaX1*deltaX1 + deltaY1*deltaY1);
                    
                    CGFloat deltaX2=ABS(obj2.center.x-pointInBoardCoord.x);
                    CGFloat deltaY2=ABS(obj2.center.y-pointInBoardCoord.y);
                    CGFloat hypotenuse2=sqrtf(deltaX2*deltaX2 + deltaY2*deltaY2);
                    
                    if (hypotenuse1>hypotenuse2) {
                        return NSOrderedAscending;
                    } else if (hypotenuse1 <hypotenuse2) {
                        return NSOrderedDescending;
                    } else {
                        return NSOrderedSame;
                    }
                }];
                return [arrayOfEmptyBlackCheckers lastObject];
                break;
                
            }
            i++;
        }
    }
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.draggingView=nil;
    UITouch * touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.view];
    
    UIView *moveView=[self.view hitTest:point withEvent:event];
    if (moveView.tag==2) {
        self.draggingView=moveView;
        self.previousPoint=[self.view convertPoint:moveView.center fromView:self.board];

        [self.board bringSubviewToFront:self.draggingView];
        
        CGRect rectInSelfViewCoordinates=[self.draggingView convertRect:self.draggingView.bounds toView:self.view];
        CGFloat deltaX=CGRectGetMidX(rectInSelfViewCoordinates)-point.x;
        CGFloat deltaY=CGRectGetMidY(rectInSelfViewCoordinates)-point.y;
        self.touchOffset=CGPointMake(deltaX, deltaY);
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.draggingView) {
        //for drag on touch point, not for center of UIView
        UITouch * touch=[touches anyObject];
        CGPoint point=[touch locationInView:self.view];
        
        CGFloat correctionX=point.x+self.touchOffset.x;
        CGFloat correctionY=point.y+self.touchOffset.y;
        CGPoint correctionPoint=CGPointMake(correctionX, correctionY);
        CGPoint correctionTranslatedPoint=[self.board convertPoint:correctionPoint fromView:self.view];
        self.draggingView.center=correctionTranslatedPoint;
        
        //NSLog(@"touch %f %f",point.x, point.y);
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.draggingView) {
        UITouch *touch=[[UITouch alloc]init];
        touch = [touches anyObject];
        CGPoint touchPoint=[touch locationInView:self.view];
        UIView* nearestEmptyCheck =[self findEmptyCheckForView:self.draggingView onPoint:touchPoint withEvent:event];
        
        self.draggingView.center=nearestEmptyCheck.center;
    }
    self.draggingView=nil;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.draggingView.center=[self.view convertPoint:self.previousPoint toView:self.board];
    self.draggingView=nil;
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
   
    
    CGFloat red=(float)arc4random_uniform(101)/100;
    CGFloat green=(float)arc4random_uniform(101)/100;
    CGFloat blue=(float)arc4random_uniform(101)/100;
    
    NSMutableArray* units=[NSMutableArray new];
    
    for (UIView * view in self.collectionViews){
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
