//
//  FLLTest2ViewController.m
//  MyLayout
//
//  Created by oybq on 16/2/12.
//  Copyright © 2016年 YoungSoft. All rights reserved.
//

#import "FLLTest2ViewController.h"
#import "MyLayout.h"
#import "CFTool.h"

@interface FLLTest2ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tagTextField;
@property (weak, nonatomic) IBOutlet MyFlowLayout *flowLayout;

@end

@implementation FLLTest2ViewController

- (void)viewDidLoad {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;  //设置视图控制器中的视图尺寸不延伸到导航条或者工具条下面。您可以注释这句代码看看效果。

    /*
       这个例子用来介绍流式布局中的内容填充流式布局，主要用来实现标签流的功能。内容填充流式布局的每行的数量是不固定的，而是根据其内容的尺寸来自动换行。
       同时这个例子也可以看出XIB是完全可以和MyLayout中进行结合使用的，我们可以在XIB上进行视图的创建和其他属性的设置，同时拉出插座变量，然后再viewDidLoad中进行布局属性设置就好了。
     */
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
            
    [self createTagButton:NSLocalizedString(@"click to remove tag", @"")];
    [self createTagButton:NSLocalizedString(@"tag2", @"")];
    [self createTagButton:NSLocalizedString(@"MyLayout can used in XIB&SB", @"")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- Layout Construction

-(void)createTagButton:(NSString*)text
{
    UIButton *tagButton = [UIButton new];
    [tagButton setTitle:text forState:UIControlStateNormal];
    tagButton.titleLabel.font = [CFTool font:15];
    tagButton.layer.cornerRadius = 15;
    tagButton.backgroundColor = [CFTool color:random()%15];    
    //这里可以看到尺寸宽度等于自己的尺寸宽度并且再增加10，且最小是40，意思是按钮的宽度是等于自身内容的宽度再加10，但最小的宽度是40
    //如果没有这个设置，而是直接调用了sizeToFit则按钮的宽度就是内容的宽度。
    tagButton.widthSize.equalTo(@(MyLayoutSize.wrap)).add(10).min(40);
    tagButton.heightSize.equalTo(@(MyLayoutSize.wrap)).add(10); //高度根据自身的内容再增加10
    [tagButton sizeToFit];
    [tagButton addTarget:self action:@selector(handleDelTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.flowLayout addSubview:tagButton];
    
}

#pragma mark -- Handle Method

- (IBAction)handleAddTag:(id)sender {
    
    if (self.tagTextField.text.length == 0)
        return;
    
    [self createTagButton:self.tagTextField.text];
    
    self.tagTextField.text = @"";
    
    [self.flowLayout layoutAnimationWithDuration:0.2];
    
}

- (IBAction)handleDelTag:(UIButton*)sender {
    
    [sender removeFromSuperview];
    
    [self.flowLayout layoutAnimationWithDuration:0.2];
}


- (IBAction)handleAdjustSpaceChange:(UISwitch *)sender {
    
    //间距拉伸
    if (sender.isOn)
        self.flowLayout.gravity = MyGravity_Horz_Between;  //流式布局的gravity如果设置为MyGravity_Horz_Fill表示子视图的间距会被拉伸，以便填充满整个布局。
    else
        self.flowLayout.gravity = MyGravity_None;
    
    [self.flowLayout layoutAnimationWithDuration:0.2];
}

- (IBAction)handleAdjustSizeChange:(UISwitch *)sender {
    
    //内容拉伸
    if (sender.isOn)
        self.flowLayout.gravity = MyGravity_Horz_Fill;  //对于内容填充的流时布局来说，gravity属性如果设置为MyGravity_Horz_Fill表示里面的子视图的内容会自动的拉伸以便填充整个布局。
    else
        self.flowLayout.gravity = MyGravity_None;
    
    [self.flowLayout layoutAnimationWithDuration:0.2];

}

- (IBAction)handleAutoArrangeChange:(UISwitch *)sender {
    
    //自动调整位置。
    if (sender.isOn)
        self.flowLayout.autoArrange = YES;  //autoArrange属性会根据子视图的内容自动调整，以便以最合适的布局来填充布局。
    else
        self.flowLayout.autoArrange = NO;
    
    [self.flowLayout layoutAnimationWithDuration:0.2];

}

-(IBAction)handleGravityAlwaysChange:(id)sender
{
    self.flowLayout.isFlex = !self.flowLayout.isFlex;
}




@end
