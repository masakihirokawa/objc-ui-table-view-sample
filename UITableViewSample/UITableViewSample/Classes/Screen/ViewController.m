//
//  ViewController.m
//  UITableViewSample
//
//  Created by Dolice on 2014/01/11.
//  Copyright (c) 2014年 Masaki Hirokawa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UITableView *myTableView;     // テーブルビュー
@property NSArray     *myList;          // テーブルビューに表示するリスト
@property CGPoint     lastScrollOffset; // テーブルビュー最後のスクロール位置

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // テーブルビューに表示するリスト登録
    [self setMyList];
    
    // テーブルビュー配置
    [self setMyTableView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // テーブルビューの最後の位置を保持
    _lastScrollOffset = [_myTableView contentOffset];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // テーブルビューのセルが選択されていた場合に選択を解除する
    NSIndexPath *selection = [_myTableView indexPathForSelectedRow];
    if (selection) {
        [_myTableView deselectRowAtIndexPath:selection animated:YES];
    }
    [_myTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // テーブルビューを最後に保存した位置までスクロールする
    [_myTableView setContentOffset:_lastScrollOffset];
    
    // テーブルビューが更新された時にスクロールバーが点滅するよう指定
    [_myTableView flashScrollIndicators];
}

#pragma mark - My List

// テーブルビューに表示するリスト登録
- (void)setMyList
{
    _myList = @[@"Apple", @"Grapes", @"Lemon", @"Cherry", @"Grapefruit", @"Pineapple",
                @"Banana", @"Strawberry", @"Blueberry", @"Orange", @"Mellon"];
}

#pragma mark - My Table View

// テーブルビュー配置
- (void)setMyTableView
{
    // 初期化
    _myTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    
    // デリゲート指定
    _myTableView.delegate = self;
    
    // データ・ソース指定
    _myTableView.dataSource = self;
    
    // 背景色指定
    _myTableView.backgroundColor = [UIColor whiteColor];
    
    // ボーダーラインを指定（今回は使用しない）
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // オフセットを指定（今回はオフセットを無しに指定）
    _myTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // IDを指定
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // ビューに追加
    [self.view addSubview:_myTableView];
}


#pragma mark - Table View delegate method

// セルの定義
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // インデックス保持
    int index = [indexPath indexAtPosition:[indexPath length] - 1];
    
    // セルのユニークID登録
    NSString *CellIdentifier = [_myList objectAtIndex:index];
    
    // セル初期化
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // セルの背景指定
        UIView *cellBackgroundView = [[UIView alloc] init];
        cellBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = cellBackgroundView;
        
        // セルの選択時の背景指定
        UIView *cellSelectedBackgroundView = [[UIView alloc] init];
        cellSelectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
        cell.selectedBackgroundView = cellSelectedBackgroundView;
        
        // セルの右側に矢印アイコンを表示
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // セル内容更新
        [self updateCell:cell atIndexPath:indexPath];
    }
    return cell;
}

// セル内容の定義
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // インデックス保持
    int index = [indexPath indexAtPosition:[indexPath length] - 1];
    
    // セルのタイトル指定
    cell.textLabel.text = [_myList objectAtIndex:index];
    cell.textLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    // セルのボーダーライン配置（既定のだと左端に余白が出来てしまうため）
    UIView *borderline = [[UIView alloc] initWithFrame:CGRectMake(0, 59, 320, 1)];
    borderline.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    [cell.contentView addSubview:borderline];
    
    // ここに画像やラベルを配置しカスタマイズできます
    
    
    
}

// セルタップ時のイベント
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 画面遷移前のスクロール位置を保持
    _lastScrollOffset = [_myTableView contentOffset];
    
    // ここで画面遷移などを行う
    
    
    
}

// セルの数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_myList count];
}

// セルのセクション数を設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// セル高さを設定
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

// セルの背景色指定
- (void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithRed:0.988f green:0.988f blue:0.988f alpha:1.0f];
}

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

// テーブルビューの編集モード
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // インデックス保持
        // int index = [indexPath indexAtPosition:[indexPath length] - 1];
        
        // ここで配列などデータの削除を行う
        
        
        
        // 削除ボタンを押下されたボタンの行を削除
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// 削除ボタンの文言変更
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"削除";
}

@end
