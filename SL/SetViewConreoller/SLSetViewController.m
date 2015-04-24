//
//  SLSetViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/28.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLSetViewController.h"
#import "SLFeedBackViewController.h"
#import "SLUserCenterWebViewController.h"
#import "BDKNotifyHUD.h"
#import "AppDelegate.h"
#import "SLLoginViewController.h"
@interface SLSetViewController ()<UIWebViewDelegate>
{
    NSDictionary *dataDic;
    NSArray *array;
    UIImageView *imView;
    NSArray *sectionArray1;
    NSArray *sectionArray2;
    NSString *strPhoneNum;//客服电话
    UIWebView *phoneCallWebView;
}

@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;

@end

@implementation SLSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"设置";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"设置" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
titlelabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    // Do any additional setup after loading the view.
    
    sectionArray1 = [[NSArray alloc]initWithObjects:@"消息通知",@"推荐给微信好友",@"关于数联中国",@"清除缓存", nil];
    sectionArray2 = [[NSArray alloc]initWithObjects:@"用户须知",@"意见反馈",@"客户电话", nil];
    
    dataDic = [[NSDictionary alloc]initWithObjectsAndKeys:sectionArray1,@"one",sectionArray2,@"two", nil];
    
    array = [[NSArray alloc]initWithObjects:@"one",@"two", nil];
    
    [self initView];
    
    self.notificationText = @"清除成功";
    self.imageName = @"Checkmark@2x.png";
    
}

-(void)initView
{
    UIView* footView = [self tableFootView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = footView;
    [_baseScrollView addSubview:self.tableView];
    
    
    
}

- (UIView*)tableFootView
{
    UIView* footview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 45)];
    footview.backgroundColor = RGBCOLOR(235, 238, 243);
    footview.userInteractionEnabled = YES;
    UIButton *siginOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth-40, 35)];
    [siginOutBtn setBackgroundImage:[UIImage imageNamed:@"红色按钮"] forState:UIControlStateNormal];
    [siginOutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
    [siginOutBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [siginOutBtn addTarget:self action:@selector(siginOutBtn) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:siginOutBtn];
    return footview;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *string = [array objectAtIndex:section];
    NSArray *row = [dataDic objectForKey:string];
    return row.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifiercell";
    UITableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *rightLable = [UnityLHClass initUILabel:@"" font:15.0 color:[UIColor grayColor] rect:CGRectMake(kScreenWidth-180, 0, 150, 44)];
        rightLable.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:rightLable];
        
        if (indexPath.section == 0) {
            if (indexPath.row == 3) {
                rightLable.text = [ NSString stringWithFormat : @"%.2fM" , [ self filePath]];
                rightLable.textColor = [UIColor blueColor];
            }
        }
        
        if (indexPath.section == 1) {
            if (indexPath.row == 2) {
                rightLable.text = @"400-850-8888";
                strPhoneNum = rightLable.text;
                rightLable.textColor = [UIColor blueColor];
            }
        }

    }
    
    NSString *string = [array objectAtIndex:indexPath.section];
    NSArray *arrayy = [dataDic objectForKey:string];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = [arrayy objectAtIndex:indexPath.row];

    
    
    return cell;
}




-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    return [array objectAtIndex:section];
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 10;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *string = [array objectAtIndex:indexPath.section];
    NSArray *arrayy = [dataDic objectForKey:string];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 6;
            userWebVC.strTitle = [arrayy objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:userWebVC animated:YES];

        }else if (indexPath.row == 1){
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 7;
            userWebVC.strTitle = [arrayy objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:userWebVC animated:YES];

            
        }else if (indexPath.row == 2){
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 8;
            userWebVC.strTitle = [arrayy objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:userWebVC animated:YES];

            
        }else if (indexPath.row == 3){
//            [self clearFile];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要清除缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 10;
            [alert show];
        }
        
    }else{
        if (indexPath.row == 0) {
            NSLog(@"0");
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 9;
            userWebVC.strTitle = [arrayy objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:userWebVC animated:YES];

        }else if (indexPath.row == 1){
            
            SLFeedBackViewController *feedVC = [[SLFeedBackViewController alloc]init];
            [self.navigationController pushViewController:feedVC animated:YES];
            
        }else{
            
            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",strPhoneNum]];
            if ( !phoneCallWebView ) {
                phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];

        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark == 退出按钮
-(void)siginOutBtn
{
    NSLog(@"点击了退出按钮");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要退出登录吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 2;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        if (buttonIndex == 0) {
            
        }else{
            [self clearFile];
        }
    }else if (alertView.tag == 2){
        if (buttonIndex == 0) {
            
        }else{
            
            NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
            [userdefault removeObjectForKey:@"isLogin"];
            [userdefault removeObjectForKey:@"userId"];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            SLLoginViewController* login = [[SLLoginViewController alloc] init];
            UINavigationController *loginnav=[[UINavigationController alloc]initWithRootViewController:login];
            appDelegate.window.rootViewController = loginnav;
            [appDelegate.window setBackgroundColor:[UIColor whiteColor]];
            [appDelegate.window makeKeyAndVisible];
            [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];

        }
    }
}

- (float) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
        
    }
    
    return 0 ;
    
}
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}

- ( float )filePath

{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
    
}

- ( void )clearFile

{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
    
}

- ( void )clearCachSuccess
{
    
    NSLog (@"清理成功");
    [self switchImages];
    [self displayNotification];
    [self.tableView reloadData];
    
}

- (BDKNotifyHUD *)notify {
    if (_notify != nil) return _notify;
    _notify = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:self.imageName] text:self.notificationText];
    _notify.center = CGPointMake(self.view.center.x, self.view.center.y - 20);
    return _notify;
}



- (void)switchImages {
    
    self.notify.image = [UIImage imageNamed:self.imageName];
    self.notify.text = self.notificationText;
}

- (void)displayNotification {
    if (self.notify.isAnimating) return;
    
    [self.view addSubview:self.notify];
    [self.notify presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
        [self.notify removeFromSuperview];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
