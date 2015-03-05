//
//  QGLTagLayoutView.m
//  QGLLayout
//
//  Created by 求攻略 on 15/3/5.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "QGLTagLayoutView.h"

#define kLeftMagin 0
#define kTopMagin 0
#define kButtomMagin 0
#define kRightMagin 0
#define kWidth [UIScreen mainScreen].bounds.size.width - 30
#define kSpaceMargin 5
#define kButtonWidth 75
#define kButtonHeight 30

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


@implementation QGLTagLayoutView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGFloat row = 0;
    CGSize textSize ;
    CGFloat buttonWidth;
    CGFloat startX = kLeftMagin;

    for(int i =0;i<self.itemList.count;i++)
    {
        NSString *text = self.itemList[i];
        
        textSize = [text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        
        if(textSize.width>30)
            buttonWidth = textSize.width+50;
        else
            buttonWidth = kButtonWidth;
        
        if(startX+buttonWidth>kWidth)
        {
            row ++;
            startX = kLeftMagin;
        }
        
        UIButton *tagButton = [self createButton:CGRectMake(startX, kTopMagin+ row * kButtonHeight+row*kSpaceMargin, buttonWidth, kButtonHeight) title:text];
        
        tagButton.tag = 0x10 + i;
        
        [tagButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDictionary *tagInfo ;
        for(NSDictionary *temp in self.selectedTagList)
        {
            if([[temp objectForKey:@"index"] intValue] == i)
            {
                tagInfo = temp;
                break;
            }
        }
        
        if(tagInfo && [[tagInfo objectForKey:@"ifSelected"] intValue])
        {
            tagButton.selected = YES;
            [tagButton setBackgroundColor:RGBCOLOR(67, 171, 254)];
        }
        else
        {
            tagButton.selected = NO;
            [tagButton setBackgroundColor:RGBCOLOR(221, 221, 221)];
        }
        
        startX = startX+ buttonWidth + kSpaceMargin;
        
        [self addSubview:tagButton];
    }
}
-(CGFloat)viewHeight
{
    CGFloat row = 0;
    CGSize textSize ;
    CGFloat buttonWidth;
    CGFloat startX = kLeftMagin;
    _viewHeight = 30 + kTopMagin;
    for(int i =0;i<self.itemList.count;i++)
    {
        NSString *text = self.itemList[i];
        
        textSize = [text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        
        if(textSize.width>30)
            buttonWidth = textSize.width+50;
        else
            buttonWidth = kButtonWidth;
        
        if(startX+buttonWidth>kWidth)
        {
            row ++;
            startX = kLeftMagin;
            _viewHeight += kButtonHeight + kSpaceMargin;
        }
        startX = startX+ buttonWidth + kSpaceMargin;
    }
    
    return _viewHeight;
}

-(void)clicked:(UIButton *)sender
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSString stringWithFormat:@"%li",sender.tag-0x10] forKey:@"index"];
    
    sender.selected = !sender.selected;
    
    if(sender.selected)
    {
        [sender setBackgroundColor:RGBCOLOR(67, 171, 254)];
        
        [dic setObject:@"1" forKey:@"ifSelected"];
    }
    else
    {
        [sender setBackgroundColor:RGBCOLOR(221, 221, 221)];
        
        [dic setObject:@"0" forKey:@"ifSelected"];
    }
    
    if(self.tagButtonClickedBlock)
    {
        self.tagButtonClickedBlock(dic);
    }
    
}
-(UIButton *)createButton:(CGRect )rect title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    
    btn.layer.masksToBounds = YES;
    
    btn.layer.cornerRadius = 3;
    
    btn.backgroundColor = RGBCOLOR(221, 221, 221);
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected] ;
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}


@end
