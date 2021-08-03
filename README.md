# TeXLive 環境

* DockerでTex環境を構築
* TexLive 2020以降で日本語の既定フォントとして原ノ味フォントが組み込まれたので対応

## ビルド方法

* `docker build -t programan/texlive:2021 .`

## コンパイル方法

### ドキュメントのソースファイルをコンパイルしてPDFを作成

* `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2021 uplatex -shell-escape "<document_name>"`
* `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2021 dvipdfmx "<document_name>"`


