//
//  ViewController.m
//  02-UIDynamic(愤怒的小鸟)
//
//  Created by apple on 15-1-13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) UIDynamicAnimator *animatator;

@property (weak, nonatomic) IBOutlet UIImageView *bird;
@property (weak, nonatomic) IBOutlet UIImageView *ice1;
@property (weak, nonatomic) IBOutlet UIImageView *ice2;
@property (weak, nonatomic) IBOutlet UIImageView *ice3;
@property (weak, nonatomic) IBOutlet UIImageView *ice4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 创建重力仿真行为
    NSArray *items = @[self.bird, self.ice1, self.ice2, self.ice3 ,self.ice4];
    UIGravityBehavior *gravity1 = [[UIGravityBehavior alloc] initWithItems:items];
    
    // 创建碰撞仿真行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:items];
    // 将参照视图的bounds作为边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 创建推动仿真行为(创建的时候需要传入一个枚举)
    // UIPushBehaviorModeContinuous 持续的
    // UIPushBehaviorModeInstantaneous 非持续的
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.bird] mode:UIPushBehaviorModeInstantaneous];
    // 设置push作用的向量(方向和大小)
    push.pushDirection = CGVectorMake(2.0, 0);
    
    // 将仿真行为添加到仿真器中
    [self.animatator addBehavior:gravity1];
    [self.animatator addBehavior:collision];
    [self.animatator addBehavior:push];
}

#pragma mark - 懒加载
- (UIDynamicAnimator *)animatator
{
    if (!_animatator) {
        _animatator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animatator;
}

@end