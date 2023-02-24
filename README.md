# TeXLive 環境

* DockerでTex環境を構築
* TexLive 2020以降で日本語の既定フォントとして原ノ味フォントが組み込まれたので対応

## ビルド方法

* `docker build -t programan/texlive:2022 .`

## コンパイル方法

### LaTexドキュメントのソースファイルをコンパイルしてPDFを作成

#### uplatex

* `\documentclass[uplatex,dvipdfmx,12pt]{jsarticle}`
* Linux
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 uplatex -shell-escape "<document_name>"`
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 dvipdfmx "<document_name>"`
* Windows
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 uplatex -shell-escape "<document_name>"`
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 dvipdfmx "<doc2ument_name>"`2

#### platex

* `\documentclassjarticle}`
* Linux
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 platex "<document_name>"`
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 dvipdfmx "<document_name>"`
* Windows
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 uplatex -shell-escape "<document_name>"`
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 dvipdfmx "<doc2ument_name>"`2

#### xelatex

* `\documentclass[ja=standard,xelatex]{bxjsarticle}`
* Linux
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 xelatex "<document_name>"`
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 xdvipdfmx "document_name"`
* Windows
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 xelatex "<document_name>"`
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 xdvipdfmx "document_name"`

#### lualatex

* `\documentclass{ltjsarticle}`
* Linux
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 lualatex "<document_name>"`
* Windows
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 lualatex "<document_name>"`


### PlantUML

* Linux
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 plantuml "plantuml file"`
* Windows
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 plantuml "plantuml file"`

### Pandoc

* Linux
  * `docker run --rm -it --user $(id -u $USER):$(id -g $USER) -v ${PWD}:/workdir programan/texlive:2022 pandoc -s -o "output file name" --metadata pagetitle="pagetitle" "input file name"`
* Windows
  * `docker run --rm -it -v ${PWD}:/workdir programan/texlive:2022 pandoc -s -o "output file name" --metadata pagetitle="pagetitle" "input file name"`

