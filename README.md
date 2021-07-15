# Rails API テンプレート

## 環境設定

### アプリ名称設定

- `config/database.yml` のデータベース名
    - 3箇所あるので注意
- `config/application.rb` のモジュール名

## 初回起動

- `setup.sh` を叩く
    - 記述されているコマンドを手動で実行してもいい
- `master.key`再生成
  1. `:q`
  2. 特に何も変更せずに閉じる `:q`
  
## 本番環境

- `sh build/build-production.sh`
