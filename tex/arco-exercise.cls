% -*- mode:latex -*-
%
% author: David Villa Alises <David.Villa@gmail.com>
%
% LaTeX2ε for class and package writers:
%   http://www.latex-project.org/guides/clsguide.pdf
%
% Initial template taken from:
%   http://stackoverflow.com/questions/581916/how-do-you-extend-article-document-class-in-latex


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arco-exercise}[2012/02/22 class for student exercises]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\PassOptionsToClass{a4paper, 11pt}{article}
\ProcessOptions\relax
\LoadClass{article}

\parskip=0.2cm
\reversemarginpar
\marginparwidth=3cm

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish]{babel}
\RequirePackage{times}

\RequirePackage[margin=3cm]{geometry}

\RequirePackage{graphicx}
\graphicspath{{/}{figures/}}

\RequirePackage{enumitem}
\setlist{topsep=0pt}

\RequirePackage{color}
\definecolor{gray25}{gray}{0.25}
\definecolor{uclm-light}{cmyk}{0,0.1,0.1,0}

\RequirePackage[%
  colorlinks=true,
  linkcolor=black,
  citecolor=blue,
  urlcolor=blue]{hyperref}

\RequirePackage[%
% colorgrid,
  texcoord]{eso-pic}

\RequirePackage{ifthen}
%\RequirePackage{transparent}
%\RequirePackage{amsmath}
%\RequirePackage{tocbibind}
%\RequirePackage{enumerate}
%\RequirePackage{sectsty}
%\RequirePackage{checkend}
%\RequirePackage{rotating}
%\RequirePackage[inline,marginclue,draft]{fixme}

\RequirePackage[sf,bf,compact,clearempty]{titlesec}

\newcommand{\UCLMbgcolor}[1]{\textcolor{uclm-light}{#1}}
\newcommand{\ifcolor}[1]{#1}
\newcommand{\UCLMbglogo}{%
  \ifcolor{%
    \begin{picture}(0,0)
      \put(-55,-820){
        \UCLMbgcolor{\includegraphics[width=1.1\textwidth]{%
            /usr/share/arco-tools/figures/uclm-logo-bw-mp.pdf}}}
    \end{picture}}}

%% -- Variables del estilo ------------------------------------
\gdef\@arcoTopic{<asignatura>}
\def\arcoTopic#1{\gdef\@arcoTopic{#1}}
\gdef\@arcoCourse{<curso>}
\def\arcoCourse#1{\gdef\@arcoCourse{#1}}

\newpagestyle{arcoStyle}[\scriptsize\sffamily]{
  \sethead{\textcolor{gray25}{\@arcoTopic}}{\UCLMbglogo}{\textcolor{gray25}{\@arcoCourse}}
  \setfoot{\textcolor{gray25}{\today}}{}{\textcolor{gray25}{\thepage/\pageref*{lastpage}}}
  \headrule
  \footrule
}
\pagestyle{arcoStyle}

\def\mymaketitle{%
  \null
  \normalfont
  \begin{center}
    \leavevmode
    {\sffamily \LARGE \@title\par}%
    \smallskip
    {\Large \@author\par}%
    \smallskip
    {\large \@date\par}%
  \end{center}%
  \null
}

\renewcommand\maketitle{%
  \let\footnotesize\small%
  \let\footnoterule\relax%

  \mymaketitle

  \thispagestyle{arcoStyle}

  \global\let\maketitle\relax

  \global\let\@thanks\@empty
  \global\let\thanks\relax

  \global\let\@author\@empty
  \global\let\author\relax

  \global\let\@date\@empty
  \global\let\date\relax

  \global\let\@title\@empty
  \global\let\title\relax

  \global\let\and\relax
}

\endinput
