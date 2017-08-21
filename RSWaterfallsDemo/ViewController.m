//
//  ViewController.m
//  RSWaterfallsDemo
//
//  Created by WhatsXie on 2017/8/17.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"

#import "RSWaterfallsflowLayout.h"

#import "LayoutCellCollectionViewCell.h"
#import "LayoutModel.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,RSWaterfallsflowLayoutDelegate>

/** 所有的数据 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController

static NSString * const DataId = @"data";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 设置瀑布流布局
    [self setupWaterfallsflowLayout];
    // 刷新数据
    [self setupRefresh];
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

/** 刷新数据 */
- (void)setupRefresh {
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.footer.hidden = YES;
}
/** 下拉刷新 */
- (void)loadNewData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *datas = [LayoutModel objectArrayWithFilename:@"layout.plist"];
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:datas];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.header endRefreshing];
    });
}
/** 上拉加载更多数据 */
- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *datas = [LayoutModel objectArrayWithFilename:@"layout.plist"];
        [self.dataArr addObjectsFromArray:datas];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.footer endRefreshing];
    });
}

/** 布局 */
- (void)setupWaterfallsflowLayout {
    // 创建布局
    RSWaterfallsflowLayout *layout = [[RSWaterfallsflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 注册cell
    [collectionView registerClass:[LayoutCellCollectionViewCell class] forCellWithReuseIdentifier:DataId];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.collectionView.footer.hidden = self.dataArr.count == 0;
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LayoutCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DataId forIndexPath:indexPath];
    cell.layoutModel = self.dataArr[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellitem 点击事件");
}

//
#pragma mark - <DJWaterfallsflowLayoutDelegate>
- (CGFloat)waterflowLayout:(RSWaterfallsflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    LayoutModel *layoutModel = self.dataArr[index];
    return itemWidth * layoutModel.height / layoutModel.width;
}

///** 返回瀑布流列数 */ //（可选自定义）
//- (CGFloat)columnCountInWaterflowLayout:(DJWaterfallsflowLayout *)waterflowLayout
//{
//    return 3;
//}
//
///** 返回竖直间距 */
//- (CGFloat)columnMarginInWaterflowLayout:(DJWaterfallsflowLayout *)waterflowLayout
//{
//    return 10;
//}
//
///** 返回水平间距 */
//- (CGFloat)rowMarginInWaterflowLayout:(DJWaterfallsflowLayout *)waterflowLayout
//{
//    return 10;
//}
//
///** 返回边缘间距 */
//- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(DJWaterfallsflowLayout *)waterflowLayout
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}


- (void)backEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
