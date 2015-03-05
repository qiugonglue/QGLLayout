//
//  TableViewCell.m
//  QGLLayout
//
//  Created by 求攻略 on 15/3/5.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "QGLTagViewCell.h"

@implementation QGLTagViewCell

- (void)awakeFromNib {
    
    self.addTagTextField.borderStyle = UITextBorderStyleNone;
    
    self.addTagTextField.layer.masksToBounds = YES;
    
    self.addTagTextField.layer.cornerRadius = 3;
    
    self.addTagTextField.layer.borderWidth = 0.5;
    
    self.addTagTextField.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.addTagTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    
    self.addTagTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.backgroundColor = [UIColor whiteColor];
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.addTaglabelBlock)
    {
        self.addTaglabelBlock(textField.text);
    }
    return YES;
}
@end
