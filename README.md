# RSWaterfallsDemo
OC 版的瀑布流布局，基于 CollectionView，封装良好

![](https://img.shields.io/badge/platform-iOS-red.svg) 
![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/download-791K-brightgreen.svg)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

在一些特殊的展示中，如：高度不定的图片资源等，瀑布流的布局很常见，大多数情况为了性能的优化，是在接口中读取宽高数据进行布局。
| 名称 |1.列表页 |2.下拉过程 |3.展示瀑布流 |
| ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-21/54867559.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-21/98264702.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-21/21579383.jpg) |
| 描述 | 通过 storyboard 搭建基本框架 | MJ的下拉刷新集成 | 瀑布流界面展示 |


## Advantage 框架的优势
* 1.文件少，封装性好
* 2.使用常用的第三方库：Masonry、SDWebImage、MJExtension 和 MJRefresh
* 3.项目 Demo 基于 MVC 搭建
* 4.具备较高自定义性

## Requirements 要求
* iOS 7+
* Xcode 8+


## Usage 使用方法
### 第一步 引入头文件
```
#import "RSWaterfallsflowLayout.h"
```
### 第二步 简单调用
```
// 创建布局
RSWaterfallsflowLayout *layout = [[RSWaterfallsflowLayout alloc] init];
layout.delegate = self;
```
### 第三步 实现代理
```
#pragma mark - <DJWaterfallsflowLayoutDelegate>
- (CGFloat)waterflowLayout:(RSWaterfallsflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    LayoutModel *layoutModel = self.dataArr[index];
    return itemWidth * layoutModel.height / layoutModel.width;
}
```

使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!


## License 许可证
RSWaterfallsDemo 使用 MIT 许可证，详情见 LICENSE 文件。


## Contact 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io
