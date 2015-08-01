//
//  ViewController.h
//  19. UIViewGeomerty
//
//  Created by Admin on 27.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *collectionViews;
@property (weak, nonatomic, readonly) IBOutlet UIView *blackCheck;


@end

