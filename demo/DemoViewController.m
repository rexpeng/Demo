//
//  DemoViewController.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "DemoViewController.h"
#import "UserView.h"
#import "Helper.h"
#import "UserData.h"
#import "NoFriendView.h"
#import "FriendListView.h"
#import "FriendData.h"
#import "MainTabViewController.h"
#import "NavigateView.h"
#import "FriendTabView.h"
#import "FriendInviteListView.h"

@interface DemoViewController () <NavigateViewDelegate, UserViewDelegate, FriendTabViewDelegate, NoFriendViewDelegate, FriendListViewDelegate, FriendInviteListViewDelegate>

@property (strong, nonatomic) NavigateView *navigateView;
@property (strong, nonatomic) UserView *userView;
@property (strong, nonatomic) FriendTabView *friendTabView;
@property (strong, nonatomic) NoFriendView *emptyUserView;
@property (strong, nonatomic) FriendListView *friendListView;
@property (strong, nonatomic) FriendInviteListView *friendInviteListView;

@property (strong, nonatomic) NSLayoutConstraint *userViewHeight;
@property (strong, nonatomic) NSLayoutConstraint *friendTabViewHeight;
@property (strong, nonatomic) NSLayoutConstraint *friendInviteListViewHeight;

@end

@implementation DemoViewController {
    
    UserData *userData;
    NSMutableArray *friendItems;
    NSMutableArray *friendInviteItems;
    
}

-(id)init {
    self = [self initWithNibName:@"DemoViewController" bundle:nil];
    if(self) {
        return self;
    }
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    friendItems = [NSMutableArray new];
    friendInviteItems = [NSMutableArray new];
    
    [self setupNavigateView];
    [self setupUserView];
    [self setupFriendInviteListView];
    [self setupFriendTabView];
    
    [self setupUserEmptyView];
    [self setupFriendListView];
    
    [self requestUserData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapit)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapit {
    [self.view endEditing:YES];
}

-(void)setupNavigateView {
    self.navigateView = [NavigateView new];
    
    [self.navigateView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.navigateView];
    
    [[[self.navigateView leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]] setActive:YES];
    [[[self.navigateView topAnchor] constraintEqualToAnchor:[self.view.safeAreaLayoutGuide topAnchor]] setActive:YES];
    [[[self.navigateView trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]] setActive:YES];
    [[[self.navigateView heightAnchor] constraintEqualToConstant:32] setActive:YES];
    
    self.navigateView.delegate = self;
    
}

-(void)setupUserView {
    self.userView = [UserView new];
    
    [self.userView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.userView];
    
    [[[self.userView leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]] setActive:YES];
    [[[self.userView topAnchor] constraintEqualToAnchor:[self.navigateView bottomAnchor]] setActive:YES];
    [[[self.userView trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]] setActive:YES];
    self.userViewHeight = [[self.userView heightAnchor] constraintEqualToConstant:96];
    [self.userViewHeight setActive:YES];

    
    self.userView.delegate = self;
    
}

-(void)setupFriendInviteListView {
    self.friendInviteListView = [FriendInviteListView new];
    
    [self.friendInviteListView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.friendInviteListView];
    
    [[[self.friendInviteListView leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]] setActive:YES];
    [[[self.friendInviteListView topAnchor] constraintEqualToAnchor:[self.userView bottomAnchor]] setActive:YES];
    [[[self.friendInviteListView trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]] setActive:YES];
    self.friendInviteListViewHeight = [[self.friendInviteListView heightAnchor] constraintEqualToConstant:120];
    [self.friendInviteListViewHeight setActive:YES];

    
    self.friendInviteListView.delegate = self;
}

-(void)setupFriendTabView {
    self.friendTabView = [FriendTabView new];
    
    [self.friendTabView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.friendTabView];
    
    [[[self.friendTabView leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]] setActive:YES];
    [[[self.friendTabView topAnchor] constraintEqualToAnchor:[self.friendInviteListView bottomAnchor]] setActive:YES];
    [[[self.friendTabView trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]] setActive:YES];
    self.friendTabViewHeight = [[self.friendTabView heightAnchor] constraintEqualToConstant:32];
    [self.friendTabViewHeight setActive:YES];
    
    
    self.friendTabView.delegate = self;
    
}

-(void)setupUserEmptyView {
    self.emptyUserView = [NoFriendView new];
    [self.emptyUserView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.emptyUserView];
    [self.emptyUserView setHidden:YES];
    
    [[[self.emptyUserView leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]] setActive:YES];
    [[[self.emptyUserView topAnchor] constraintEqualToAnchor:[self.friendTabView bottomAnchor]] setActive:YES];
    [[[self.emptyUserView trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]] setActive:YES];
    [[[self.emptyUserView bottomAnchor] constraintEqualToAnchor:[self.view.safeAreaLayoutGuide bottomAnchor]] setActive:YES];
    
    self.emptyUserView.delegate = self;
}

-(void)setupFriendListView {
    self.friendListView = [FriendListView new];
    [self.friendListView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.friendListView];
    [self.friendListView setHidden:YES];
    
    [[[self.friendListView leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]] setActive:YES];
    [[[self.friendListView topAnchor] constraintEqualToAnchor:[self.friendTabView bottomAnchor]] setActive:YES];
    [[[self.friendListView trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]] setActive:YES];
    [[[self.friendListView bottomAnchor] constraintEqualToAnchor:[self.view.safeAreaLayoutGuide bottomAnchor]] setActive:YES];
    
    self.friendListView.delegate = self;
    
}

-(void)requestUserData {
    NSString *url = @"https://dimanyen.github.io/man.json";
    [Helper HttpRequest:url params:nil complete:^(NSArray *result) {
        if(result != nil) {
            NSLog(@"%@", result);
            NSDictionary *data = result[0];
            
            self->userData = [UserData setData:data];
            [self setUserData];
            
            [self getFriendList: 0 items:nil];
        }
    }];
}
    
-(void)setUserData {
    self.userView.userName.text = userData.name;
    self.userView.setID.text = [NSString stringWithFormat:@"%@%@", @"KOKO ID：", userData.kokoid];
}

-(void)getFriendList:(NSInteger) idx items:(NSArray *) items {
    
    NSArray *urls;
    ITEMTYPE itemType = ((MainTabViewController *)self.tabBarController).itemType;
    
    if(idx == 0) {
        [friendItems removeAllObjects];
        [friendInviteItems removeAllObjects];
    }
    
    if(itemType == NOFRIEND) {
        urls = @[@"https://dimanyen.github.io/friend4.json"];
    } else if(itemType == FRIENDLIST) {
        [self.friendListView refreshStart];
        urls = @[@"https://dimanyen.github.io/friend1.json", @"https://dimanyen.github.io/friend2.json"];
    } else if(itemType == FRIENDLISTWITHADD) {
        [self.friendListView refreshStart];
        urls = @[@"https://dimanyen.github.io/friend3.json"];
    }
    [self marginFriendItem:items];
    
    if(idx < [urls count]) {
        
        [Helper HttpRequest:urls[idx] params:nil complete:^(NSArray * _Nonnull result) {
            if(result != nil) {
                NSLog(@"%@", result);
                //[self setFriendList:result];
                [self getFriendList:(idx+1) items:result];
            }
        }];
    } else {
        [self.friendListView refreshEnd];
        [self setFriendList:friendItems];
    }
}

-(void) marginFriendItem:(NSArray *) items {
    if(items != nil) {
        for(id item in items) {
            FriendData *data = [FriendData setData:item];
            BOOL isFound = NO;
            int i;
            for(i = 0; i < [friendItems count]; i++) {
                FriendData *fData = (FriendData *) [friendItems objectAtIndex:i];
                //NSLog(@"%@-%@", data.fid, fData.fid);
                if([data.fid isEqualToString:fData.fid]) {
                    isFound = YES;
                    if([data.upDate compare:fData.upDate] == NSOrderedDescending) {
                        [friendItems replaceObjectAtIndex:i withObject:data];
                    }
                    break;
                }
            }
            if(!isFound) {
                if(data.status == 2) {
                    [friendInviteItems addObject:data];
                } else {
                    [friendItems addObject:data];
                }
            }
        }
    }
}

-(void) setFriendList:(NSArray *) items {
    //NSLog(@"%@", items);
    [self.friendTabView setFriendCountValue:[friendInviteItems count]];
    
    if([friendInviteItems count] == 0) {
        [self.friendInviteListView setHidden:YES];
        self.friendInviteListViewHeight.constant = 0;
    } else {
        if(![self.friendInviteListView isHidden]) {
            [self.view layoutIfNeeded];
            [UIView animateWithDuration:0.5f animations:^{
                self.friendInviteListViewHeight.constant = 120;
                [self.friendInviteListView setAlpha:1];
                [self.view layoutIfNeeded];
                [self.friendInviteListView setHidden:NO];
            }];
            [self.friendInviteListView setData:friendInviteItems];
        }
    }
    if([items count] == 0) {
        [self.friendListView setHidden:YES];
        [self.emptyUserView setHidden:NO];
    } else {
        [self.friendTabView setTalkCountValue:200];
        [self.friendListView setItems:items];
        [self.emptyUserView setHidden:YES];
        [self.friendListView setHidden:NO];
    }
}

#pragma Friend list delegate

-(void)refreshFriendList {
    //[friendItems removeAllObjects];
    [self getFriendList:0 items:nil];
}

-(void)friendClick:(ActionType)actionType withData:(FriendData *)data {
    [self.view endEditing:YES];
    NSString *action = ActionTypeValue(actionType);
    NSLog(@"%@ - %@", action, data.name);
}

#pragma invite list delegate

-(void)inviteClick:(InviteType)inviteType withData:(FriendData *)data {
    [self.view endEditing:YES];
    if(inviteType == AGREE) {
        NSLog(@"agree invite friend click => %@", data.name);
    } else if(inviteType == DELETE) {
        NSLog(@"delete invite friend click => %@", data.name);
    }
}

-(void)hidenInviteList:(BOOL)isHiden {
    CGFloat height;
    if(isHiden) {
        height = 120;
    } else {
        height = 200;
    }
    [UIView animateWithDuration:1.0 animations:^{
        self.friendInviteListViewHeight.constant = height;
        [self.view layoutIfNeeded];
    }];
}

#pragma search input delegate

-(void)searchShouldBeginEdit {
    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5f animations:^{
        self.userViewHeight.constant = 0;
        [self.userView setAlpha:0];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.userView setHidden:YES];
    }];
    
    if([friendInviteItems count] > 0) {
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.5f animations:^{
            self.friendInviteListViewHeight.constant = 0;
            [self.friendInviteListView setAlpha:0];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.friendInviteListView setHidden:YES];
        }];
    }

    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5f animations:^{
        self.friendTabViewHeight.constant = 0;
        [self.friendTabView setAlpha:0];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.friendTabView setHidden:YES];
    }];
}

-(void)searchDidEndEdit {
    [self.view endEditing:YES];
    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5f animations:^{
        self.userViewHeight.constant = 96;
        [self.userView setAlpha:1];
        [self.view layoutIfNeeded];
        [self.userView setHidden:NO];
    }];
    
    if([friendInviteItems count] > 0) {
        CGFloat height;
        if([self.friendInviteListView isInviteListHidden]) {
            height = 120;
        } else {
            height = 200;
        }
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.5f animations:^{
            self.friendInviteListViewHeight.constant = height;
            [self.friendInviteListView setAlpha:1];
            [self.view layoutIfNeeded];
            [self.friendInviteListView setHidden:NO];
        }];
    }

    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5f animations:^{
        self.friendTabViewHeight.constant = 32;
        [self.friendTabView setAlpha:1];
        [self.view layoutIfNeeded];
        [self.friendTabView setHidden:NO];
    }];
}

-(void)searchAddClick {
    [self.view endEditing:YES];
    NSLog(@"search add btn click");
}

#pragma no friend delegate

-(void)addFriendClick {
    [self.view endEditing:YES];
    NSLog(@"add friend click");
}

-(void)setIDClick {
    [self.view endEditing:YES];
    NSLog(@"set id click");
}

#pragma user view delegate

-(void)BtnClick:(BtnType)btnType {
    [self.view endEditing:YES];
    switch(btnType) {
        case USERIMAGE:
            NSLog(@"userimage click");
            break;
        case SETID:
            NSLog(@"setid click");
            break;
    }
}

#pragma navigate delegate

-(void)naviBtnClick:(NaviType)btnType {
    [self.view endEditing:YES];
    switch(btnType) {
        case WITHDRAW:
            NSLog(@"withdraw click");
            break;
        case TRANSFER:
            NSLog(@"trnasfer click");
            break;
        case SCAN:
            NSLog(@"scan click");
            break;
    }
}

#pragma friend tab delegate

-(void)tabBtnClick:(TabType)btnType {
    [self.view endEditing:YES];
    switch(btnType) {
        case FRIEND:
            NSLog(@"friend tab click");
            break;
        case TALK:
            NSLog(@"talk tab click");
            break;
    }
}

@end
