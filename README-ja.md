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

  - TeX 処理系： pLaTeX2e / upLaTeX2e
  - DVI ウェア： dvipdfmx
  - 前提パッケージ：
      * atbegshi パッケージ(`everypage` オプション使用時)

### 本ソフトウェアの作者のサイト

  - En toi Pythmeni tes TeXnopoleos ～電脳世界の奥底にて～  
    <http://zrbabbler.sp.land.to/>

  - 以下のページに一部機能の使用例を紹介した。  
    「PXchfon パッケージ」  
    <http://zrbabbler.sp.land.to/pxchfon.html>

### インストール

#### 和文のみを置き換えればよい場合

つまり、常に `noalphabet` オプション付きで用いる場合。この場合は以下の
設定だけで済む。

  - TDS 1.1 に従ったシステムでは、次のファイルを移動する。
      * `*.sty` → $TEXMF/tex/platex/pxchfon/

  - W32TeX を `C:\usr\local` にインストールした場合の例。
      * `*.sty` → `C:\usr\local\share\texmf-local\tex\platex\pxchfon`

  - もっと簡単に、TeX システムのディレクトリには手を加えずに、単に
    文書ファイルと同じディレクトリに pxchfon.sty を置くだけでも使える。

#### 欧文部分の置き換えも利用したい場合

つまり、`noalphabet` なしでも用いたい場合。この場合は上に加えて以下の
設定を行う。

  * TDS 1.1 に従ったシステムでは、各ファイルを次の場所に移動する。
      - `*.tfm`      → $TEXMF/fonts/tfm/public/pxchfon/
      - `*.vf`       → $TEXMF/fonts/vf/public/pxchfon/
      - `pxcjk0.sfd` → $TEXMF/fonts/sfd/pxchfon/
      - `*.def`      → $TEXMF/tex/platex/pxchfon/

  * W32TeX を C:\usr\local にインストールした場合の例。
      - `*.tfm`  → `C:\usr\local\share\texmf-local\fonts\tfm\public\pxchfon`
      - `*.vf`   → `C:\usr\local\share\texmf-local\fonts\vf\public\pxchfon`
      - `pxcjk0.sfd` → `C:\usr\local\share\texmf-local\fonts\sfd\pxchfon`
      - `*.def`  → `C:\usr\local\share\texmf-local\tex\platex\pxchfon`

### ライセンス

MIT ライセンス

更新履歴
--------

  * Version 0.7e [2015/05/07]
      - マップファイルプリセット機能を追加。
      - \usefontmapfile / \usefontmapline を追加。
  * Version 0.7d [2013/06/16]
      - 非埋込の明示指定をサポート。
  * Version 0.7c [2013/06/16]
      - (試験的) OTF パッケージおよび upTeX 標準の中国語・韓国語フォント
        をサポートした。
  * Version 0.7b [2013/06/05]
      - upTeX + OTF パッケージの時の `\UTF`/`\CID` 入力に対するフォント
        を置換の対象に含めた。
  * Version 0.7a [2013/05/18]
      - バグ修正。
  * Version 0.7  [2013/05/08]
      - (試験的) `(no)directunicode` を縦書きに対応。
      - `relfont` オプションを追加。
  * Version 0.6c [2013/04/20]
      - (試験的) `(no)directunicode` オプションを追加。
  * Version 0.6b [2013/04/20]
      - `(no)oneweight` オプションを追加。
      - 非 CID フォントに関する `prefer2004jis` の実現方法を変更。
        2000JIS と 2004JIS の TFM で別の実フォントがマップされる。
      - 3 つのパッケージレベル命令 `\JaFontReplacementFor`,
        `\JaFontReplacementHook`, `\JaFontUserDefinedMap` を追加。
  * Version 0.6a [2013/04/07]
      - プリセットの設定を全面的に見直し。
      - OTF パッケージの `jis2004` オプション設定時に使用されるフォント
        群に対応させた。
      - OTF パッケージで極太ゴシックの CID 版と Unicode 版のフォント
        に対応させた。
  * Version 0.6  [2013/03/17]
      - `prefer2004jis` を pTeX 標準フォントにも有効にした。
  * Version 0.5  [2010/05/12]
      - PXfontspec パッケージのフォントへの対応を追加。
      - PXjafont パッケージの機能を組み入れた。
      - `[no]prefer2004jis` オプションを追加。
      - 欧文のマップ指定について v0.4 で混入したバグを修正。
      - `[no]everypage` オプションを追加。
  * Version 0.4a [2010/04/12]
      - 縦書きの文書クラスで必ずエラーになるというバグを修正。
  * Version 0.4  [2009/12/20]
      - なぜか `\setmarugothicfont` の説明が抜けてたので補った。
      - `\[no]usecmapforalphabet` を実験的に追加。
  * Version 0.3a [2009/11/23]
      - README 中に掲げた ttfonts.map の記述の間違いを訂正。
  * Version 0.3  [2009/07/13]
      - OTF パッケージの多ウェイト機能(deluxe オプション)に対応。
      - UTF パッケージへの対応が全く機能していなかったのを修正。
      - 明朝だけ指定した場合の欧文の取り扱いの問題を解決。
  * Version 0.2a [2009/05/31]
      - `noalphabet` 指定時には PXcjk0.sfd を読む必要はなかったので、説明を訂正
        した。
  * Version 0.2  [2009/03/29]
      - 最初の公開版。

--------------------
Takayuki YATO (aka. "ZR")  
http://zrbabbler.sp.land.to/
