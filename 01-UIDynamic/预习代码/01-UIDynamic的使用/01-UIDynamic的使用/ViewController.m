//
//  ViewController.m
//  01-UIDynamic的使用
//
//  Created by apple on 15-1-2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 仿真元素
@property (weak, nonatomic) IBOutlet UIView *purpleView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  点击控制器的View,开始仿真
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    // 0.获取用户点击的点
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    
//    // 1.删除旧的捕捉行为
//    [self.animator removeAllBehaviors];
//    
//    // 2.创建新的捕捉仿真行为
//    // 捕捉行为,每次只能捕捉一个,也就是如果你之前已经向仿真器中添加了捕捉行为,再次添加,就没有效果
//    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:point];
//    
//    // damping减震,取值范围是0.0~1.0,值越小,振幅越大
//    snap.damping = 1.0;
//    
//    // 3.将新的捕捉仿真行为添加到仿真器中
//    [self.animator addBehavior:snap];
    [self test];
}

- (void)testGravity2
{
    // 1.创建重力仿真行为
    // items : 仿真元素,就是你要对谁进行仿真
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.purpleView]];
    // 设置向量:可以决定我们重力仿真的大小和方向
    // gravity.gravityDirection = CGVectorMake(5.0, 1.0);
    // angle默认是M_PI_2,
    // gravity.angle = M_PI_4;
    // magnitude默认的值是1.0,设置加速度的大小
    // m * s * s:1000
    gravity.magnitude = 5.0;
    
    // 2.将仿真行为添加到仿真器中
    [self.animator addBehavior:gravity];
}

/**
 *  示例测试
 */
- (void)test
{
    // 1.创建重力仿真行为
    // items : 仿真元素,就是你要对谁进行仿真
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.purpleView]];
    
    // 2.创建碰撞仿真行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.purpleView, self.redView]];
    // 将参照试图的bounds作为边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 添加了一个新的边界
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:self.greenView.frame];
    [collision addBoundaryWithIdentifier:@"greenView" forPath:bezierPath];
    
    // 2.将仿真行为添加到仿真器中
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 *  两个方针元素的碰撞行为
 */
- (void)testTwoCollision
{
    // 1.创建重力仿真行为
    // items : 仿真元素,就是你要对谁进行仿真
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.purpleView]];
    
    // 2.创建碰撞仿真行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.purpleView, self.redView]];
    // 将参照试图的bounds作为边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 2.将仿真行为添加到仿真器中
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 *  仿真重力和碰撞
 */
- (void)testGravityAndCollision
{
    // 1.创建重力仿真行为
    // items : 仿真元素,就是你要对谁进行仿真
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.purpleView]];
    
    // 2.创建碰撞仿真行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.purpleView]];
    // 将参照试图的bounds作为边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 2.将仿真行为添加到仿真器中
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 *  重力仿真
 */
- (void)testGravity
{
    // 1.创建仿真行为
    // items : 仿真元素,就是你要对谁进行仿真
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.purpleView]];
    
    // 2.将仿真行为添加到仿真器中
    [self.animator addBehavior:gravity];
}


#pragma mark - 懒加载
- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        // 创建一个仿真器
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

@end
