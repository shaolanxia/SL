//
//  SLHomeViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLHomeViewController.h"
#import "SLScanViewController.h"
#import "SLUserCenterViewController.h"
#import "SLSearchViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "SLSpaceCollectionViewCell.h"
#import "SLScreeningViewController.h"
#import "SLCategoryGroup.h"
#import "SLCategory.h"

@interface SLHomeViewController ()<UISearchBarDelegate>
{
    UIActivityIndicatorView *activityIndicator;
    UISearchBar *mySearchBar;
    UIView *backView;
    UICollectionView * colectionView;
    NSDictionary *dataDic;
    NSMutableDictionary *colectionDic;
    NSArray *tableArray;
    NSMutableArray *titleArray;
    NSMutableArray *colectionArray;
    NSMutableArray *imageArray;
    NSInteger strTag;
}
@end

static int a = 1;
NSString * const MJHomeTableViewIdentifier = @"HomeCell";

@implementation SLHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleArray = [[NSMutableArray alloc]initWithCapacity:10];
    imageArray = [[NSMutableArray alloc]initWithCapacity:10];
    colectionArray = [[NSMutableArray alloc]initWithCapacity:10];
    [self initView];
    strTag = 1;
//解决UITableView分割线距左边有距离的办法
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)initView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
    titleView.backgroundColor = [UIColor clearColor];
//    [UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0];
    self.navigationItem.titleView = titleView;

    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0,8,30,30);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"列表.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.text = @"1";
    [titleView  addSubview:leftButton];
    

    UIImage *searchImg = [UIImage imageNamed:@"搜索框.png"];
    UIImageView *searchImgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 7, kScreenWidth-100, searchImg.size.height/2)];
    searchImgView.image = searchImg;
    searchImgView.userInteractionEnabled = YES;
    [titleView addSubview:searchImgView];


    //
    UIImage *seaImg = [UIImage imageNamed:@"搜索.png"];
    
    UIImageView *seachImgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 7, seaImg.size.width/2, seaImg.size.height/2)];
    seachImgView.image = seaImg;
    seachImgView.userInteractionEnabled = YES;
    [titleView addSubview:seachImgView];
    
    UIButton *seaBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 7, kScreenWidth-130, searchImg.size.height/2)];
//    seaBtn.backgroundColor = [UIColor redColor];
//    [seaBtn setBackgroundImage:seaImg forState:UIControlStateNormal];
    [seaBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:seaBtn];

    UIImage *smImg = [UIImage imageNamed:@"扫码.png"];
    UIButton *smBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-90, 7, smImg.size.width/2, smImg.size.height/2)];
    [smBtn setBackgroundImage:smImg forState:UIControlStateNormal];
    [smBtn addTarget:self action:@selector(saomiao) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:smBtn];
    
    UIImage *userImg = [UIImage imageNamed:@"头像.png"];
    UIButton *userBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-50, 7, smImg.size.width/2, smImg.size.height/2)];
    [userBtn setBackgroundImage:userImg forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(userBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:userBtn];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    self.webView.delegate = self;
    [self.webView setOpaque:NO];
    [self.webView setScalesPageToFit:YES];  //yes:根据webview自适应，NO：根据内容自适应
    self.webView.delegate = self;
    [_baseScrollView addSubview:self.webView];
    _baseScrollView.scrollEnabled = NO;
    
    NSURL *strUrl = [NSURL URLWithString:@"http://www.duc.cn/ios/"];
    NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
    [self.webView loadRequest:request];
    
    
    //加载旋转的风火轮
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:
                         UIActivityIndicatorViewStyleGray];
    activityIndicator.center = self.view.center;
    [self.view addSubview:activityIndicator];
    
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor = RGBCOLOR(235, 238, 243);
    backView.hidden = YES;
    [_baseScrollView addSubview:backView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, 0.5, kScreenHeight)];
    lineView.backgroundColor = [UIColor grayColor];
    [backView addSubview:lineView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, kScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [backView addSubview:self.tableView];
    
    UICollectionViewWaterfallLayout * layout = [[UICollectionViewWaterfallLayout alloc] init];
    layout.delegate  = self;
    layout.columnCount = 3;
    layout.itemWidth = 60;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    colectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(80.6, 0, kScreenWidth-80, kScreenHeight-64) collectionViewLayout:layout];
    
    colectionView.delegate =  self;
    colectionView.dataSource = self;
    colectionView.alwaysBounceVertical = YES;
    colectionView.hidden = YES;
    colectionView.backgroundColor = [UIColor colorWithRed:(235)/255.0f green:(238)/255.0f blue:(243)/255.0f alpha:1];
    [colectionView registerClass:[SLSpaceCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [backView addSubview:colectionView];
    
//    [self addHeader];
//    [self addFooter];
    
}

//开始加载的时候执行该方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
}
//加载完成的时候执行该方法
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    [activityIndicator stopAnimating];
    
}



#pragma mark == 二维码扫描
-(void)saomiao
{

    
    CustomViewController*smVC=[[CustomViewController alloc] initWithBlock:^(NSString *result, BOOL isSucceed) {
        
        if (isSucceed) {
            //扫描成功后要操作的
            NSLog(@"result~~~%@",result);
        }else{
            //扫描失败后要操作的
            NSLog(@"error~~~%@",result);
        }
        
    }];
    smVC.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:smVC];
    [self presentViewController:navc animated:YES completion:nil];
}

#pragma mark == 搜索按钮
-(void)search
{
    NSLog(@"点击了搜索按钮");
    
//    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
//    backItem.title=@"";
//    backItem.tintColor=[UIColor colorWithRed:129/255.0 green:129/255.0  blue:129/255.0 alpha:1.0];
//    self.navigationItem.backBarButtonItem = backItem;
    
    SLSearchViewController *searVC = [[SLSearchViewController alloc]init];
    [self.navigationController pushViewController:searVC animated:YES];
}

#pragma mark == 用户头像按钮
-(void)userBtn
{
//    PersonCenterViewController *person=[[PersonCenterViewController alloc]init];
//    [self.navigationController pushViewController:person animated:YES];
//    SLLoginViewController *loginVC = [[SLLoginViewController alloc]init];
//    [self.navigationController pushViewController:loginVC animated:YES];
    
    SLUserCenterViewController *userVC = [[SLUserCenterViewController alloc]init];
    [self.navigationController pushViewController:userVC animated:YES];
    
    
}

#pragma mark == 最左边按钮
-(void)leftAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"1"]) {
        
        [sender setBackgroundImage:[UIImage imageNamed:@"列表点击.png"] forState:UIControlStateNormal];
        sender.titleLabel.text = @"0";
        colectionView.hidden = NO;
        [self requestData];
        self.webView.hidden = YES;
        backView.hidden = NO;
        [activityIndicator stopAnimating];
        
        
    }else{
        
        [sender setBackgroundImage:[UIImage imageNamed:@"列表.png"] forState:UIControlStateNormal];
        sender.titleLabel.text = @"1";
        colectionView.hidden = YES;
        backView.hidden = YES;
        self.webView.hidden = NO;
        NSURL *strUrl = [NSURL URLWithString:@"http://www.duc.cn/ios/"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
    }

}

-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:SLSceen_DATA parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----%@",responseObject);
        
        if ([[responseObject objectForKey:@"success"] boolValue] == 1) {
            
            dataDic = responseObject;
            tableArray = [responseObject objectForKey:@"data"];
            titleArray = [[tableArray objectAtIndex:0] objectForKey:@"list"];
            
            [self.tableView reloadData];
            [colectionView reloadData];
            
        }else{
            [self showAlertWithTitle:@"提示" :@"获取数据失败,请重试!" :@"OK" :nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error----%@",error);
    }];
    
}


//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark ==  UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLSpaceCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[SLSpaceCollectionViewCell alloc]init];
    }
    
//    colectionArray = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"listid"];
    NSLog(@"%@",titleArray);
    
    imageArray = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"pic"];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[[titleArray objectAtIndex:indexPath.row] objectForKey:@"pic"]] placeholderImage:nil];
    cell.titleLable.text = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    SLScreeningViewController *searchVC = [[SLScreeningViewController alloc]init];
    searchVC.strUrl = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"link"];
    searchVC.strTag = strTag;
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 30);
}

//每个cell高度指定代理
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}



//下拉加载
- (void)addFooter
{
    __unsafe_unretained SLHomeViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = colectionView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 增加5条假数据
        //[self.tableView reloadData];
        
        // 这里的refreshView其实就是footer
        [vc performSelector:@selector(loadMore:) withObject:refreshView afterDelay:2.0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    _footer = footer;
}


//上拉刷新
- (void)addHeader
{
    __unsafe_unretained SLHomeViewController *vc = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = colectionView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        [vc performSelector:@selector(doneWithVie:) withObject:refreshView afterDelay:2.0];
        colectionView.hidden = NO;
        
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        colectionView.hidden = NO;
        
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                [UnityLHClass showAlertView:@"网络好像出了点问题，请重试！"];
                break;
        }
    };
    //    [header beginRefreshing];
    _header = header;
}

-(void)loadMore:(MJRefreshBaseView *)refreshView
{
    a++;
    NSString *strPage = [NSString stringWithFormat:@"%d",a];
    
    [refreshView endRefreshing];
}

- (void)doneWithVie:(MJRefreshBaseView *)refreshView
{
    
    
    
    [refreshView endRefreshing];
    
}


#pragma mark == UITableView

//解决UITableView分割线距左边有距离的办法
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[tableArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:11.0];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",dataDic);
    NSLog(@"tableArray == %@",tableArray);
//    [titleArray removeAllObjects];
    strTag = indexPath.row + 1;
    titleArray = [[tableArray objectAtIndex:indexPath.row] objectForKey:@"list"];
    [colectionView reloadData];
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
