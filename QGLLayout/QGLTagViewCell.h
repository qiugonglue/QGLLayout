//
//  TableViewCell.h
//  QGLLayout
//
//  Created by 求攻略 on 15/3/5.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QGLTagLayoutView.h"

@interface QGLTagViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet QGLTagLayoutView *tagView;

@property (weak, nonatomic) IBOutlet UITextField *addTagTextField;

@property (nonatomic,copy) void(^addTaglabelBlock)(NSString *title);
@end
