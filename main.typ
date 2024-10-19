#import "@preview/touying:0.5.2": *
#import themes.university: *
#import "@preview/physica:0.9.3": *

#let typst-color = rgb("#239DAD")
#let tsinghua-color = rgb(106,8,116)

#set text(font: ("Linux Libertine", "Source Han Serif"), lang: "zh", region: "cn")
#show heading.where(level: 1): set heading(numbering: "1.")
#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [typst: Compose reports faster],
    subtitle: [快速上手的报告排版教程],
    authors: "杨哲涵",
    date: datetime(year: 2024, month: 10, day: 7),
    institution: [清华大学工物科协],
    logo: none,
  ),
  config-common(
    handout: false
  ),
  config-colors(
    primary: tsinghua-color,
    secondary: rgb("#6908749c"),
    tertiary: typst-color,
    neutral-lightest: rgb("#ffffff"),
    neutral-darkest: rgb("#434343"),
  ),
  config-methods(cover: utils.semi-transparent-cover),
  footer-a: self => self.info.subtitle,
)
#set text(weight: "medium")
#show link: it => underline(text(fill: typst-color, it))
#title-slide()
#set raw(lang: "typ")
#show raw.where(block: true): set text(size: 0.75em)
#show raw.where(block: false): set text(fill: tsinghua-color)
#show raw.where(block: false): box.with(
  fill: luma(94.37%),
  inset: (x: .2em, y: 0em),
  outset: (x: 0em, y: .2em),
  radius: .2em,
)
#set underline(offset: .26em)
#set par(leading: 1em)
#set text(size: 22pt)

#let Typst = text(fill: typst-color, weight: "bold", "Typst")
#let TeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(width: 1.7em, {
    [T]
    place(top, dx: 0.56em, dy: 0.22em)[E]
    place(top, dx: 1.1em)[X]
  })
}
#let LaTeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(width: 2.55em, {
    [L]
    place(top, dx: 0.3em, text(size: 0.7em)[A])
    place(top, dx: 0.7em)[#TeX]
  })
}

== 目录 <touying:hidden>
#align(horizon, components.adaptive-columns(outline(title: none, indent: 1em, depth: 1)))
= 为什么是Typst
== 排版软件应当具有的要求
#slide()[
/ 可复现:
  - 在安装了相同软件的不同设备上，可以复现相同的排版效果。
  - 可以用源代码管理工具（如Git）进行版本控制。
  / 反面例子: Microsoft Word，WPS
#pause
/ 擅长排版公式: 撰写科技文档，数学公式是必不可少的。
  $ braket(x, n)=1/sqrt(n!)braket(x, (a^dagger)^n, 0)=1/sqrt(2^n n!) ((m omega)/(pi hbar))^(1/4) (sqrt((m omega)/hbar)x+sqrt(hbar/(m omega))dv(, x))^n e^(-(m omega)/(2hbar)x^2) $
  / 反面例子: Microsoft Word, Microsoft PowerPoint
]
#slide()[
/ 标记与输出结构化:
  - 自动为标题，列表，图表编号，并且方便地进行索引。
  - 输出结构化的目录，可以在阅读器中快速跳转。
#pause
/ 表现力强: 满足各种各样的排版需求：
  #grid(columns: 3, column-gutter: 5em, [
    - 论文
    - 报告
    - 书籍
  ], [
    - 海报
    - 幻灯片
    - 简历
  ], [
    - 代码
    - #link("https://github.com/thudep/award-cert-printer")[奖状]
  ])
  / 反面例子: Microsoft Word, Microsoft PowerPoint
]
#slide()[
/ 格式分离: 同样的内容，通过不同的格式设置，可以呈现不同的效果。
  ```
  // 格式
  #let typst-color = rgb("#239DAD")
  #let tsinghua-color = rgb(106,8,116)
  #show link: it => underline(text(fill: typst-color, it))
  #show raw.where(block: false): set text(fill: tsinghua-color)
  // 内容
  点击#link("https://typst.app/docs/reference/model/link/")[typst link reference]以了解`link`函数
  ```
  点击#link("https://typst.app/docs/reference/model/link/")[typst link reference]以了解`link`函数。
#pause
/ 易于学习: 无需花费大量时间学习，即可上手。
  / 正面例子: #Typst
]
== Typst对比LaTeX
#slide()[
/ 工具链轻量: #Typst 在Arch Linux系统下打包大小为`33.35 MiB`，而texlive-basic包附加其他依赖的大小为`2587.68 MiB`。
#pause
/ 生态蓬勃: 勃勃生机，万物竞发。

  #grid(columns: 3, column-gutter: 1em, [2019年，两个德国大学生不满#LaTeX 的迟缓，他们决定从头开始，自己使用Rust编程语言开发一套排版软件。],image("pic/laurenz-2x.jpg", width: 4em), image("pic/martin-2x.jpg", width: 4em))

  作为对比，#TeX 的版本号采用收敛到 "圆周率" 的方式命名，每更新一次，就多取一位小数（例如我的xelatex版本为`3.141592653`）。因为开发者Donald E. Knuth认为他的软件已经完美无缺（事实上确实没有多少bug），不会再有功能更新。
]
#slide()[
/ 语法简洁: #Typst 的语法简洁易懂，可读性高。此外，#Typst 是图灵完备的，而#LaTeX 则是基于宏替换。
#pause
/ 不完善: #Typst 并非可以完全替代#LaTeX，也存在一些不便，例如我遇到过以下问题。
  - 不能直接插入`pdf`格式的图片，需要手动转为`svg`格式，参见#link("https://github.com/typst/typst/issues/145")[Issue \#145]
  - 首行缩进存在问题，参见#link("https://github.com/typst/typst/issues/311")[Issue \#311]
]
#slide()[
/ 不完善: #Typst 并非可以完全替代#LaTeX，也存在一些不便，例如我遇到过以下问题。
  - #strike[生成文档更大（一般是2倍以上），参见#link("https://github.com/typst/typst/discussions/404")[Why does typst generate much larger pdf than TeX? · typst/typst · Discussion #404]] 已在#link("https://typst.app/docs/changelog/0.12.0/")[0.12.0]修复
  - 缺乏好用的格式化工具，参见#link("https://github.com/typst/typst/issues/1772")[Issue \#1772]
  - 还未实现文字环绕图片，参见#link("https://github.com/typst/typst/discussions/1069")[How to wrap text around an image? · typst/typst · Discussion #1069]
]
= 快速上手
== 安装
#slide()[
  / VS Code方案: 安装VS Code编辑器后，搜索并安装插件`Tinymist Typst`，这之后，就可以在编辑器内愉快写作了，不需要安装其他工具。
#pause
  / 本地CLI方案: 如果想配合其他编辑器，通过命令行使用#Typst，可以安装其CLI工具，例如Windows下。
    ```sh
    winget install --id Typst.Typst
    ```
    #Typst 编译指令为
    ```sh
    typst compile --root <DIR> <INPUT_FILE>
    ```
#pause
  / 在线编辑方案: 使用#Typst 提供的#link("https://typst.app/")[Web App]，类似于#LaTeX 当中的 Overleaf。
]
== 语法概览
以下所有语法详见#link("https://typst.app/docs/reference/syntax/")[Syntax – Typst Documentation]。
#pause
/ 标记模式（Markup ）: 这是一篇#Typst 文档的默认格式，又称内容块，在标记模式下输入的文字会被视为要排版的内容，可使用语法糖。
  ```
  Hello, world! *Typst* is simple to write!
  ```
#pause
/ 注释（Comments）: 类似C/C++风格
  - `// 单行注释。`
  - `/* 多行注释。 */`
#pause
/ 公式模式（Math Mode）: 用`$ $`包裹
  ```
  $a^2+b^2=c^2$
  ```
#pause
/ 脚本模式: 以`#`标记，代表函数，变量，关键字等
  ```
  #let typst-color = rgb("#239DAD")
  ```
== 字体
#slide()[
- #Typst 本身不分发字体，而是使用本地计算机上已有的字体。
  
  例如在VS Code中打开终端，输入以下命令，可以得到系统中已安装的字体列表，这些字体都可被#Typst 使用。
  ```sh
  typst fonts
  ```
  如果显示未找到命令等情况，可能是因为没有安装CLI工具。
#pause
- 字体参数#link("https://typst.app/docs/reference/text/text/#parameters-font")[font]接受`str|array`，按优先级传入若干字体。
  ```
  #set text(font: ("Linux Libertine", "Source Han Serif"))
  ```
#pause
- 除此之外，语言和区域代码也会影响字体的选择以及图表编号的显示。
  ```
  #set text(font: ("Linux Libertine", "Source Han Serif"), lang: "zh", region: "cn")
  ```
]
== 设置元素大小
在#Typst 中，可以通过`size`参数设置元素的大小，例如
#align(center)[
#grid(columns: 2, column-gutter: 1em,
[
```
#set text(size: 28pt)
very #text(1.5em)[big] text and #text(size: .5em)[small] text
```
],
[
#set text(size: 28pt)
very #text(1.5em)[big] text and #text(size: .5em)[small] text
])
]
/ 注意: `em`是相对单位，`pt`是绝对单位。
#pause

此外，还可以使用的绝对单位有
- `mm`
- `cm`
- `in`
== 语法糖标记
#text(size: 0.9em)[
#columns(2)[
/ 标题:
  ```
  = 这是一级标题
  == 标题可以含有数学公式
  === $beta^-$衰变
  ```
#pause
/ 无序列表（Bullet List）:
  ```
  - 清华大学
  - 北京大学
  ```
#pause
/ 有序列表(Numbered List):
  ```
  + Preparations
  + Analysis
  + Conclusions
  ```
#pause
/ 术语列表（Term List）:
  ```
  / Ligature: A merged glyph.
  / Kerning: A spacing adjustment between two adjacent letters.
  ```
#pause
/ 斜体（Emphasis）:
  ```
  This is _emphasized._ and this is #emph[too.]
  ```
#pause
/ 粗体（Strong）:
  ```
  This is **strong.** and this is #strong[too.]
  ```
#pause
/ 智能引号（Smart Quotes）: 用英文引号包裹内容，根据国家和区域代码决定显示方式。
  ```
  #set text(lang: "en")
  "Hello, world!"
  #set text(lang: "de")
  "Wir schaffen das!"
  ```
#pause
/ 纯文本（Raw Text / Code）: #raw("`")或#raw("```")，与Markdown相同。
]
]
== 插图
  #grid(columns: (1fr,1fr), column-gutter: 1em, [
  插入单张图片很简单
  ```
  #figure(image("4.svg", height: 60%), caption: "中微子的三种味") <a-label>
  @a-label 展示了基本粒子。
  ```
  ], [
    #image("pic/1.png",height: 40%)
  ])
  #grid(columns: (1fr,1fr), column-gutter: 1em, [
  多张图片的排版借助于`grid`函数
  ```
  #grid(columns: 2, column-gutter: 1em, figure(image("9.jpg",height: 70%), caption: "Super-K剖面"), figure(image("10.jpg", height: 80%), caption: "Super-K广角摄影"))
  ```
  ], [
    #image("pic/2.png",height: 40%)
  ])
== 表格
#figure(
table(columns: 3, 
  table.header(
    [Substance],
    [Subcritical °C],
    [Supercritical °C],
  ),
  [Hydrochloric Acid], [12.0], [92.1],
  [Sodium Myreth Sulfate],
  [16.6], [104],
  [Potassium Hydroxide], table.cell(colspan: 2)[24.7],
), caption: "表格示例")
```
#figure(
table(columns: 3, 
  table.header(
    [Substance], [Subcritical °C], [Supercritical °C],
  ),
  [Hydrochloric Acid], [12.0], [92.1],
  [Sodium Myreth Sulfate], [16.6], [104],
  [Potassium Hydroxide], table.cell(colspan: 2)[24.7],
), caption: "表格示例")

```
关于`figure`是否应该包含`table`以及`image`，参考#link("https://github.com/typst/typst/issues/1058")[Issue \#1058]
== 包管理
包是模板或库，通过精确指定名称及版本号引入，会被本地的#Typst 工具自动管理，按需下载。访问#link("https://typst.app/universe/")[Typst Universe]了解#Typst 社区生态。
```
#import "@preview/physica:0.9.3": *
```
#pause
- #link("https://typst.app/universe/package/physica")[physica – Typst Universe] 对标#LaTeX 中的physics，语法相近。
- #link("https://typst.app/universe/package/ctheorems")[ctheorems – Typst Universe] 定义定理证明环境。
- #link("https://github.com/OrangeX4/typst-cheq")[OrangeX4/typst-cheq] 漂亮的Markdown风格复选框
- #link("https://typst.app/universe/package/mitex")[mitex – Typst Universe] #LaTeX 公式转为#Typst 格式。
- #link("https://typst.app/universe/package/touying")[touying – Typst Universe] 本幻灯片用其制作，对标#LaTeX 中的beamer。
- #link("https://typst.app/universe/package/modern-cv")[modern-cv – Typst Universe] 简历模板
#pause
以上仅是一小部分，更多包有待自由探索！
== 参考文献
```
Super-K确定了太阳中微子振荡参数@fukuda_determination_2002 // 引用示例
#bibliography("main.bib", style: "american-physics-society", title: "参考文献") // 导入，设置引文格式与标题
#pause
```
/ 什么是bib文件:
  bib文件是一种通过格式化文本描述参考文献的文件规范，多种文献管理软件，例如Zotero都可以导出bib文件。
```bib
@article{fukuda_determination_2002,
  title        = {Determination of solar neutrino oscillation parameters using 1496 days of Super-Kamiokande I data},
  volume       = {539},
  doi          = {10.1016/S0370-2693(02)02090-7},
  pages        = {179--187},
  journaltitle = {Phys. Lett. B},
  author       = {Fukuda, S. and {others}},
  date         = {2002}
}
```
== 更精细的布局
/ 对齐（align）: #link("https://typst.app/docs/reference/layout/align/")[Align Function – Typst Documentation]
/ 垂直间距: #link("https://typst.app/docs/reference/layout/v/")[Spacing (V) Function – Typst Documentation]，适合制作封面等需要惊喜布局的地方
/ 水平间距: #link("https://typst.app/docs/reference/layout/h/")[Spacing (H) Function – Typst Documentation]，与前者类似
/ 多栏排版: #link("https://typst.app/docs/reference/layout/columns/")[Columns Function – Typst Documentation]，与`grid`不同，`grid`制定哪些内容填充到哪块区域，而`columns`根据剩余版面自动调整
== 排版例子
无论开始学#LaTeX 还是 #Typst，都是从抄别人的排版开始的
#pause
/ 考试小抄: #link("https://github.com/adamanteye/note/blob/master/%E9%87%8F%E5%AD%90%E5%8A%9B%E5%AD%A6/%E6%9C%9F%E6%9C%AB%E5%B0%8F%E6%8A%84/main.typ")[note/量子力学/期末小抄/main.typ at master · adamanteye/note]
  - 使用了`physica`包，展示了如何使用#Typst 书写复杂公式
  - 页面微雕技术
#pause
/ 幻灯片: #link("https://github.com/adamanteye/note/blob/master/%E4%B8%AD%E5%AD%90%E7%89%A9%E7%90%86%E5%AF%BC%E8%AE%BA/%E7%AC%AC%E4%BA%8C%E6%AC%A1%E5%A4%A7%E4%BD%9C%E4%B8%9A/main.typ")[note/中子物理导论/第二次大作业/main.typ at master · adamanteye/note]
  - 使用了`touying`包，展示了如何使用#Typst 制作简单幻灯片
  - 更多的动画需要`pinit`包，大家可自行探索
#pause
/ 另一个幻灯片: #link("https://github.com/thudep/typst-talk")[thudep/typst-talk: 2024年春typst讲座] 本幻灯片的代码
= 总结
== 相关资料
#slide()[
  / 阅读Typst博客: #link("https://typst.app/blog/")[Typst: Blog] 社区Roadmap发布与技术讨论
  / 查找文档: #link("https://typst.app/docs/reference/")[Reference – Typst Documentation] 附有详尽用例，善用页内搜索功能
  / 中文Typst文档（可能过时）: #link("https://typst-doc-cn.github.io/docs/")[概览 – Typst 中文文档]
  / 查找数学符号: #link("https://typst.app/docs/reference/symbols/sym/")[General Symbols – Typst Documentation]
  / 探索社区包: #link("https://typst.app/universe/")[Typst Universe]
  / 遇到问题怎么办: 使用Google搜索，关注StackExchange等高质量社区回答
  / 打字慢怎么办: 尝试Copilot等自动补全工具，发现灌水新途径
  / 想压缩插图: #link("https://github.com/funbox/optimizt")[funbox/optimizt: CLI image optimization tool] `nodejs` 图像压缩工具
]
== 参考与鸣谢
- #Typst 官方文档等，在此不再详细列举
- #link("https://stu.cs.tsinghua.edu.cn/~harry/latex-talk.pdf")[如何使用LaTeX排版论文]
- #link("https://github.com/OrangeX4/typst-talk")[OrangeX4/typst-talk: 并不复杂的 Typst 讲座 - Typst is Simple]
