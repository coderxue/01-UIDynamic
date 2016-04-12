//
//  ViewController.m
//  UIDynamic
//
//  Created by apple on 15/2/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 红色的View
@property (weak, nonatomic) IBOutlet UIView *redView;
// 蓝色的View
@property (weak, nonatomic) IBOutlet UIView *blueView;

@property(nonatomic,strong)UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // -1.将之前的捕捉行为移除
    [self.animator removeAllBehaviors];
    
    // 0.取出用户点击的点
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    // 1.创建捕捉行为
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:point];
    
    // 1.1.设置捕捉行为的阻力
    snap.damping = 0.5;
    
    // 2.将仿真行为添加到仿真器中(在同一个仿真器当中,只能存在捕捉行为)
    [self.animator addBehavior:snap];
}

/**
 *  测试重力仿真其他属性
 */
- (void)testGravity
{
    // 1.创建仿真行为
    NSArray *items = @[self.redView, self.blueView];
    // 1.1.创建重力仿真行为,并且指定仿真元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    // 1.1.1.设置重力角度(默认是M_PI_2)
    // gravity.angle = M_PI_2;
    
    // 1.1.2.设置重力的大小(默认是1.0)
    // gravity.magnitude = 10.0;
    
    // 1.1.3.设置向量
    gravity.gravityDirection = CGVectorMake(3.0, 1.0);
    
    // 1.2.创建碰撞行为,并且指定仿真元素
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:items];
    
    // 1.2.1.将仿真器的bounds作为碰撞的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 2.将仿真行为添加到仿真器中,开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 *  测试碰撞仿真其他属性
 */
- (void)testCollision
{
    // 1.创建仿真行为
    NSArray *items = @[self.redView];
    // 1.1.创建重力仿真行为,并且指定仿真元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:items];
    
    // 1.2.创建碰撞行为,并且指定仿真元素
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:items];
    
    // 1.2.1.将仿真器的bounds作为碰撞的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 1.2.2.添加一个边界(线段)
    CGPoint startPoint = CGPointMake(0, 100);
    CGPoint endPoint = CGPointMake(self.view.frame.size.width, 321);
    [collision addBoundaryWithIdentifier:@"line" fromPoint:startPoint toPoint:endPoint];
    // [collision removeBoundaryWithIdentifier:@"line"];
    
    // 1.2.3.添加一个边界(贝塞尔曲线)
    // UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 320, 320)];
    // [collision addBoundaryWithIdentifier:@"bezierPath" forPath:bezierPath];
    
    // 2.将仿真行为添加到仿真器中,开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 *  重力仿真和碰撞仿真
 */
- (void)gravityAndCollision
{
    // 1.创建仿真行为
    NSArray *items = @[self.redView];
    // 1.1.创建重力仿真行为,并且指定仿真元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:items];
    
    // 1.2.创建碰撞行为,并且指定仿真元素
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:items];
    
    // 1.2.1.将仿真器的bounds作为碰撞的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 2.将仿真行为添加到仿真器中,开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 *  简单重力仿真
 */
- (void)gravity
{
    /*
     // 1.创建仿真器,并且指定仿真范围
     UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
     */
    // 2.创建重力仿真行为,并且指定仿真元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    // 3.将仿真行为添加到仿真器中,开始仿真
    [self.animator addBehavior:gravity];
}

#pragma mark - 懒加载
- (UIDynamicAnimator *)animator
{
    if (_animator == nil) {
        // 创建仿真器,并且指定仿真范围
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

@end
