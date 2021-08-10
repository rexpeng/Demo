//
//  FriendViewCell.m
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import "FriendViewCell.h"

@implementation FriendViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClick:)];
    [self.transfer addGestureRecognizer:tap];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClick:)];
    [self.invite addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClick:)];
    [self.friendMore setUserInteractionEnabled:YES];
    [self.friendMore addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClick:)];
    [self.contentView addGestureRecognizer:tap3];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [self.userImage.layer setCornerRadius:20];
    
    [self.transfer.layer setBorderWidth:1.2];
    [self.transfer.layer setBorderColor:[UIColor colorWithRed:236/255.0 green:0/255.0 blue:140/255.0 alpha:1].CGColor];
    
    [self.invite.layer setBorderWidth:1.2];
    [self.invite.layer setBorderColor:[UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1].CGColor];
}

-(void)setView:(FriendData *)data {
    self.friendData = data;
    
    if([data.isTop isEqual:@"1"]) {
        [self.star setHidden:NO];
    } else {
        [self.star setHidden:YES];
    }
    self.name.text = data.name;
    if(data.status == 0) {
        [self.friendMore setHidden:YES];
        [self.invite setHidden:NO];
        self.space.constant = 42;
    } else if(data.status == 1) {
        [self.invite setHidden:YES];
        [self.friendMore setHidden:NO];
        self.space.constant = 25;
    }
}

-(void)actionClick:(UITapGestureRecognizer *)tapGesture {
    UIView *view = tapGesture.view;
    if(self.delegate != nil) {
        if([view isEqual:self.transfer]) {
            [self.delegate friendClick:TRANSFERACTION withData:self.friendData];
        } else if([view isEqual:self.invite]) {
            [self.delegate friendClick:INVITEACTION withData:self.friendData];
        } else if([view isEqual:self.friendMore]) {
            [self.delegate friendClick:MOREACTION withData:self.friendData];
        } else if([view isEqual:self.contentView]) {
            [self.delegate friendClick:ITEMACTION withData:self.friendData];
        }
    }
}

@end
