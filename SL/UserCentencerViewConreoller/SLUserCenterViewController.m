//
//  SLUserCenterViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/28.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLUserCenterViewController.h"
#import "SLSetViewController.h"
#import "SLInformationViewController.h"
#import "SLUserCenterWebViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "AppDelegate.h"
#import "SLLoginViewController.h"
#import "UIImageView+LBBlurredImage.h"

@interface SLUserCenterViewController ()
{
    NSDictionary *dataDic;
    NSArray *array;
    UIImageView *imView;
    NSArray *sectionArray1;
    NSArray *sectionArray2;
    NSArray *sectionArray3;
    NSArray *imageSectiontrArray1;//tableview 左边小图标
    NSArray *titleSectionArray1;//tableview cell上的文字
    
    NSArray *imageSectiontrArray2;//tableview 左边小图标
    NSArray *imageSectiontrArray3;//tableview 左边小图标
    NSArray *titleSectionArray2;//tableview cell上的文字
    NSArray *titleSectionArray3;//tableview cell上的文字

    NSString *strID;
    UIImageView *backImgView;
    UIImage *getImg; // 传过来的图片
    NSInteger imgTag; // 传过来的图片tag
    NSArray *typeNameList;
}

@property(nonatomic, strong)  UIImageView *backgroundPhotoWithImageEffects;

@end

@implementation SLUserCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = @"我的";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"我的" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
        titlelabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    strID = [user objectForKey:@"userId"];
    [self requestData];
}



-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:SLUser_DATA parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----%@",responseObject);
        if ([[responseObject objectForKey:@"success"]boolValue] == 1) {
            self.dataDic = [responseObject objectForKey:@"data"];
            typeNameList=[[responseObject objectForKey:@"data"] objectForKey:@"typeNameList"];
            UIView* headerView = [self tableHearView];
            self.tableView.tableHeaderView = headerView;
            [self.tableView reloadData];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆超时,请重新登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 3;
            [alert show];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error----%@",error);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    // Do any additional setup after loading the view.
    
    
    
    sectionArray1 = [[NSArray alloc]initWithObjects:@"我的消息",@"我的灵感集",@"我的关注",@"我的粉丝", nil];
    sectionArray2 = [[NSArray alloc]initWithObjects:@"我的授权",@"我的设置", nil];
    sectionArray3 = [[NSArray alloc]initWithObjects:@"我的应用",@"管理中心", nil];

    dataDic = [[NSDictionary alloc]initWithObjectsAndKeys:sectionArray1,@"one",sectionArray2,@"two",sectionArray3,@"three", nil];
    
    array = [[NSArray alloc]initWithObjects:@"one",@"two",@"three", nil];
    
    imageSectiontrArray1 = @[@"个人设置-消息",@"个人设置-灵感集",@"个人设置-关注",@"个人设置-粉丝"];
    
    titleSectionArray1 = @[@"我的消息",@"我的灵感集",@"我的关注",@"我的粉丝"];
    
    imageSectiontrArray2 = @[@"个人设置-授权",@"个人设置-设置"];
    imageSectiontrArray3 = @[@"个人设置-应用",@"个人设置-管理"];
    
    titleSectionArray2 = @[@"我的授权",@"设置"];
    titleSectionArray3 = @[@"我的应用",@"管理中心"];
    
    [self initView];
}

-(void)initView
{
    UIView* headerView = [self tableHearView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
}



- (UIView*)tableHearView
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
//    UIImage *backImg = [UIImage imageNamed:@""];
    
    backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    backImgView.userInteractionEnabled = YES;
    
    getImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.dataDic objectForKey:@"avatarPic"]]]];
    
    if (imgTag == 10) {
        
        [backImgView setImageToBlur:getImg
                            blurRadius:kLBBlurredImageDefaultBlurRadius
                       completionBlock:^(NSError *error){
                           NSLog(@"The blurred image has been setted");
                       }];
        
    }else{

        [backImgView setImageToBlur:getImg
                         blurRadius:kLBBlurredImageDefaultBlurRadius
                    completionBlock:^(NSError *error){
                        NSLog(@"The blurred image has been setted");
                    }];

    }
    
    [view addSubview:backImgView];
    
    UIImageView *backPhotoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    backPhotoImgView.frame = CGRectMake(9.5,9.5,71,71);
    backPhotoImgView.layer.masksToBounds = YES;
    backPhotoImgView.layer.cornerRadius = 35.5;
    backPhotoImgView.backgroundColor = [UIColor whiteColor];
    [view addSubview:backPhotoImgView];
    
    UIImageView *userPhotoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moren.png"]];
    userPhotoImgView.frame = CGRectMake(10,10,70,70);
    userPhotoImgView.layer.masksToBounds = YES;
    userPhotoImgView.layer.cornerRadius = 35;
    [view addSubview:userPhotoImgView];
    
    
    
    
    
    if ([[self.dataDic objectForKey:@"avatarPic"] description] == nil) {
        userPhotoImgView.image = [UIImage imageNamed:@"moren.png"];
    }else{
       [userPhotoImgView sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"avatarPic"]] placeholderImage:[UIImage imageNamed:@"moren.png"]]; 
    }
    
    UILabel *userNameLable = [UnityLHClass initUILabel:@"" font:18.0 color:[UIColor blackColor] rect:CGRectMake(90,20, kScreenWidth-90, 25)];
    
    if ([[self.dataDic objectForKey:@"realName"] description] == nil) {
        userNameLable.text = @"";
    }else{
        userNameLable.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"realName"]];
    }
    
    [view addSubview:userNameLable];
    
    
    NSString *str = [[typeNameList objectAtIndex:0] substringToIndex:1];
    UILabel *byWorkLable = [UnityLHClass initUILabel:str font:12.0 color:[UIColor whiteColor] rect:CGRectMake(90, 50, 20, 20)];
    byWorkLable.textAlignment = 1;
    byWorkLable.backgroundColor = [UIColor redColor];
    byWorkLable.layer.masksToBounds = YES;
    byWorkLable.layer.cornerRadius = 10;
    [view addSubview:byWorkLable];
    
    

    UIImage *rightImg = [UIImage imageNamed:@"右箭头大.png"];
    UIImageView *rightImgView = [[UIImageView alloc] initWithImage:rightImg];
    [rightImgView setFrame:CGRectMake(kScreenWidth-40, 33, rightImg.size.width/2, rightImg.size.height/2)];
    [view addSubview:rightImgView];

    UIButton *userBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    [userBtn addTarget:self action:@selector(userBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:userBtn];
    
    return view;
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
        
        if (indexPath.section == 0) {
            
            UIImage *image = [UIImage imageNamed:[imageSectiontrArray1 objectAtIndex:indexPath.row]];
            UIImageView *leftView = [[UIImageView alloc] initWithImage:image];
            leftView.frame = CGRectMake(10,44/2-image.size.height/4, image.size.width/2, image.size.height/2);
            [cell addSubview:leftView];
            
            UILabel *titleLabel = [UnityLHClass initUILabel:[titleSectionArray1 objectAtIndex:indexPath.row] font:15.0 color:[UIColor blackColor] rect:CGRectMake(45, 0, 100, 44)];
            [cell addSubview:titleLabel];
        }else if (indexPath.section == 1){
            
            UIImage *image = [UIImage imageNamed:[imageSectiontrArray3 objectAtIndex:indexPath.row]];
            UIImageView *leftView = [[UIImageView alloc] initWithImage:image];
            leftView.frame = CGRectMake(10,44/2-image.size.height/4, image.size.width/2, image.size.height/2);
            [cell addSubview:leftView];
            
            UILabel *titleLabel = [UnityLHClass initUILabel:[titleSectionArray3 objectAtIndex:indexPath.row] font:15.0 color:[UIColor blackColor] rect:CGRectMake(45, 0, 100, 44)];
            [cell addSubview:titleLabel];
            
        }else{
            UIImage *image = [UIImage imageNamed:[imageSectiontrArray2 objectAtIndex:indexPath.row]];
            UIImageView *leftView = [[UIImageView alloc] initWithImage:image];
            leftView.frame = CGRectMake(10,44/2-image.size.height/4, image.size.width/2, image.size.height/2);
            [cell addSubview:leftView];
            
            UILabel *titleLabel = [UnityLHClass initUILabel:[titleSectionArray2 objectAtIndex:indexPath.row] font:15.0 color:[UIColor blackColor] rect:CGRectMake(45, 0, 100, 44)];
            [cell addSubview:titleLabel];
        }
        
       
    }
    
    
    return cell;
}




-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    return [array objectAtIndex:section];
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 1;
            userWebVC.strTitle = [titleSectionArray1 objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:userWebVC animated:YES];
        }else if (indexPath.row == 1){
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 2;
            userWebVC.strTitle = [titleSectionArray1 objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:userWebVC animated:YES];
        }else if (indexPath.row == 2){
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 3;
            userWebVC.strTitle = [titleSectionArray1 objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:userWebVC animated:YES];
        }else if (indexPath.row == 3){
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 4;
            userWebVC.strTitle = [titleSectionArray1 objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:userWebVC animated:YES];
        }
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 10;
            userWebVC.strTitle = [titleSectionArray3 objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:userWebVC animated:YES];
            
        }else{
            
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 11;
            userWebVC.strTitle = [titleSectionArray3 objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:userWebVC animated:YES];
            
        }
        
    }else{
        if (indexPath.row == 0) {
            NSLog(@"0");
            
            SLUserCenterWebViewController *userWebVC = [[SLUserCenterWebViewController alloc]init];
            userWebVC.strTag = 5;
            userWebVC.strTitle = [titleSectionArray2 objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:userWebVC animated:YES];
        }else {
            NSLog(@"1");
            SLSetViewController *setVC = [[SLSetViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark == userBtn
-(void)userBtn
{
    NSLog(@"dian");
    SLInformationViewController *infoVC = [[SLInformationViewController alloc]init];
    infoVC.userData = self.dataDic;
    infoVC.delegate = self;
    [self.navigationController pushViewController:infoVC animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1:
        {
            if (buttonIndex == 0) {
                
            }
        }
            break;
            
        case 2:
        {
            if (buttonIndex == 0) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
            break;
        case 3:
        {
            if (buttonIndex == 0) {
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                SLLoginViewController* login = [[SLLoginViewController alloc] init];
                UINavigationController *loginnav=[[UINavigationController alloc]initWithRootViewController:login];
                appDelegate.window.rootViewController = loginnav;
                [appDelegate.window setBackgroundColor:[UIColor whiteColor]];
                [appDelegate.window makeKeyAndVisible];
                [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
            }
        }
            break;
            
        default:
        {
            if (buttonIndex == 0) {
                
            }
        }
            break;
    }
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
