//
//  TheTagCellViewController.m
//  QGLLayout
//
//  Created by 求攻略 on 15/3/5.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "TheTagCellViewController.h"
#import "QGLTagViewCell.h"

@interface TheTagCellViewController ()

@property (nonatomic,strong) NSMutableArray *selectedTagList;

@end

@implementation TheTagCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QGLTagViewCell" bundle:nil] forCellReuseIdentifier:@"QGLTagViewCell"];
    
    self.tagItemList = [self getData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QGLTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QGLTagViewCell"];
    
    cell.tagView.itemList = self.tagItemList;
    
    CGFloat viewHeight = cell.tagView.viewHeight ;
  
    return viewHeight + 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QGLTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QGLTagViewCell" forIndexPath:indexPath];
    
    cell.tagView.itemList = self.tagItemList;
    
    cell.tagView.selectedTagList = self.selectedTagList;
    
    if(!cell.addTaglabelBlock)
    {
        [cell setAddTaglabelBlock:^(NSString *title) {
            
            [self.tagItemList addObject:title];
            
            [tableView reloadData];
        }];
    }
    if(!cell.tagView.tagButtonClickedBlock)
    {
        [cell.tagView setTagButtonClickedBlock:^(NSDictionary *tagInfo) {
           //选中标签类型
            int index = [[tagInfo objectForKey:@"index"] intValue];
            
            BOOL isSelected = [[tagInfo objectForKey:@"ifSelected"] intValue]?1:0;
            
            NSLog(@"[CWW] 标签类型:%@ 是否选中:%i",self.tagItemList[index],isSelected);
            
            if(self.selectedTagList.count >0)
            {
                BOOL ifExist = NO;
                
                for(NSDictionary *temp in self.selectedTagList)
                {
                    if([[temp objectForKey:@"index"] isEqualToString:[tagInfo objectForKey:@"index"]])
                    {
                        [temp setValue:[tagInfo objectForKey:@"ifSelected"] forKey:@"ifSelected"];
                        ifExist = YES;
                    }
                }
                if(!ifExist)
                    [self.selectedTagList addObject:tagInfo];
            }
            else
                 [self.selectedTagList addObject:tagInfo];
            
        }];
    }
    
    return cell;
}
-(NSMutableArray *)selectedTagList
{
    if(!_selectedTagList)
        _selectedTagList = [NSMutableArray array];
    
    return _selectedTagList;
}
-(NSMutableArray *)getData
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
