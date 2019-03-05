% -*- mode:latex -*-
%
% author: David Villa Alises <David.Villa@gmail.com>
%
% LaTeX2ε for class and package writers:
%   http://www.latex-project.org/guides/clsguide.pdf
%
% Initial template taken from:
%   http://stackoverflow.com/questions/581916/how-do-you-extend-article-document-class-in-latex

\RequirePackage{arco-internal}

%% -- Variables de la clase ------------------------------------
\gdef \docTopic   {FIXME: Set the ``topic'' with \texcmd{def}\texcmd{docTopic}}
\gdef \docCourse  {FIXME: Set the ``course'' with \texcmd{def}\texcmd{docCourse}}


% \gdef\@docTopic{\texcmd{docTopic}}
% \gdef\@docTopic{<asignatura>}
% \def\docTopic#1{\gdef\@docTopic{#1}}
% \gdef\@docCourse{\texcmd{docCourse}}
% \def\docCourse#1{\gdef\@docCourse{#1}}
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arco-exercise}[2012/02/22 class for student exercises]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\PassOptionsToClass{a4paper, 11pt}{article}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{arco-basics}
\RequirePackage{arco-fonts}
\RequirePackage{arco-hyper}

\graphicspath{{./}{figures/}}

\RequirePackage[margin=3cm]{geometry}

\RequirePackage[%
% colorgrid,
  texcoord]{eso-pic}

\RequirePackage{ifthen}

\RequirePackage[sf,bf,compact,clearempty]{titlesec}

\RequirePackage{arco-color}

\newcommand{\ifcolor}[1]{#1}
\newcommand{\UCLMbglogo}{%
  \ifcolor{%
    \begin{picture}(0,0)
      \put(-55,-820){
        \uclmcolor{\includegraphics[width=1.1\textwidth]{%
            /usr/share/arco/figures/uclm_logo_watermark.pdf}}}
    \end{picture}}}

\newpagestyle{arcoStyle}[\scriptsize\sffamily]{
  \sethead{\gray25color{\docTopic}}
          {\UCLMbglogo}
          {\gray25color{\docCourse}}
  \setfoot{}
    %\gray25color{\today}}
          {\gray25color{\thepage/\pageref{arco:lastpage}}}
          {}
  \headrule
%  \footrule
}
\pagestyle{arcoStyle}


% -- utilities --
\usepackage{amsthm}


\def\mymaketitle{%
  \null
  \normalfont
  \begin{center}
    \leavevmode
    \null
    \smallskip
    {\sffamily\bfseries \LARGE \@title\par}%
    \smallskip
    {\large \@author\par}%
    \smallskip
    {\@date\par}%
  \end{center}%
  \null
}

\renewcommand\maketitle{%
  \let\footnotesize\small%
%  \let\footnoterule\relax%

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
