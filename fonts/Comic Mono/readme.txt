Comic Mono
A legible monospace font… the very typeface you’ve been trained to recognize since childhood. This font is a fork of Shannon Miwa’s Comic Shanns (version 1).

Download
ComicMono.ttf
ComicMono-Bold.ttf
Differences from Comic Shanns
All glyphs have been adjusted to have exactly the same width (using code based on monospacifier).
The glyph metrics have been adjusted to make it display better alongside system font, based on Cousine’s metrics.
The name is changed to Comic Mono.
A bold version of the font is generated using FontForge’s Embolden operation.
I have no font creation skills; I’m just a software developer. This font family is created by patching the original font, Comic Shanns (v1), using a Python script, generate.py.

What does it look like?
#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
Generates the Comic Mono font files based on Comic Shanns font.

Required files:
- vendor/comic-shanns.otf
- vendor/Cousine-Regular.ttf

Based on:
- monospacifier: https://github.com/cpitclaudel/monospacifier/blob/master/monospacifier.py
- YosemiteAndElCapitanSystemFontPatcher: https://github.com/dtinth/YosemiteAndElCapitanSystemFontPatcher/blob/master/bin/patch
"""

import os
import re
import sys

reload(sys)
sys.setdefaultencoding('UTF8')

import fontforge
import psMat
import unicodedata

def height(font):
    return float(font.capHeight)

def adjust_height(source, template, scale):
    source.selection.all()
    source.transform(psMat.scale(height(template) / height(source)))
    for attr in ['ascent', 'descent',
                'hhea_ascent', 'hhea_ascent_add',
                'hhea_linegap',
                'hhea_descent', 'hhea_descent_add',
                'os2_winascent', 'os2_winascent_add',
                'os2_windescent', 'os2_windescent_add',
                'os2_typoascent', 'os2_typoascent_add',
                'os2_typodescent', 'os2_typodescent_add',
                ]:
        setattr(source, attr, getattr(template, attr))
    source.transform(psMat.scale(scale))

font = fontforge.open('vendor/comic-shanns.otf')
ref = fontforge.open('vendor/Cousine-Regular.ttf')
for g in font.glyphs():
    uni = g.unicode
    category = unicodedata.category(unichr(uni)) if 0 <= uni <= sys.maxunicode else None
    if g.width > 0 and category not in ['Mn', 'Mc', 'Me']:
        target_width = 510
        if g.width != target_width:
            delta = target_width - g.width
            g.left_side_bearing += delta / 2
            g.right_side_bearing += delta - g.left_side_bearing
            g.width = target_width

font.familyname = 'Comic Mono'
font.version = '0.1.1'
font.comment = 'https://github.com/dtinth/comic-mono-font'
font.copyright = 'https://github.com/dtinth/comic-mono-font/blob/master/LICENSE'

adjust_height(font, ref, 0.875)
font.sfnt_names = [] # Get rid of 'Prefered Name' etc.
font.fontname = 'ComicMono'
font.fullname = 'Comic Mono'
font.generate('ComicMono.ttf')

font.selection.all()
font.fontname = 'ComicMono-Bold'
font.fullname = 'Comic Mono Bold'
font.weight = 'Bold'
font.changeWeight(32, "LCG", 0, 0, "squish")
font.generate('ComicMono-Bold.ttf')
CDN
You can use this font in your web pages by including the stylesheet. CDN is provided by jsDelivr.

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/comic-mono@0.0.1/index.css">
npm Package
The contents of this package is also published to npm, although the font files are not optimized. See fontsource package (below) for a better option.

Packages published by third parties
Fontsource: @fontsource/comic-mono (thanks @DecliningLotus)
Arch Linux AUR: ttf-comic-mono-git (maintained by DBourgeoisat)
License
It is licensed under the MIT License.

