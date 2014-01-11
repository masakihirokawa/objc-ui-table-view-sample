テーブルビューの使用方法まとめ
=========================
UITableViewの使用例をまとめたサンプルを作成しました。このサンプルでは、*UITableViewController*を使用せず、*UIViewController*に *UITableView*のデリゲートを指定し使用しています。

カスタムセルや編集モードの使用例をはじめ、使用頻度の高いデリゲートメソッドを搭載していますので、テンプレートとしてもご使用いただけます。

##サンプルの主な機能

1. ヘッダー＆フッター追加
2. スクロール位置の保持と復元
3. セルをフリックした際の編集モード
4. 編集モード時の削除ボタンの文言変更
5. カスタムセルでボーダーラインを指定（標準の *UITableViewCellSeparatorStyle*で余白が空く問題解消）

##その他の機能

1. セルの背景指定
2. セルの選択時の背景指定
3. セルの右側に矢印アイコンを指定
4. オフセットの指定

##使用前に必要な手順（ヘッダファイルにデリゲート指定追加）

```objective-c
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@end
```

##カスタマイズ使用例

###ヘッダー追加方法

```objective-c
// ヘッダー配置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // ヘッダー画像配置
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    headerImageView.image = [UIImage imageNamed:@"header.png"];
    
    return headerImageView;
}

// ヘッダーの高さ指定
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}
```

###フッター追加方法

```objective-c
// フッター配置
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // ヘッダー画像配置
    UIImageView *footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    footerImageView.image = [UIImage imageNamed:@"footer.png"];
    
    return footerImageView;
}

// フッターの高さ指定
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
```

###テーブルビューを最後に保存した位置までスクロール

```objective-c
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // テーブルビューを最後に保存した位置までスクロールする
    [_myTableView setContentOffset:_lastScrollOffset];
}
```

###編集モードの追加方法

```objective-c
// テーブルビューの編集モード
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // ここで配列などデータの削除を行う

        
        // 削除ボタンを押下されたボタンの行を削除
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
```

###編集モード時の削除ボタンの文言変更

```objective-c
// 削除ボタンの文言変更
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"削除";
}
```

###カスタムセルの使用方法

```objective-c
// セルの定義
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [indexPath indexAtPosition:[indexPath length] - 1];
    NSString *CellIdentifier = @"ユニークな文字列をここに指定します";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        // セル内容更新
        [self updateCell:cell atIndexPath:indexPath];
    }
    return cell;
}

// セル内容の定義
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // ここに画像やラベルを配置しカスタマイズ
    
}
```

###セルの背景指定

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ユニークな文字列をここに指定します";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // セルの背景指定
        UIView *cellBackgroundView = [[UIView alloc] init];
        cellBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = cellBackgroundView;
      
        // セル内容更新
        [self updateCell:cell atIndexPath:indexPath];
    }
    return cell;
}
```

###セル選択時の背景指定

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ユニークな文字列をここに指定します";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // セル選択時の背景指定
        UIView *cellSelectedBackgroundView = [[UIView alloc] init];
        cellSelectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
        cell.selectedBackgroundView = cellSelectedBackgroundView;
        
        // セル内容更新
        [self updateCell:cell atIndexPath:indexPath];
    }
    return cell;
}
```

###セルの右側に矢印アイコンを表示

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ユニークな文字列をここに指定します";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // セルの右側に矢印アイコンを表示
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // セル内容更新
        [self updateCell:cell atIndexPath:indexPath];
    }
    return cell;
}
```

###オフセットを指定（320*50px の広告を画面下部に表示する際は下記のように指定）

```objective-c
_myTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
```
