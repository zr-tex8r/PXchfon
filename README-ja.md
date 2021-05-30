PXchfon パッケージバンドル
==========================

LaTeX： pLaTeX／upLateX における日本語フォント設定

pLaTeX / upLaTeX の文書の標準のフォント（明朝・ゴシック）をユーザ指定の
ものに置き換える。dvipdfmx 専用である。他のフォント追加パッケージと
異なり、追加するフォントを LaTeX 文書中で指定するので、一度パッケージ
をインストールするだけで、任意の日本語フォント（ただし等幅に限る）を
使うことができる。欧文部分を同じ日本語フォントで置き換えることも可能で
ある。UTF / OTF パッケージにも対応している。

0.5 版での拡張で、pTeX において広く行われているフォント設定(IPA フォント
の使用等)をパッケージオプション一つで行う機能を追加した。この機能は元々、
別の PXjafont パッケージとして提供されていたものである。

### 前提環境

  * フォーマット： LaTeX
  * エンジン： pTeX、upTeX
  * DVIウェア： dvipdfmx
  * 依存パッケージ：
      - atbegshi パッケージ(`everypage` オプション使用時)
      - pxufont パッケージ(`unicode` オプション使用時)

### インストール

#### 和文のみを置き換えればよい場合

つまり、常に `noalphabet` オプション付きで用いる場合。この場合は以下の
設定だけで済む。

  - TDS 1.1 に従ったシステムでは、次のファイルを移動する。
      * `*.sty` → $TEXMF/tex/platex/pxchfon/

  - もっと簡単に、TeX システムのディレクトリには手を加えずに、単に
    文書ファイルと同じディレクトリに pxchfon.sty を置くだけでも使える。

#### 欧文部分の置き換えも利用したい場合

つまり、`noalphabet` なしでも用いたい場合。この場合は上に加えて以下の
設定を行う。

  * TDS 1.1 に従ったシステムでは、各ファイルを次の場所に移動する。
      - `tfm/*.tfm`  → $TEXMF/fonts/tfm/public/pxchfon/
      - `vf/*.vf`    → $TEXMF/fonts/vf/public/pxchfon/
      - `PXcjk0.sfd` → $TEXMF/fonts/sfd/pxchfon/
      - `*.def`      → $TEXMF/tex/platex/pxchfon/

### ライセンス

MITライセンスの下で配布される。

更新履歴
--------

  * Version 1.9  ‹2021/05/30›
      - 中国語・韓国語の多ウェイト設定に対応。
      - マップファイル読込用の `use` オプションを新設。
  * Version 1.8  ‹2021/02/22›
      - (試験的) `sourcehan!` 等のプリセットを追加。
  * Version 1.7e ‹2020/10/04›
      - バグ修正。
  * Version 1.7d ‹2020/09/26›
      - LaTeX カーネル 2020/10/01 版への対応。
  * Version 1.7c ‹2020/04/25›
      - 新 NFSS のための微修正。
  * Version 1.7b ‹2020/02/01›
      - '\textdiruni' を頑強にする。
  * Version 1.7a ‹2019/11/22›
      - バグ修正。
  * Version 1.7  ‹2019/11/19›
      - ユーザレベルの追加プリセットに対応。
  * Version 1.6a ‹2019/11/18›
      - `\(text)diruni` を PDF 文字列で通るようにする。
      - (試験的) PXchfon-extras の追加プリセットに対応。
  * Version 1.6  ‹2019/10/07›
      - プリセット `haranoaji` を追加。
  * Version 1.5a ‹2019/07/10›
      - バグ修正。
  * Version 1.5  ‹2019/05/15›
      - TL2017 用の暫定設定である `unicode*` オプションを非推奨とする。
      - `\asUTF` 命令を非推奨とする。
      - 欧文置換用の VF を刷新した。TS1 エンコーディングをサポート。
      - Unicode 直接モードでは非埋込のフォントに対して警告を出す。
  * Version 1.4a ‹2019/03/24›
      - 非置換のフォントに対して不具合が起こりうる設定を使う場合、
        非置換のフォントがあると警告を出す。
  * Version 1.4  ‹2019/03/24›
      - プリセット `sourcehan-jp`、`noto-jp` を追加。  
        （Source Han・Noto CJK の地域別サブセット版を使用）
      - 欧文フォント置換が T1 エンコーディングに（暫定的に）対応。
      - 欧文フォント置換の不具合の修正。
  * Version 1.3a ‹2019/03/20›
      - 1.3 版の追加機能の大幅な改修。Unicode 直接モードの `expert` が
        pTeX でも使用可能になった。
  * Version 1.3  ‹2019/02/03›
      - Unicode 直接モードにおいて japanese-otf の `expert` 指定の主要な
        機能（横組・縦組用仮名字形、ルビ用字形）に対応した。
      - GID 指定入力（`glyphid` オプションおよび `\gid` 命令）。
  * Version 1.2b ‹2019/01/21›
      - 「じゅん101」のファイル名の誤りを修正。
  * Version 1.2a ‹2018/03/17›
      - プリセット `ume` を追加。
      - プリセット `hiragino` を `hiragino-pro` の別名にする。
      - バグ修正。
  * Version 1.2  ‹2018/03/15›
      - `sourcehan(-otc)`/`noto(-otc)` について、暫定的に `+` 付と同じ動作
        にしていたが、`unicode` を既定にする動作に改める。
  * Version 1.1b ‹2017/10/04›
      - バグ修正。
  * Version 1.1a ‹2017/09/09›
      - オプション `unicode(*)-fwid` を追加。
      - (試験的)“legacycode”関連オプションを追加。
  * Version 1.1  ‹2017/07/05›
      - マップ行生成のロジックを大幅に改修した。
      - オプション `(no)strictcsi` を追加。
      - (暫定的) プリセット `sourcehan(-otc)+`、`noto(-otc)+` を追加。
  * Version 1.0c ‹2017/07/04›
      - バグ修正。
  * Version 1.0b ‹2017/06/29›
      - バグ修正。
  * Version 1.0a ‹2017/06/19›
      - ドライバオプションを新設した。
      - '(no)dumpmap'、'(no)dumpmaptl' オプションを新設した。
      - オプション 'prefer2004jis' の別名として 'jis2004' を追加した。
      - (暫定的) プリセット `yu-win10+` を追加。
      - バグ修正。
  * Version 1.0  ‹2017/05/31›
      - 非推奨のプリセットに対してエラーを出す。
      - pxjafont パッケージを非推奨とする。
      - `directunicode*` については OTF パッケージの読込を不要とした。
      - オプション `unicode(*)` を追加。  
        ※新しい dvipdfmx の「OpenType 属性指定」機能を利用したもの。
      - プリセット `sourcehan(-otc)`、`noto(-otc)` を追加。
  * Version 0.9  ‹2017/04/08›
      - オプション `directunicode*` を追加。
      - 非推奨のプリセットに対して警告を出す。
  * Version 0.8  ‹2017/01/13›
      - これまで暫定的に、`prefer2004jis` の効力を upTeX の OTF パッケージ
        のフォントにも及ぼしていたが、OTF パッケージの `jis2004` オプション
        が upTeX にも対応したため、この措置を取りやめ、本来の仕様通り、
        `prefer2004jis` は標準和文フォントだけを対象とした。
      - プリセット `moga-mobo` / `moga-maruberi` の定義の誤りを修正。
      - プリセット `moga-mobo-ex` を追加。
      - 単純マップファイルプリセット機能(`*NAME`)を追加。
  * Version 0.7h ‹2015/10/14›
      - バグ修正(\usefontmapline/file など)。
  * Version 0.7g ‹2015/09/30›
      - プリセット `hiragino-elcapitan-*`、`yu-win10` を追加。
  * Version 0.7f ‹2015/08/04›
      - `\diruni` / `\textdiruni` を追加。
  * Version 0.7e ‹2015/05/07›
      - マップファイルプリセット機能を追加。
      - `\usefontmapfile` / `\usefontmapline` を追加。
      - この版までの「試験的」機能を正式な機能とする。
  * Version 0.7d ‹2013/06/16›
      - 非埋込の明示指定をサポート。
  * Version 0.7c ‹2013/06/16›
      - OTF パッケージおよび upTeX 標準の中国語・韓国語フォントをサポート
        した。
  * Version 0.7b ‹2013/06/05›
      - upTeX + OTF パッケージの時の `\UTF`/`\CID` 入力に対するフォント
        を置換の対象に含めた。
  * Version 0.7a ‹2013/05/18›
      - バグ修正。
  * Version 0.7  ‹2013/05/08›
      - `(no)directunicode` を縦書きに対応。
      - `relfont` オプションを追加。
  * Version 0.6c ‹2013/04/20›
      - `(no)directunicode` オプションを追加。
  * Version 0.6b ‹2013/04/20›
      - `(no)oneweight` オプションを追加。
      - 非 CID フォントに関する `prefer2004jis` の実現方法を変更。
        2000JIS と 2004JIS の TFM で別の実フォントがマップされる。
      - 3 つのパッケージレベル命令 `\JaFontReplacementFor`,
        `\JaFontReplacementHook`, `\JaFontUserDefinedMap` を追加。
  * Version 0.6a ‹2013/04/07›
      - プリセットの設定を全面的に見直し。
      - OTF パッケージの `jis2004` オプション設定時に使用されるフォント
        群に対応させた。
      - OTF パッケージで極太ゴシックの CID 版と Unicode 版のフォント
        に対応させた。
  * Version 0.6  ‹2013/03/17›
      - `prefer2004jis` を pTeX 標準フォントにも有効にした。
  * Version 0.5  ‹2010/05/12›
      - PXfontspec パッケージのフォントへの対応を追加。
      - PXjafont パッケージの機能を組み入れた。
      - `[no]prefer2004jis` オプションを追加。
      - 欧文のマップ指定について v0.4 で混入したバグを修正。
      - `[no]everypage` オプションを追加。
  * Version 0.4a ‹2010/04/12›
      - 縦書きの文書クラスで必ずエラーになるというバグを修正。
  * Version 0.4  ‹2009/12/20›
      - なぜか `\setmarugothicfont` の説明が抜けてたので補った。
      - `\[no]usecmapforalphabet` を実験的に追加。
  * Version 0.3a ‹2009/11/23›
      - README 中に掲げた ttfonts.map の記述の間違いを訂正。
  * Version 0.3  ‹2009/07/13›
      - OTF パッケージの多ウェイト機能(deluxe オプション)に対応。
      - UTF パッケージへの対応が全く機能していなかったのを修正。
      - 明朝だけ指定した場合の欧文の取り扱いの問題を解決。
  * Version 0.2a ‹2009/05/31›
      - `noalphabet` 指定時には PXcjk0.sfd を読む必要はなかったので、説明を訂正
        した。
  * Version 0.2  ‹2009/03/29]
      - 最初の公開版。

--------------------
Takayuki YATO (aka. "ZR")  
https://github.com/zr-tex8r
