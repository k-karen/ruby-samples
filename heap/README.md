# myheap.rb

### 使用例
index & value delete型
https://atcoder.jp/contests/abc128/tasks/abc128_e
https://atcoder.jp/contests/abc128/submissions/5916231

pop 型
https://atcoder.jp/contests/abc062/tasks/arc074_b
https://atcoder.jp/contests/abc062/submissions/6315855

### メソッド説明
def initialize(n)  
いつもの(初期化用)  
値を引数に削除・追加の操作を行いたかったので、  
値とindexを結ぶためのHashを持ってます  

def push(current_value)  
要素の追加・重複要素は追加できません。  
(値をもとに削除操作を行う都合上そうしています)  

def delete(delete_target_value)  
値を引数に、要素の削除を行います  

def top  
最小要素へのアクセス  

def check_valid  
デバッグ用に作ってます。  
親子関係が正しくないノードがあるとraiseします  

def change(index_i, index_j)  
要素の入れ替えメソッドです。  
