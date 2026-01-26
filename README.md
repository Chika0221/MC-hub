# SwitchController

キーボード関連のユーティリティ、実験、デモ（レイアウトプレビュー、キー配列ヘルパー、デバイステストなど）をまとめる Flutter アプリです。本 README では概要、セットアップ、開発・テスト手順を日本語で整理しています。

## 目次
1. [概要](#概要)
2. [前提条件](#前提条件)
3. [プロジェクト構成](#プロジェクト構成)
4. [セットアップ](#セットアップ)
5. [実行方法](#実行方法)
6. [テスト](#テスト)
7. [コード品質](#コード品質)
8. [環境設定](#環境設定)
9. [トラブルシューティング](#トラブルシューティング)
10. [リソース](#リソース)

## 概要
- **目的:** Flutter でキーボード関連のツールやデモを素早く試せる「ハブ」を提供する。
- **現在の範囲:** 初期構成の Flutter アプリ。UI 実装や外部サービス連携、実験用機能の追加に適した状態。
- **技術スタック:** Flutter (Dart), Material 3 デフォルト。

## 前提条件
- Flutter SDK をインストールし `PATH` に通す。
- Dart SDK（Flutter に同梱）。
- Android/iOS 開発ツール（Android Studio, Xcode など）を用途に応じて。
- 実機またはエミュレータ/シミュレータ。

バージョン確認:
```bash
flutter --version
dart --version
```

## プロジェクト構成
- `lib/` — アプリケーション本体（ウィジェット、画面、サービスなど）。
- `test/` — ユニットテスト・ウィジェットテスト。
- `assets/` — 画像・フォント等の静的アセット（`pubspec.yaml` に登録すること）。
- `android/`, `ios/`, `web/`, `macos/`, `windows/`, `linux/` — 各プラットフォームのビルド足場。

## セットアップ
1. 依存関係を取得:
   ```bash
   flutter pub get
   ```
2. （任意）デスクトップ/Web ターゲットを有効化:
   ```bash
   flutter config --enable-windows-desktop
   flutter config --enable-macos-desktop
   flutter config --enable-linux-desktop
   flutter config --enable-web
   ```
3. 環境ごとの値を導入する場合は `.env` 等の設定ファイルを用意し、VCS から除外する（[環境設定](#環境設定) を参照）。

## 実行方法
- 接続済みデバイス/エミュレータで実行:
  ```bash
  flutter run
  ```
- デバイスを選択:
  ```bash
  flutter devices
  flutter run -d <device_id>
  ```
- Web（有効化済みの場合）:
  ```bash
  flutter run -d chrome
  ```

## テスト
- すべてのテスト:
  ```bash
  flutter test
  ```
- 単一ファイルのテスト:
  ```bash
  flutter test test/<file_name>_test.dart
  ```

## コード品質
- フォーマット:
  ```bash
  dart format .
  ```
- Lint（`analysis_options.yaml` が設定されている場合）:
  ```bash
  dart analyze
  ```

## 環境設定
- デフォルトでは Flutter 標準設定を利用。
- 機密情報や環境依存値を追加する場合:
  - `--dart-define` を利用: `flutter run --dart-define=API_BASE_URL=https://...`
  - VCS で無視される生成ファイル（例: `.env`, `lib/env.dart` のテンプレートを gitignore に含める）を用いる。

## トラブルシューティング
- **SDK が見つからない:** `flutter` が `PATH` にあるか確認し、シェルを再起動。
- **エミュレータが表示されない:** Android Studio や Xcode でエミュレータ/シミュレータを起動するか、USB デバッグを有効にした実機を接続。
- **依存関係エラー:** `flutter clean` 実行後に `flutter pub get`。
- **プラットフォームビルドエラー:** Android SDK や Xcode Command Line Tools が最新か確認。

## リソース
- Flutter 公式ドキュメント: https://docs.flutter.dev/
- Cookbook サンプル: https://docs.flutter.dev/cookbook
- 初めての Flutter アプリ: https://docs.flutter.dev/get-started/codelab