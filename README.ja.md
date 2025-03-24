# Spring Boot with PostgreSQL 開発コンテナ

[![🇯🇵 日本語](https://img.shields.io/badge/%F0%9F%87%AF%F0%9F%87%B5-日本語-white)](./README.ja.md) [![🇺🇸 English](https://img.shields.io/badge/%F0%9F%87%BA%F0%9F%87%B8-English-white)](./README.md)

devcontainer構成を使用したSpring BootとPostgreSQLの開発用テンプレートリポジトリです。Spring BootとPostgreSQLを使用したJavaバックエンド開発のための、事前設定されたツール、依存関係、データベースセットアップを備えた、すぐに使える開発環境です。

## 特徴

- **完全なJava開発環境**: Amazon Corretto Java 21 と Gradle 8.13
- **PostgreSQLデータベース**: プライマリとレプリカのセットアップを持つPostgreSQL 15.8
- **pgAdmin**: 事前設定されたWebベースのPostgreSQL管理ツール
- **VS Code拡張機能**: Java、Spring Boot、Docker、その他の重要な開発拡張機能
- **一貫した環境**: すべての開発者が同じツールと依存関係を使用することを保証

## アーキテクチャ

このテンプレートは、複数のコンテナ設定を提供します：

1. **Javaアプリケーションコンテナ**: Spring Boot開発用
2. **PostgreSQLプライマリ**: メインデータベースサーバー
3. **PostgreSQLレプリカ**: スケーリングまたはレプリケーションテスト用の読み取りレプリカ
4. **pgAdmin**: http://localhost:5050 でアクセス可能なデータベース管理UI

## 前提条件

- [Docker](https://www.docker.com/products/docker-desktop/)
- [VS Code](https://code.visualstudio.com/)
- VS Code用の[Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)拡張機能

## 始め方

### 1. このテンプレートからリポジトリを作成する

テンプレートを使用するには2つの方法があります：

**オプションA: GitHubの「Use this template」機能を使用する**
1. このリポジトリの上部にある「Use this template」ボタンをクリックします
2. 新しいリポジトリに名前を付けます
3. パブリックまたはプライベートにするかを選択します
4. 「Create repository from template」をクリックします

**オプションB: クローンして再初期化する**
```bash
# テンプレートリポジトリをクローン
git clone https://github.com/yourusername/devcontainer-spring-boot-with-postgresql.git my-new-project
cd my-new-project
# 既存のgit履歴を削除して新たに開始
rm -rf .git
git init
git add .
git commit -m "テンプレートからの初期コミット"
```

### 2. 新しいプロジェクトをクローンする

上記のオプションAを使用した場合：
```bash
git clone https://github.com/yourusername/your-new-repo-name.git
cd your-new-repo-name
```

### 3. 設定を変更する

1. `.devcontainer/docker-compose.yml`ファイルでパスワードを更新します：
   - `<your-password-here>`をPostgreSQLとpgAdmin両方の安全なパスワードに置き換えます

2. `.devcontainer/devcontainer.json`でプロジェクト名をカスタマイズします（オプション）

3. 必要に応じてDocker設定を調整します：
   - Java環境用の`.devcontainer/Dockerfile`
   - PostgreSQL設定用の`.devcontainer/DockerfilePostgreSQL`

### 4. VS Codeで開く

```bash
code .
```

### 5. 開発コンテナを起動する

1. VS Codeの左下隅にある緑色のボタンをクリックします
2. メニューから「Reopen in Container」を選択します

VS Codeは開発コンテナをビルドし、その中でプロジェクトを開きます。初回実行時には数分かかることがあります。

## 環境の使用方法

### データベースへのアクセス

- PostgreSQLプライマリ: `jdbc:postgresql://db_primary:5432/postgres`
- PostgreSQLレプリカ: `jdbc:postgresql://db_replica:5432/postgres`
- ユーザー名: `root`（docker-compose.ymlで定義）
- パスワード: 設定したパスワード

### pgAdminの使用

1. ブラウザからhttp://localhost:5050でpgAdminにアクセスします
2. 以下を使用してログインします：
   - Eメール: `sample@example.com`（docker-compose.ymlで定義）
   - パスワード: 設定したパスワード

### Spring Boot開発

1. 新しいSpring Bootプロジェクトを作成します：
   - VS CodeのSpring Initializr拡張機能を使用
   - またはコマンドラインでSpring CLIを使用
   
2. プロジェクトにPostgreSQL依存関係を追加します：
   ```gradle
   dependencies {
       implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
       implementation 'org.postgresql:postgresql'
       // その他の依存関係
   }
   ```

3. `application.properties`または`application.yml`でデータベース接続を設定します：
   ```properties
   spring.datasource.url=jdbc:postgresql://db_primary:5432/postgres
   spring.datasource.username=root
   spring.datasource.password=your-password-here
   spring.jpa.hibernate.ddl-auto=update
   spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
   ```

## トラブルシューティング

- **コンテナのビルドに失敗する**: Dockerが十分なリソースで実行されていることを確認してください
- **データベース接続の問題**: docker-compose.ymlのパスワードがアプリケーション設定と一致することを確認してください
- **Javaバージョンの問題**: DockerfileのJavaバージョンがプロジェクト要件と一致することを確認してください

## 貢献

このテンプレートを改善するための貢献は歓迎します！プルリクエストを提出するか、イシューを開いてください。

## ライセンス

このテンプレートはMITライセンスの下で利用可能です。詳細はLICENSEファイルを参照してください。
