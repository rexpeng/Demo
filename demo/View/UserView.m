//
//  UserView.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "UserView.h"

@interface UserView()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation UserView {
    UIView *ball;
}


-(id)init {
    self = [super init];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"UserView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.contentView.frame = self.bounds;
        [self initView];
    }
    return self;
}

-(void)layoutSubviews {
    [self.userImage.layer setCornerRadius:27];
    
    [ball.layer setCornerRadius:6];
    ball.backgroundColor = [UIColor colorWithRed:236/255.0 green:0/255.0 blue:14/255.0 alpha:1];
}

-(void)initView {
    //[super awakeFromNib];
    
    
    self.userName.text = @"";
    self.setID.text = @"設定 KOKO ID";
    
    ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [ball setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:ball];
    [[[ball leadingAnchor] constraintEqualToAnchor:[self.infoBack trailingAnchor] constant:18] setActive:YES];
    [[[ball centerYAnchor] constraintEqualToAnchor:[self.setID centerYAnchor]] setActive:YES];
    [[[ball widthAnchor] constraintEqualToConstant:10] setActive:YES];
    [[[ball heightAnchor] constraintEqualToConstant:10] setActive:YES];
    
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick:)];
    [self.userImage setUserInteractionEnabled:YES];
    [self.userImage addGestureRecognizer:tap3];

    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick:)];
    [self.setID setUserInteractionEnabled:YES];
    [self.setID addGestureRecognizer:tap4];

    
}

-(void)btnclick:(UIGestureRecognizer *)recognizer {
    UIView *view =  recognizer.view;
    if(self.delegate != nil) {
    
        if([view isEqual:self.userImage]) {
            [self.delegate BtnClick:USERIMAGE];
        } else if([view isEqual:self.setID]) {
            [self.delegate BtnClick:SETID];
        } 
        
    }
}


@end
