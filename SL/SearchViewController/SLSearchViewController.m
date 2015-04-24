//
//  SLSearchViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLSearchViewController.h"
#import "UIViewExt.h"

@interface SLSearchViewController ()<UISearchBarDelegate,UITextFieldDelegate>
{
    UISearchBar *mySearchBar;
    UITextField *searchField;
}
@end

@implementation SLSearchViewController

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
    [self addNavigationLeftButton];
    [self initView];
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

-(void)initView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(-20, 0, kScreenWidth, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
  
    UIImage *searchImg = [UIImage imageNamed:@"搜索框.png"];
    UIImageView *searchImgView = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 7, kScreenWidth-120, searchImg.size.height/2)];
    searchImgView.image = searchImg;
    searchImgView.userInteractionEnabled = YES;
    [titleView addSubview:searchImgView];
    
    searchField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-120, searchImg.size.height/2)];
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.backgroundColor = [UIColor clearColor];
    searchField.returnKeyType = UIReturnKeySearch;
    [searchImgView addSubview:searchField];
    
    [searchField becomeFirstResponder];
    
//    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80, 7, 80, 20)];
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [titleView addSubview:cancelBtn];
    [self addNavigationRightButtonForStr:@"搜索"];
//
//    //
//    UIImage *seaImg = [UIImage imageNamed:@"搜索.png"];
//    UIButton *seaBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 7, seaImg.size.width/2, seaImg.size.height/2)];
//    [seaBtn setBackgroundImage:seaImg forState:UIControlStateNormal];
//    [seaBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
//    [titleView addSubview:seaBtn];
    
//    UIImage *smImg = [UIImage imageNamed:@"筛选.png"];
//    UIButton *smBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-105, 7, smImg.size.width/2, smImg.size.height/2)];
//    [smBtn setBackgroundImage:smImg forState:UIControlStateNormal];
//    [smBtn addTarget:self action:@selector(shaixuan) forControlEvents:UIControlEventTouchUpInside];
//    [titleView addSubview:smBtn];
    UILabel *hotLabel=[UnityLHClass initUILabel:@"热门搜索" font:15 color:[UIColor blackColor] rect:CGRectMake(50, 10, 180, 20)];
    [_baseScrollView addSubview:hotLabel];
    
    //热门搜索数组
    NSMutableArray *hotNameArr = [[NSMutableArray alloc] initWithObjects:
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               @"关键字",
                               nil];
    
    //
    float hotButtonWidth = 0.0;
    float hotButtonTop = 40.0;
    
    for (int i = 0; i< hotNameArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.frame = CGRectMake(10 +hotButtonWidth, hotButtonTop, 100, 30);
        CGRect frame = [hotNameArr[i] boundingRectWithSize:CGSizeMake(1000, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]} context:nil];
        
        button.width = frame.size.width +30;
        hotButtonWidth += button.width +10;
        
        if (hotButtonWidth > self.view.width - 7) {
            button.left = 10;
            button.top = hotButtonTop +25 +15;
            hotButtonTop = button.top;
            hotButtonWidth = button.width +10;
        }
        
        button.titleEdgeInsets = (UIEdgeInsets){0,0,0,0};
        NSAttributedString *titltString = [[NSAttributedString alloc] initWithString:hotNameArr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]}];
        [button setAttributedTitle:titltString forState:UIControlStateNormal];
        
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(hotButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_baseScrollView addSubview:button];
        
        NSLog(@"%.2f",hotButtonTop);
        
    }
    
    UILabel *historyLabel=[UnityLHClass initUILabel:@"历史搜索" font:15 color:[UIColor blackColor] rect:CGRectMake(50, 160, 180, 20)];
    [_baseScrollView addSubview:historyLabel];
    
    //热门搜索数组
    NSMutableArray *historyNameArr = [[NSMutableArray alloc] initWithObjects:
                                  @"关键字",
                                  @"关键字",
                                  @"关键字",
                                  @"关键字",
                                  @"关键字",
                                  @"关键字",
                                  @"关键字",
                                  @"关键字",
                                  nil];
    
        for (int i=0; i<historyNameArr.count; i++) {
        int xJ=10;
        int yJ=10;
        int row=i/4;
        int col=i%4;
        int x=15+(xJ+50)*col;
        int y=35+(yJ+25)*row;
        UIButton *historyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        historyBtn.tag=400+i;
        historyBtn.frame=CGRectMake(x,160+ y, 50, 25);
        historyBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [historyBtn setTitle:[historyNameArr objectAtIndex:i] forState:UIControlStateNormal];
        [historyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        [historyBtn addTarget:self action:@selector(historyButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_baseScrollView addSubview:historyBtn];
        historyBtn.backgroundColor = [UIColor redColor];
    }

    
}

-(void)rightAction
{
    [searchField resignFirstResponder];
}
//
-(void)hotButtonAciton:(UIButton *)btn
{
    [searchField resignFirstResponder];
}

//
-(void)historyButtonAciton:(UIButton *)btn
{
    [searchField resignFirstResponder];
}
#pragma mark == 搜索按钮
-(void)search
{
    NSLog(@"点击了搜索按钮");
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [mySearchBar resignFirstResponder];
}
#pragma mark == 搜索历史
- (void)buttonAciton:(UIButton *)button
{
    NSLog(@"%ld",button.tag);
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     [searchBar resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
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
