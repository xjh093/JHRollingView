# JHRollingView
up rolling animation
- 向上滚动动画

---

# Example

```
// init
JHRollingView *rollingView = [[JHRollingView alloc] initWithFrame:CGRectMake(0, 0, 100, 18)];
[self addSubview:rollingView];

// after fetch data
- (void)configRollingView:(JHRollingView *)rollingView data:(NSArray *)data
{
    //
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 18, 18);
    imageView.image = holderImage;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 9;
    imageView.tag = 100;
    [rollingView.contentView addSubview:imageView];
    
    //
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(23, 0, 0, 18);
    label.font = 12;
    label.textAlignment = NSTextAlignmentLeft;
    label.tag = 200;
    [rollingView.contentView addSubview:label];
    
    //
    rollingView.refreshBlock = ^(JHRollingView * _Nonnull view, NSDictionary *data) {
        UIImageView *imageView = [view.contentView viewWithTag:100];
        UILabel *label = [view.contentView viewWithTag:200];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:data[@"headUrl"]] placeholderImage:holderImage];
        
        label.text = [NSString stringWithFormat:@"刚刚给你送了%@个礼物", data[@"count"]];
        // label.okidoki.autoWidth(@0); // size
        
        view.contentView.width = label.right;
        view.contentView.centerX = view.width *0.5;
    };
    
    // finally
    [rollingView configWithData:data];
}
```

---

