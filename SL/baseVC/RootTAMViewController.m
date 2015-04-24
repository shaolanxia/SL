//
//  HomeViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//


#import "RootTAMViewController.h"
#import "UIViewController+JASidePanel.h"
#import "SLHomeViewController.h"
#import "JASidePanelController.h"
///////
#import "AppDelegate.h"
/////////

@interface RootTAMViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    JASidePanelController *_sidePanelController;
}
@end

@implementation RootTAMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sidePanelController = [[JASidePanelController alloc] init];
    _sidePanelController.style = JASidePanelSingleActive;
    _sidePanelController.shouldDelegateAutorotateToVisiblePanel = NO;
    _sidePanelController.allowLeftSwipe = NO;
    _sidePanelController.allowRightSwipe = NO;
    _sidePanelController.bounceOnSidePanelOpen = NO;
    _sidePanelController.bounceOnSidePanelClose = NO;
    _sidePanelController.bounceOnCenterPanelChange = NO;

    _sidePanelController.view.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height);
    
    [self.view addSubview:_sidePanelController.view];
    
    [self initBottomBar];
	// Do any additional setup after loading the view.
}
- (void)initBottomBar
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    BMCustomBottomBarView *bottomBar = [[BMCustomBottomBarView alloc] initWithFrame:CGRectMake(0, kScreenHeight -  49, kScreenWidth, 49)];
    bottomBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"02-dibulan"]];
    bottomBar.btnImageArray = [NSMutableArray arrayWithObjects:@"02-dibu-icon2",@"02-dibu-icon3",@"02-dibu-icon4",@"02-dibu-icon5",@"", nil];
    bottomBar.btnTitleArray = @[@"360金融",@"不差钱",@"我的圈",@"更多",@""];
    bottomBar.btnSImageArray = [NSMutableArray arrayWithObjects:@"02-dibu-icon1",@"02-dibu-icon6",@"02-dibu-icon7",@"02-dibu-icon8",@"",nil];
    bottomBar.delegate = self;
    appDelegate.bottomBarView = bottomBar;
    
    [bottomBar initButtonAlloc];
//    [self.view addSubview:bottomBar];
    if ([appDelegate.bottomBarView.btnArray count] != 0)
    {
        [appDelegate.bottomBarView selectButtonClick:[appDelegate.bottomBarView.btnArray objectAtIndex:0]];
    }
}



//选中底部bar
- (void)selectBottomButtonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            if (nil == naviFirst)
            {
                SLHomeViewController* viewVc = [[SLHomeViewController alloc] init];
                naviFirst = [[UINavigationController alloc] initWithRootViewController:viewVc];
            }
            _sidePanelController.centerPanel = naviFirst;
        }
            break;

        default:{
            if (nil == naviFive)
            {
                SLHomeViewController *homePageVc = [[SLHomeViewController alloc] init];
                naviFive = [[UINavigationController alloc] initWithRootViewController:homePageVc];
            }
            _sidePanelController.centerPanel = naviFive;
        }
            break;
    }

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
