//
//  ViewController.m
//  QGLLayout
//
//  Created by 求攻略 on 15/3/2.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "ViewController.h"

#define kLeftMagin 10
#define kTopMagin 10
#define kButtomMagin 10
#define kRightMagin 10
#define kWidth 220
#define kSpaceMargin 10
#define kLableWidth 50
#define kLableHeight 22

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *dataArray =[NSArray arrayWithArray:[self getData]];
    
    self.itemList = dataArray;
    
    
    CGFloat row = 0;
    CGSize textSize ;
    CGFloat lableWidth;
    CGFloat startX = kLeftMagin;
    CGFloat lastX = 0;
    for(int i =0;i<self.itemList.count;i++)
    {
        NSString *text = self.itemList[i];
        
        textSize = [text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        
        if(textSize.width > 30)
            lableWidth = textSize.width+20;
        else
            lableWidth = kLableWidth;
        
        if(i)
            startX = lastX + kSpaceMargin;
        
        if(startX+lableWidth>self.view.frame.size.width)
        {
            row ++;
            startX = kLeftMagin;
        }

        UILabel *tagLabel = [self createLable:CGRectMake(startX, kTopMagin+ row * 22+row*kSpaceMargin, lableWidth, 22) title:text];
        tagLabel.tag = 0x10+i;
        
        lastX = startX+ lableWidth;
        _viewHeight = CGRectGetMaxY(tagLabel.frame);

        [self.view addSubview:tagLabel];
    }
    [self viewHeight];
}

-(NSArray *)getData
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Data" withExtension:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dic.count];
    NSString *str;
    for(int i =0;i<dic.count;i++)
    {
        str = [NSString stringWithFormat:@"item%i",i];
        NSString *a = [dic objectForKey:str];
        [arrayM addObject:a];
    }
    return arrayM;
}
-(UILabel *)createLable:(CGRect )rect title:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 3;
    label.backgroundColor = RGBCOLOR(67, 171, 254);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    
    return label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
