//
//  UserPlaceTableViewCell.m
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "UserPlaceTableViewCell.h"

@implementation UserPlaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(UserPlaceTableViewCell *)createTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath titleDataArr:(NSMutableArray *)titleDataArr
{
    static NSString * identifer = @"UserPlaceTableViewCell";
    
    UINib * nib = [UINib nibWithNibName:identifer bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:identifer];
    
    UserPlaceTableViewCell * cell = (UserPlaceTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr=[titleDataArr safeObjectAtIndex:indexPath.section];
    cell.m_titlePlaceLab.text = arr[indexPath.row];
    
    return cell;
}
@end
