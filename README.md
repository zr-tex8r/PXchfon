PXchfon Package
===============

LaTeX: Japanese font setup for pLaTeX and upLaTeX

This package enables users to declare in their document which physical
fonts should be used for the standard Japanese (logical) fonts of pLaTeX
and upLaTeX. Font setup is realized by changing the font mapping of
dvipdfmx, and thus users can use any (monospaced) physical fonts they
like, once they properly install this package, without creating helper
files for each new fonts. This package also supports setup for the fonts
used in the japanese-otf package.

### SYSTEM REQUIREMENTS

  - TeX format: pLaTeX / upLaTeX.
  - DVIware: dvipdfmx.
  - Prerequisite packages: atbegshi.

### INSTALLATION

Move the files as follows (in a system compliant to TDS 1.1):

  - `*.sty`      → $TEXMF/tex/platex/pxchfon/
  - `*.tfm`      → $TEXMF/fonts/tfm/public/pxchfon/
  - `*.vf`       → $TEXMF/fonts/vf/public/pxchfon/
  - `pxcjk0.sfd` → $TEXMF/fonts/sfd/pxchfon/
  - `*.def`      → $TEXMF/tex/platex/pxchfon/

And rehash your TEXMF trees if necessary.

### LICENSE

This package is distributed under the MIT License.

Revision History
----------------

  * Version 0.7h [2015/10/09]
      - Bug fix.
  * Version 0.7g [2015/09/30]
      - Presets `hiragino-elcapitan-*` and `yu-win10`.
  * Version 0.7f [2015/08/04]
      - `\diruni` and `\textdiruni`.
  * Version 0.7e [2015/05/07]
      - The map file preset feature.
      - `\usefontmapfile` and `\usefontmapline`.
  * Version 0.7d [2013/06/16]
      - Explicit designation of non-embedding.
  * Version 0.7c [2013/06/16]
      - Support for Chinese and Korean fonts.
  * Version 0.7b [2013/06/05]
      - Support for the combination of upTeX + japanese-otf.
  * Version 0.7a [2013/05/18]
      - Bug fix.
  * Version 0.7  [2013/05/08]
      - `(no)directunicode` in vertical writing.
      - `relfont` option.
  * Version 0.6c [2013/04/20]
      - `(no)directunicode` option.
  * Version 0.6b [2013/04/20]
      - `(no)oneweight` option.
      - Support for `prefer2004jis` in using some non-CID fonts.
      - Package level commands `\JaFontReplacementFor`,
        `\JaFontReplacementHook` and `\JaFontUserDefinedMap`.
  * Version 0.6a [2013/04/07]
      - Complete revision of the preset settings.
      - Support for `jis2004` version of the japanese-otf font set.
      - Support for extra-bold  weight in the japanese-otf font set.
  * Version 0.6  [2013/03/17]
      - `prefer2004jis` working on pTeX.
  * Version 0.5  [2010/05/12]
  * Version 0.4a [2010/04/12]
  * Version 0.4  [2009/12/20]
  * Version 0.3a [2009/11/23]
  * Version 0.3  [2009/07/13]
  * Version 0.2a [2009/05/31]
  * Version 0.2  [2009/03/29]

--------------------
Takayuki YATO (aka. "ZR")  
http://zrbabbler.sp.land.to/
