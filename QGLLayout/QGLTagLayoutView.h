//
//  QGLTagLayoutView.h
//  QGLLayout
//
//  Created by 求攻略 on 15/3/5.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QGLTagLayoutView : UIView

@property (copy, nonatomic) NSMutableArray *itemList;

@property (assign, nonatomic) CGFloat viewHeight;

@property (nonatomic,copy) void(^tagButtonClickedBlock)(NSDictionary *tagInfo);

@property (nonatomic,strong) NSMutableArray *selectedTagList;

@end
