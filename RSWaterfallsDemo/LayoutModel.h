//
//  LayoutModel.h
//  RSWaterfallsDemo
//
//  Created by WhatsXie on 2017/8/21.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LayoutModel : NSObject

/** 图片高度 */
@property(nonatomic,assign) CGFloat height;
/** 图片链接 */
@property(nonatomic,copy) NSString *imgurl;
/** 图片价格 */
@property(nonatomic,copy) NSString *price;
/** 图片宽度 */
@property(nonatomic,assign) CGFloat width;

@end
