//
//  SLHomeViewController.h
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SXABaseViewController.h"
#import "CustomViewController.h"
#import "UICollectionViewWaterfallLayout.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"
#import "MJRefresh.h"
@interface SLHomeViewController : SXABaseViewController<UIWebViewDelegate,CustomViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDelegateWaterfallLayout,MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@property(strong,nonatomic)UIWebView *webView;
@property(strong,nonatomic)UITableView *tableView;

@end
