//
//  AppDelegate.h
//  ShuLianNet
//
//  Created by SD0025A on 15/4/3.
//  Copyright (c) 2015年 邵兰霞. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMCustomBottomBarView.h"
#import "IndexViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,firstIn>
{
    BOOL first;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BMCustomBottomBarView* bottomBarView;


@end

